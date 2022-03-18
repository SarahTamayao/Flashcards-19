//
//  ViewController.swift
//  Flashcards
//
//  Created by Vi-Linh Vu on 2/26/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var Labels: UIView!
    
    @IBOutlet weak var Answer1: UIButton!
    @IBOutlet weak var Answer2: UIButton!
    @IBOutlet weak var Answer3: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        Labels.layer.cornerRadius = 20.0
        Labels.clipsToBounds = true
        
        questionLabel.layer.cornerRadius = 20.0
        answerLabel.layer.cornerRadius = 20.0
        questionLabel.clipsToBounds = true
        answerLabel.clipsToBounds = true
        
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer0 = Answer1.currentTitle
            creationController.initialAnswer1 = Answer2.currentTitle
            creationController.initialAnswer2 = Answer3.currentTitle
            
        }
    }
    
    @IBAction func didTapOnFlashCard(_ sender: Any) {
        questionLabel.isHidden = !questionLabel.isHidden
    }
    
    @IBAction func didTapAnswerOne(_ sender: Any) {
        Answer1.isHidden = true
    }
    
    @IBAction func didTapAnswer2(_ sender: Any) {
        questionLabel.isHidden = true
    }
    
    @IBAction func didTapAnswer3(_ sender: Any) {
        Answer3.isHidden = true
    }
    
    func updateFlashCard(question: String, answer0: String, answer1: String, answer2: String){
        questionLabel.text = question;
        answerLabel.text = answer1;
        
        Answer1.setTitle(answer0, for: .normal)
        Answer2.setTitle(answer1, for: .normal)
        Answer3.setTitle(answer2, for: .normal)
    }
}

