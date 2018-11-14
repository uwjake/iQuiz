//
//  ViewController.swift
//  iQuiz
//
//  Created by Jake Jin on 10/27/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate{
    
    public static var questions = Questions.Questions()
    public static var currentQuestion = 0
    public static var currentSubject = "Science"
    public static var totalQuestion = 0
    public static var numCorrect = 0
    public static var urlString = ""
    
    var subjectNames = ["Mathematics", "Marvel Super Heroes", "Science"]
    var subjectDescriptions = ["Think yourself as a calculator",
                               "About people that live only in your illusion",
                               "Things that people can expain"]
    var subjectIcons = ["math_icon", "marvel_icon", "science_icon"]
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
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle
    {
        return .none
    }

    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
//        let uiAlert = UIAlertController(title: "Settings Button Pressed", message: "Oops, still under development", preferredStyle: .alert)
//        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        uiAlert.addAction(defaultAction)
//        self.present(uiAlert, animated: true, completion: nil)
        // Load and configure your view controller.
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let optionsVC = storyboard.instantiateViewController(
            withIdentifier: "PopoverViewController")
        
        // Use the popover presentation style for your view controller.
        optionsVC.modalPresentationStyle = .popover
        
        // Specify the anchor point for the popover.
        let popOver = optionsVC.popoverPresentationController
        popOver?.delegate = self
        popOver?.sourceView = view
        popOver?.sourceRect = CGRect(x: self.view.bounds.maxX, y: 100, width: 0, height: 0)
        
        // Present the view controller (in a popover).
        self.present(optionsVC, animated: true) {
            // The popover is visible.
        }
        
    }
    
    // refresh control
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(HomeViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.gray
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...")
//        sleep(1)
        
        return refreshControl
    }()
    
    
    func showToast(message : String, remove_refresher: Bool = false) {
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
            if remove_refresher {
                self.refreshControl.endRefreshing()
            }
            
        })
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
//       print("refreshing")
        showToast(message: "Updaitng", remove_refresher: true)
        loadData()
    }
    
    func loadData(url: String = "https://tednewardsandbox.site44.com/questions.json") {

        let request = URLSession.shared.dataTask(with: URL(string: url)!) {
            (data, response, error) in
            
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    self.loadLocalData()
                    return }
            if error == nil {
                
                do{
                    //here dataResponse received from a network request
                    
                    let jsonResponse = try JSONSerialization.jsonObject(with:
                     dataResponse, options: []) as? [Dictionary<String,AnyObject>]
                    
                    // store locally
                    UserDefaults.standard.set(jsonResponse, forKey: "quiz")
                    
                    self.subjectNames = []
                    self.subjectDescriptions = []
    //                self.subjectIcons = []
                    
                    self.initData(jsonResponse: jsonResponse!)
                    
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            }
        }
        
            request.resume()
      
       
        
    }
    
    func initData(jsonResponse: [Dictionary<String,AnyObject>]) {
        HomeViewController.currentQuestion = 0
        HomeViewController.numCorrect = 0
        HomeViewController.questions = Questions.Questions()
        subjectNames = []
        subjectDescriptions = []
        for subject in jsonResponse {
            let subjectName = subject["title"] as! String
            self.subjectNames.append(subjectName)
            self.subjectDescriptions.append(subject["desc"] as! String)
            for q in subject["questions"] as! [Dictionary<String, AnyObject>] {
                HomeViewController.questions.addQ(subjectName, q["text"] as! String, q["answers"] as! [String], q["answer"] as! String)
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func loadLocalData() {
        var message = "Network error, using local data"
        let localJson = UserDefaults.standard.value(forKey: "quiz")
        if localJson != nil {
            initData(jsonResponse: localJson as! [Dictionary<String, AnyObject>])
        } else {
            message = "Network error, please connect to internet"
        }
        
        let uiAlert = UIAlertController(title: message, message:"", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        uiAlert.addAction(defaultAction)
        self.present(uiAlert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeViewController.currentQuestion = 0
        HomeViewController.numCorrect = 0
        HomeViewController.questions = Questions.Questions()
        HomeViewController.questions.addDefaultQ()
        print("didLoad")
        tableView.addSubview(self.refreshControl)
        tableView?.dataSource = self
        tableView?.delegate = self
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

