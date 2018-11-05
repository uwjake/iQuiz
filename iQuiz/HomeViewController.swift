//
//  ViewController.swift
//  iQuiz
//
//  Created by Jake Jin on 10/27/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    public static var questions = Questions()
    public static var currentQuestion = 0
    public static var currentSubject = "Science"
    
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
    
    
    func constructQuestions(){
        HomeViewController.questions.addQ("Science", "Who is your instructor?", ["Ted","Michael","JJ","Eh... No clue"], 0)
        HomeViewController.questions.addQ("Science", "Which course are your taking?", ["INFO446", "INFO447","INFO448","INFO449"], 3)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "goToQuiz", sender: self)
//    }

    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let uiAlert = UIAlertController(title: "You selected \(subjectNames[row])", message:subjectDescriptions[row] , preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        uiAlert.addAction(defaultAction)
//        self.present(uiAlert, animated: true, completion: nil)
        self.performSegue(withIdentifier: "goToQuiz", sender: self)
        
//        navigationController?.pushViewController(QuestionViewController(), animated: true)


    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueIdentifier" {
            print("I'm segue Identifier!")
            
        }
    }
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        let uiAlert = UIAlertController(title: "Settings Button Pressed", message: "Oops, still under development", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        uiAlert.addAction(defaultAction)
        self.present(uiAlert, animated: true, completion: nil)
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        constructQuestions()
        print(HomeViewController.questions.data["Science"]?[0].options)
//        self.navigationController?.navigationBar.isHidden = false;
//        self.navigationController?.interactivePopGestureRecognizer!.isEnabled = true
        
        tableView?.dataSource = self
        tableView?.delegate = self
        
      
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }


}

