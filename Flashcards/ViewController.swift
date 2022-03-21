//
//  ViewController.swift
//  Flashcards
//
//  Created by Vi-Linh Vu on 2/26/22.
//

import UIKit

struct FlashCard{
    var question: String
    var answer: String
    var xAnswer1: String
    var xAnswer2: String
}

class ViewController: UIViewController {

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    var flashcards = [FlashCard]()
    var currentIndex = 0
    
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var Labels: UIView!
    
    @IBOutlet weak var Answer1: UIButton!
    @IBOutlet weak var Answer2: UIButton!
    @IBOutlet weak var Answer3: UIButton!

    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var multChoiceButton: UIButton!
    
    var mc = true
    
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
        
        readSavedFlashcards()
                
        if flashcards.count == 0 {
            updateFlashCard(question: "What does R5 point at in a stackframe?", answer0: "The top of the stack", answer1: "The first local variable", answer2: "The bottom of the stack", isExisting: false)
        } else {
            updateLabels()
            updatePrevNextButtons()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //destination = screen we are going to
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        //specify what flashcardController (in CreationViewController)  actually is (there can be multiple "ViewController"s
        creationController.flashcardController = self
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer0 = Answer1.currentTitle
            creationController.initialAnswer1 = Answer2.currentTitle
            creationController.initialAnswer2 = Answer3.currentTitle
            
        }
    }
    
    @IBAction func didTapOnMultChoice(_ sender: Any) {
        if mc {
            multChoiceButton.setTitle("⥥", for: .normal)
            Answer1.isHidden = true
            Answer2.isHidden = true
            Answer3.isHidden = true
        } else {
            multChoiceButton.setTitle("⥣", for: .normal)
            Answer1.isHidden = false
            Answer2.isHidden = false
            Answer3.isHidden = false
        }
        
        mc = !mc
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
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex -= 1
        updateLabels()
        updatePrevNextButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex += 1
        updateLabels()
        updatePrevNextButtons()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            action in self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func deleteCurrentFlashcard(){
        //delete current
        flashcards.remove(at: currentIndex)
        
        //if last card was deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        updatePrevNextButtons()
        updateLabels()
        saveAllFlashcardstoDisk()
    }
    
    func updateFlashCard(question: String, answer0: String, answer1: String, answer2: String, isExisting: Bool){
        let flashcard = FlashCard(question: question, answer: answer0, xAnswer1: answer1, xAnswer2: answer2)
        
        if isExisting {
            flashcards[currentIndex] = flashcard
        } else {
            flashcards.append(flashcard)
            print("Added a new flashcard")
            print("We now have \(flashcards.count) flashcards")
            currentIndex = flashcards.count - 1
            print("Current index is \(currentIndex)")
        }
        
        updatePrevNextButtons()
        
        updateLabels()
        
        saveAllFlashcardstoDisk()
    }
    
    func updatePrevNextButtons(){
        
        //disable next button if at end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        //disable prev button if at start
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
        
        //dont allow delete if only 1 card left
        if flashcards.count == 1 {
            deleteButton.isEnabled = false
        } else {
            deleteButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        let currFlashcard = flashcards[currentIndex]
        
        questionLabel.text = currFlashcard.question
        answerLabel.text = currFlashcard.answer
        
        if mc {
            Answer1.isHidden = false
            Answer2.isHidden = false
            Answer3.isHidden = false
        }
        
        Answer1.setTitle(currFlashcard.xAnswer1, for: .normal)
        Answer2.setTitle(currFlashcard.answer, for: .normal)
        Answer3.setTitle(currFlashcard.xAnswer2, for: .normal)
        
    }
    
    func saveAllFlashcardstoDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String:String] in
            return ["question": card.question, "answer": card.answer, "xAnswer1": card.xAnswer1, "xAnswer2": card.xAnswer2 ]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            let savedCards = dictionaryArray.map { dictionary -> FlashCard in
                return FlashCard(question: dictionary["question"]!, answer: dictionary["answer"]!, xAnswer1: dictionary["xAnswer1"]!, xAnswer2: dictionary["xAnswer2"]!)
            }
            
            flashcards.append(contentsOf: savedCards)
        }
    }
}

