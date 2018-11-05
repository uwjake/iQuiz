//
//  ViewController.swift
//  iQuiz
//
//  Created by Jake Jin on 11/4/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit


class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let subjectNames = HomeViewController.questions.data[HomeViewController.currentSubject]?[HomeViewController.currentQuestion].options
//    let subjectNames = ["1","3"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectNames?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = UITableViewCell(style: .subtitle, reuseIdentifier: "Row")
        row.textLabel?.text = subjectNames?[indexPath.row]
        row.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return row
    }
    
    
    @IBAction func onSubmit(_ sender: Any) {
        HomeViewController.currentQuestion += 1
        print(HomeViewController.currentQuestion)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        questionsTableView?.dataSource = self
        questionsTableView?.delegate = self
        questionsTableView?.tableFooterView = UIView(frame: CGRect.zero)
        
//        print(HomeViewController.questions.data)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)

        print("quiz loaded")
        // Do any additional setup after loading the view.
    }


    @IBOutlet weak var questionsTableView: UITableView!
    
    
    //

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                performSegue(withIdentifier: "backToHome", sender: self)
                print("Swiped right")
            case UISwipeGestureRecognizer.Direction.left:

                print("Swiped left")
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
