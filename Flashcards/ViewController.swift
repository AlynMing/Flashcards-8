//
//  ViewController.swift
//  Flashcards
//
//  Created by Jenafer Morton on 2/8/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Answer: UILabel!
    @IBOutlet weak var Question: UILabel!
    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var topAnswer: UIButton!
    @IBOutlet weak var middleAnswer: UIButton!
    @IBOutlet weak var bottomAnswer: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Answer.clipsToBounds =  true
        Question.clipsToBounds =  true
        //Cut out the label area thats not in the view
        
        cardContainer.layer.cornerRadius = 20.0
        Question.layer.cornerRadius = 20.0
        Answer.layer.cornerRadius = 20.0
        //Round Corners
        
        cardContainer.layer.shadowRadius = 15.0 // Add shadow
        cardContainer.layer.shadowOpacity = 0.7 //Make shadow visible
        
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
    

    @IBAction func didTapFlashcard(_ sender: Any) {
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
    }
}

