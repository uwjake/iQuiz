//
//  Questions.swift
//  iQuiz
//
//  Created by Jake Jin on 11/4/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class Questions: NSObject {
    
    public var data = [String: [Question]]()
    
    public var currentQuestion = 0
    
    func addQ (_ subject: String, _ question:String, _ options: [String], _ answer:Int) {
        if data[subject] != nil {
            data[subject]!.append( Question(question, options, answer) )
        } else {
            data[subject] = [( Question(question, options, answer) )]
        }
       
    }
    
}

struct Question {
    var question: String
    var options: [String]
    var answer: Int
    
    init(_ question: String, _ options: [String], _ answer: Int){
        self.question = question
        self.options = options
        self.answer = answer
        
    }
}
