//
//  ViewController.swift
//  iQuiz
//
//  Created by Jake Jin on 11/4/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit


class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var currentQuiz: Question = (HomeViewController.questions.data[HomeViewController.currentSubject]?[HomeViewController.currentQuestion])!
    var answerChosen:Int = -1
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuiz.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = UITableViewCell(style: .subtitle, reuseIdentifier: "Row")
        row.textLabel?.text = currentQuiz.options[indexPath.row]
        row.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return row
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        answerChosen = indexPath.row
    }
    
    @IBAction func onSubmit(_ sender: Any) {
       submitAnswer()
       
    }
    
    @IBAction func onHomePressed(_ sender: Any) {
        backToHome()
    }
    func submitAnswer(){
        if answerChosen == -1 {
            let uiAlert = UIAlertController(title: "Please select an answer to proceed", message: "" , preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            uiAlert.addAction(defaultAction)
            self.present(uiAlert, animated: true, completion: nil)
            
        } else {
            AnswerViewController.answerChosen = answerChosen
            performSegue(withIdentifier: "QuestionToAnswer", sender: self)
        }
    }
    
    func backToHome(){
        performSegue(withIdentifier: "backToHome", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        questionsTableView?.dataSource = self
        questionsTableView?.delegate = self
        questionsTableView?.tableFooterView = UIView(frame: CGRect.zero)
        
        questionLabel.text = currentQuiz.question
        
        HomeViewController.totalQuestion = (HomeViewController.questions.data[HomeViewController.currentSubject]?.count)!
        
        naviTitle.title = "\(HomeViewController.currentSubject): \(HomeViewController.currentQuestion + 1) / \(HomeViewController.totalQuestion)"
//        print(HomeViewController.questions.data)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)

        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var questionsTableView: UITableView!
    
    
    @IBOutlet weak var naviTitle: UINavigationItem!
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                backToHome()
//                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.left:
                submitAnswer()
//                print("Swiped left")
            default:
                break
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
