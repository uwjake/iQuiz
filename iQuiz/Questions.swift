//
//  Questions.swift
//  iQuiz
//
//  Created by Jake Jin on 11/4/18.
//  Copyright © 2018 Jake Jin. All rights reserved.
//

import UIKit

class Questions: NSObject {
    
   
    struct Questions {
        var data = [String: [Question]]()
        var scores = [String: Int]()
        var currentQuestion = 0
        
        init() {
            
//            let file = "file.txt" //this is the file. we will write to and read from it
//
//            let text = "some text" //just a text
//
//            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//
//                let fileURL = dir.appendingPathComponent(file)
//
//                //writing
//                do {
//                    try text.write(to: fileURL, atomically: false, encoding: .utf8)
//                }
//                catch {/* error handling here */}
//
//                //reading
//                do {
//                    let text2 = try String(contentsOf: fileURL, encoding: .utf8)
//                    print("reading  " + text2)
//                }
//                catch {/* error handling here */}
//            }
      
        }
        mutating func addQ (_ subject: String, _ question:String, _ options: [String], _ answer: String) {
            let answerInt = Int(answer)! - 1
            if data[subject] != nil {
                data[subject]!.append( Question(question, options, answerInt) )
                scores[subject] = 0
            } else {
                data[subject] = [ Question(question, options, answerInt) ]
            }
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
