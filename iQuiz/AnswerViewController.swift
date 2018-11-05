//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Jake Jin on 11/4/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
     var currentQuiz: Question = (HomeViewController.questions.data[HomeViewController.currentSubject]?[HomeViewController.currentQuestion])!
    static var answerChosen = -1
    var answerCorrect:Bool = false
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    
    @IBOutlet weak var answerIndicatorLabel: UILabel!
    @IBOutlet weak var naviTitle: UINavigationItem!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuiz.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = UITableViewCell(style: .subtitle, reuseIdentifier: "Row")
        var icon = ""
        if indexPath.row == currentQuiz.answer {
            icon = "correct_icon"
        } else if indexPath.row == AnswerViewController.answerChosen && !answerCorrect {
            icon = "wrong_icon"
        }
        row.accessoryType = .none
        row.textLabel?.text = currentQuiz.options[indexPath.row]
        row.imageView?.image = UIImage(named: icon)
        row.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return row
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        optionsTableView.tableFooterView = UIView(frame: CGRect.zero)
        
        questionLabel.text = currentQuiz.question
        answerCorrect = currentQuiz.answer == AnswerViewController.answerChosen
        naviTitle.title = "\(HomeViewController.currentSubject): \(HomeViewController.currentQuestion + 1) / \(HomeViewController.totalQuestion)"
        
        if (answerCorrect) {
            answerIndicatorLabel.text = "Good job, you are right!"
            HomeViewController.numCorrect += 1
        } else {
            answerIndicatorLabel.text = "Sorry, wrong answer..."
            answerIndicatorLabel.textColor = .red
        }
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                backToHome()
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.left:
                nextButtonEvent()
                print("Swiped left")
            default:
                break
            }
        }
    }
    func backToHome(){
        performSegue(withIdentifier: "AnswerToHome", sender: self)
    }
    
    func nextButtonEvent(){
        HomeViewController.currentQuestion += 1
        if HomeViewController.currentQuestion < (HomeViewController.questions.data[HomeViewController.currentSubject]?.count)!
        {
            performSegue(withIdentifier: "AnswerToQuestion", sender: self)
        } else {
            performSegue(withIdentifier: "AnswerToResults", sender: self)
        }
    }
    
    @IBAction func onNextPressed(_ sender: UIButton) {
        nextButtonEvent()
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
