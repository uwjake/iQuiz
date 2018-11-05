//
//  ViewController.swift
//  iQuiz
//
//  Created by Jake Jin on 11/4/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let subjectNames = ["Mathematics", "Marvel Super Heroes", "Science"]
    let subjectDescriptions = ["Think yourself as a calculator",
                               "About people that live only in your illusion",
                               "Things that people can expain"]
    let subjectIcons = ["math_icon", "marvel_icon", "science_icon"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = UITableViewCell(style: .subtitle, reuseIdentifier: "Row")
        row.imageView?.image = UIImage(named: subjectIcons[indexPath.row])
        row.textLabel?.text = subjectNames[indexPath.row]
        row.detailTextLabel?.text = subjectDescriptions[indexPath.row]
        row.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return row
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        questionsTableView.tableFooterView = UIView(frame: CGRect.zero)
        questionsTableView.dataSource = self
        questionsTableView.delegate = self
        
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
