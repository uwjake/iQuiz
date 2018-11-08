//
//  ViewController.swift
//  iQuiz
//
//  Created by Jake Jin on 10/27/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public static var questions = Questions.Questions()
    public static var currentQuestion = 0
    public static var currentSubject = "Science"
    public static var totalQuestion = 0
    public static var numCorrect = 0
    
    let subjectNames = ["Mathematics", "Marvel Super Heroes", "Science"]
    let subjectDescriptions = ["Think yourself as a calculator",
                               "About people that live only in your illusion",
                               "Things that people can expain"]
    let subjectIcons = ["math_icon", "marvel_icon", "science_icon"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectNames.count
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = UITableViewCell(style: .subtitle, reuseIdentifier: "Row")
        row.imageView?.image = UIImage(named: subjectIcons[indexPath.row])
        row.textLabel?.text = subjectNames[indexPath.row]
        row.detailTextLabel?.text = subjectDescriptions[indexPath.row]
        row.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        
        return row
    }
    


    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        HomeViewController.currentSubject = subjectNames[indexPath.row]
        self.performSegue(withIdentifier: "goToQuiz", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "SegueIdentifier" {
//            print("I'm segue Identifier!")
//        }
//    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        let uiAlert = UIAlertController(title: "Settings Button Pressed", message: "Oops, still under development", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        uiAlert.addAction(defaultAction)
        self.present(uiAlert, animated: true, completion: nil)
    }
    
    // refresh control
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(HomeViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...")
        sleep(1)
        
        return refreshControl
    }()
    
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            
            self.refreshControl.endRefreshing()
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
//       print("refreshing")
        showToast(message: "Updaitng")
    }
    
    func loadData(url: String = "https://tednewardsandbox.site44.com/questions.json") {
        let request = URLSession.shared.dataTask(with: URL(string: url)!) {
            (data, response, error) in
            
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                 dataResponse, options: []) as? [Dictionary<String,AnyObject>]
                HomeViewController.questions.changeData(jsonResponse!) //Response result
            } catch let parsingError {
                print("Error", parsingError)
            }
            
        }.resume()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeViewController.currentQuestion = 0
        HomeViewController.numCorrect = 0
        HomeViewController.questions = Questions.Questions()
        print("didLoad")
        tableView.addSubview(self.refreshControl)
        tableView?.dataSource = self
        tableView?.delegate = self
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

