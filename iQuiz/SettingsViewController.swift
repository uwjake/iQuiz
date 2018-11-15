//
//  SettingsViewController.swift
//  iQuiz
//
//  Created by Jake Jin on 11/14/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var quizURL: UITextField!
    @IBOutlet weak var autoRefreshOn: UISwitch!
    @IBOutlet weak var autoRefreshInterval: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = UserDefaults.standard
        quizURL.insertText(settings.string(forKey: "quiz_url") ?? "https://tednewardsandbox.site44.com/questions.json")
        autoRefreshOn.isOn = settings.bool(forKey: "auto_refresh_on")
        autoRefreshInterval.text = settings.string(forKey: "auto_refresh_interval")
        
//        print("did load" ,settings.value(forKey: "quiz_url"))
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func onCheckNowPressed(_ sender: UIButton) {
        
        let stanDefaults = UserDefaults.standard
        
        stanDefaults.set(quizURL.text ?? "https://tednewardsandbox.site44.com/questions.json", forKey: "quiz_url")
        stanDefaults.set(autoRefreshOn.isOn, forKey: "auto_refresh_on")
        stanDefaults.set(autoRefreshInterval.text ?? "", forKey: "auto_refresh_interval")
        
        
        HomeViewController.urlString = quizURL.text ?? ""
        
//        print("set", stanDefaults.value(forKey: "quiz_url"))
        
        performSegue(withIdentifier: "settingsToHome", sender: sender)
    }
    
    
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
