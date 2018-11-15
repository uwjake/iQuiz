//
//  PopoverViewController.swift
//  iQuiz
//
//  Created by Jake Jin on 11/11/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        subjectLabel.text = HomeViewController.currentSubject
        scoreLabel.text = "\(HomeViewController.numCorrect) / \(HomeViewController.totalQuestion) correct"
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var subjectLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        let tmpController :UIViewController! = self
        
        self.dismiss(animated: false, completion: {()->Void in
            tmpController.dismiss(animated: false, completion: nil);
        });
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
