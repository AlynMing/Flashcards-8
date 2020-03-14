//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Jenafer Morton on 2/29/20.
//  Copyright © 2020 John Jakobsen. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    @IBOutlet weak var QuestionInput: UITextField!
    @IBOutlet weak var Answer1: UITextField!
    @IBOutlet weak var Answer3: UITextField!
    @IBOutlet weak var Answer2: UITextField!
    var initialQuestion: String?
    var initialAnswer1: String?
    var initialAnswer2: String?
    var initialAnswer3: String?
    var isExisting: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        QuestionInput.text = initialQuestion
        Answer1.text = initialAnswer1
        Answer2.text = initialAnswer2
        Answer3.text = initialAnswer3
        isExisting = false
        if initialQuestion != nil || initialQuestion != "" {
            isExisting = true
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = QuestionInput.text
        let Answer1Text = Answer1.text
        let Answer2Text = Answer2.text
        let Answer3Text = Answer3.text
        
        if questionText == nil || Answer1Text == nil || Answer2Text == nil || Answer3Text == nil || questionText == "" || Answer1Text == "" || Answer2Text == "" || Answer3Text == "" {
            let alert = UIAlertController(title: "Missing text", message: "Please enter all fields", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
        
            flashcardsController.updateFlashcard(question: questionText!, answer1: Answer1Text!, answer2: Answer2Text!, answer3: Answer3Text!, isExisting: isExisting)
        
        dismiss(animated: true)
        }
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
