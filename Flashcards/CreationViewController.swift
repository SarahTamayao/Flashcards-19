//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Vi-Linh Vu on 3/12/22.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func didTapOnDone(_ sender: Any) {
        
        let answerText = answerTextField.text
        let questionText = questionTextField.text
        
        flashcardController.updateFlashCard(question: questionText!, answer: answerText!)
        
        dismiss(animated: true)
    }
    
}
