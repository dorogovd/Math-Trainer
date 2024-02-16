//
//  TrainViewController.swift
//  iOSDev 2.2 - MathTrainer
//
//  Created by Dmitrii Dorogov on 12.02.2024.
//

import UIKit

final class TrainViewController: UIViewController {
    
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var backButtonOutlet: UIButton!
    
    // MARK: - Properties
    var firstNumber = 0
    var secondNumber = 0
    private var sign: String = ""
    private var count: Int = 0 {
        didSet {
            print("Count: \(count)")
        }
    }
    
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multypli:
                sign = "*"
            case .divide:
                sign = "/"
            }
        }
    }
    
    private var answer: Int {
        switch type {
        case .add:
            return firstNumber + secondNumber
        case .subtract:
            return firstNumber - secondNumber
        case .multypli:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureQuestion()
        configureButtons()
    }
    
    // MARK: - Actions
    
    @IBAction func leftButtonAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    @IBAction func rightButtonAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "", for: sender)
    }
    
    // MARK: - Methods
    
    private func configureButtons() {
        buttonsCollection.forEach { button in
            button.backgroundColor = .systemYellow
        }
        // add shadow›
        buttonsCollection.forEach{ button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
        
        //    let randomButton = Int.random(in: 1...2)
        let isRightAnswer = Bool.random()
        var randomAnswer: Int
        repeat {
            randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
        } while randomAnswer == answer
        
        buttonsCollection[0].setTitle(isRightAnswer ? String(answer) : String(randomAnswer), for: .normal)
        buttonsCollection[1].setTitle(isRightAnswer ? String(randomAnswer) : String(answer), for: .normal)
    }
    
    private func configureQuestion() {
        firstNumber = Int.random(in: 0...99)
        secondNumber = Int.random(in: 0...99)
        
        let question: String = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .green : .red
        
        if isRightAnswer {
            var isSecondAttempt = buttonsCollection[1].backgroundColor == .red || buttonsCollection[0].backgroundColor == .red
            count += isSecondAttempt ? 0 : 1
            count += 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.configureQuestion()
                self?.configureButtons()
            }
        }
    }
}
