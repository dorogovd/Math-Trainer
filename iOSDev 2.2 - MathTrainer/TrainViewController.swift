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
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    @IBOutlet weak var backButtonOutlet: UIButton!
    
    // MARK: - Properties
    var firstNumber = 0
    var secondNumber = 0
    private var sign: String = ""
    var count: Int = 0
    
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
        // add shadow
        buttonsCollection.forEach{ button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
        
        let isRightAnswer = Bool.random()
        var randomAnswer: Int
        
            repeat {
                randomAnswer = Int.random(in: (answer - 10)...(answer + 10))
            } while randomAnswer == answer

            buttonsCollection[0].setTitle(isRightAnswer ? String(answer) : String(randomAnswer), for: .normal)
            buttonsCollection[1].setTitle(isRightAnswer ? String(randomAnswer) : String(answer), for: .normal)
        }
        //    } while randomAnswer % 2 == 0 && answer % 2 == 0 && randomAnswer == answer

    
    private func configureQuestion() {
        switch sign {
        case "/":
            firstNumber = Int.random(in: 2...99)
            secondNumber = Int.random(in: 1..<firstNumber)

            while firstNumber % secondNumber != 0 {
                firstNumber = Int.random(in: 2...99)
                secondNumber = Int.random(in: 1..<firstNumber)
            }
        case "*":
            firstNumber = Int.random(in: 1...99)
            secondNumber = Int.random(in: 1...10)
        default:
            firstNumber = Int.random(in: 1...99)
            secondNumber = Int.random(in: 1...99)
        }
        
        let question: String = "\(firstNumber) \(sign) \(secondNumber) ="
        questionLabel.text = question
    }
    
    private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .green : .red
        
        let isSecondAttempt = buttonsCollection[1].backgroundColor == .red || buttonsCollection[0].backgroundColor == .red
        count += isSecondAttempt ? 0 : 1
        
        if count < 10 {
            countLabel.text = "SCORE: 0\(count)"
        } else {
            countLabel.text = "SCORE: \(count)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.configureQuestion()
            self?.configureButtons()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? ViewController {
            if type == .add {
                viewController.scoreLabelCollection[0].text = String(count)
            } else if type == .subtract {
                viewController.scoreLabelCollection[1].text = String(count)
            } else if type == .multypli {
                viewController.scoreLabelCollection[2].text = String(count)
            } else {
                viewController.scoreLabelCollection[3].text = String(count)
            }
        }
    }
}
