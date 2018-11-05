//
//  ResultViewController.swift
//  iQuiz
//
//  Created by Jake Jin on 11/4/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectLabel.text = HomeViewController.currentSubject
        resultLabel.text = "\(HomeViewController.numCorrect) out of \(HomeViewController.totalQuestion) correct"
        // Do any additional setup after loading the view.
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
