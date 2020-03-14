//
//  ViewController.swift
//  Flashcards
//
//  Created by Jenafer Morton on 2/8/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var correctAnswer: String
    var otherAnswers: Array <String>
}

class ViewController: UIViewController {

    @IBOutlet weak var Answer: UILabel!
    @IBOutlet weak var Question: UILabel!
    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var topAnswer: UIButton!
    @IBOutlet weak var middleAnswer: UIButton!
    @IBOutlet weak var bottomAnswer: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    var Flashcards = [Flashcard]()
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        readSavedFlashcards()
        if Flashcards.count == 0 {
            updateFlashcard(question: "Whats the capital of Norway?", answer1: "Bergen", answer2: "Stravanger", answer3: "Oslo", isExisting: false)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        //Aesthetics
        Answer.clipsToBounds =  true
        Question.clipsToBounds =  true
        cardContainer.layer.cornerRadius = 20.0
        Question.layer.cornerRadius = 20.0
        Answer.layer.cornerRadius = 20.0 //Round Corners
        cardContainer.layer.shadowRadius = 15.0 // A shadow
        cardContainer.layer.shadowOpacity = 0.7
        topAnswer.layer.borderWidth = 3.0
        topAnswer.layer.borderColor = #colorLiteral(red: 0.8273518778, green: 0.8797557677, blue: 0.9898599417, alpha: 1)
        topAnswer.layer.cornerRadius = 20.0
        middleAnswer.layer.borderWidth = 3.0
        middleAnswer.layer.borderColor = #colorLiteral(red: 0.8273518778, green: 0.8797557677, blue: 0.9898599417, alpha: 1)
        middleAnswer.layer.cornerRadius = 20.0
        bottomAnswer.layer.borderWidth = 3.0
        bottomAnswer.layer.borderColor = #colorLiteral(red: 0.8273518778, green: 0.8797557677, blue: 0.9898599417, alpha: 1)
        bottomAnswer.layer.cornerRadius = 20.0
        
    }
    
    func deleteCurrentFlashCard() {
        if Flashcards.count > 1 {
            Flashcards.remove(at: currentIndex)
            currentIndex = currentIndex - 1
            updateLabels()
            updateNextPrevButtons()
            saveAllFlashcardsToDisk()
        }
    }
    
    @IBAction func didTapDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
            action in
            self.deleteCurrentFlashCard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = Question.text
            creationController.initialAnswer1 = topAnswer.currentTitle
            creationController.initialAnswer2 = middleAnswer.currentTitle
            creationController.initialAnswer3 = bottomAnswer.currentTitle
        }
    }
    
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "Flashcards") as? [[String: String]] {
            
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard (
                    question: dictionary["question"]!,
                    correctAnswer: dictionary["correctAnswer"]!,
                    otherAnswers: dictionary["answers"]!.components(separatedBy: "981756")
                )
            }
            Flashcards.append(contentsOf: savedCards)
        }
    }
    
    func saveAllFlashcardsToDisk() {
        
        let dictionaryArray = Flashcards.map { (card) -> [String: String] in
            let answers = card.otherAnswers[0] + "981756" + card.otherAnswers[1]
            return ["question":card.question, "correctAnswer": card.correctAnswer, "answers": answers]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "Flashcards")
    }
    
    func updateFlashcard(question: String, answer1: String, answer2: String!, answer3: String!, isExisting: Bool) {
        let flashcard = Flashcard(question: question, correctAnswer: answer3, otherAnswers: [answer1, answer2])
        if isExisting {
            Flashcards[currentIndex] = flashcard
            updateLabels()
            saveAllFlashcardsToDisk()
        } else {
        Flashcards.append(flashcard)
        currentIndex = Flashcards.count - 1
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
        }
    }

    @IBAction func didTapCardContainer(_ sender: Any) {
        Question.isHidden = !Question.isHidden
        topAnswer.layer.isHidden = false
        middleAnswer.layer.isHidden = false
    }
    
    @IBAction func didTapTop(_ sender: Any) {
        topAnswer.layer.isHidden = true
    }
    @IBAction func didTapMiddle(_ sender: Any) {
        middleAnswer.layer.isHidden = true
    }
    @IBAction func didTapBottom(_ sender: Any) {
        Question.layer.isHidden = true
        topAnswer.layer.isHidden = true
        middleAnswer.layer.isHidden = true
    }
    
    func updateNextPrevButtons() {
        switch currentIndex {
        case 0:
            prevButton.isEnabled = false
        default:
            prevButton.isEnabled = true
        }
        switch currentIndex {
        case Flashcards.count-1:
            nextButton.isEnabled = false
        default:
            nextButton.isEnabled = true
        }
    }
    
    func updateLabels() {
        let currentFlashcard = Flashcards[currentIndex]
        
        Question.text = currentFlashcard.question
        Answer.text = currentFlashcard.correctAnswer
        topAnswer.setTitle(currentFlashcard.otherAnswers[0], for: .normal)
        middleAnswer.setTitle(currentFlashcard.otherAnswers[1], for: .normal)
        bottomAnswer.setTitle(currentFlashcard.correctAnswer, for: .normal)
    }
    
    @IBAction func didTapPrev(_ sender: Any) {
        currentIndex -= 1
        updateLabels()
        updateNextPrevButtons()
    }
    @IBAction func didTapNext(_ sender: Any) {
        currentIndex += 1
        updateLabels()
        updateNextPrevButtons()
    }
}

