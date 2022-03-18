//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Vi-Linh Vu on 3/12/22.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardController: ViewController!
    var initialQuestion: String?
    var initialAnswer0: String?
    var initialAnswer1: String?
    var initialAnswer2: String?
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var exAnswer1: UITextField!
    @IBOutlet weak var exAnswer2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer0
        exAnswer1.text = initialAnswer1
        exAnswer2.text = initialAnswer2

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let answerText = answerTextField.text
        let questionText = questionTextField.text
        let ans1 = exAnswer1.text
        let ans2 = exAnswer2.text
        
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer.", preferredStyle:.alert);
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            
            alert.addAction(okAction)
            
            present(alert, animated: true)
        } else {
            flashcardController.updateFlashCard(question: questionText!, answer0: answerText!, answer1: ans1!, answer2: ans2!)
        }
        
        dismiss(animated: true)
    }
    
    
}
