//
//  TrainViewController.swift
//  iOSDev 2.2 - MathTrainer
//
//  Created by Dmitrii Dorogov on 12.02.2024.
//

import UIKit

final class TrainViewController: UIViewController {
    
    // MARK: - Properties
    private var firstNumber = 0
    private var secondNumber = 0
    private var sign: String = ""
    private var count: Int = 0
    
    public var completion: ((MathTypes, Int) -> Void)? // ???
    
    var type: MathTypes = .add {
        didSet {
            switch type {
            case .add:
                sign = "+"
            case .subtract:
                sign = "-"
            case .multiply:
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
        case .multiply:
            return firstNumber * secondNumber
        case .divide:
            return firstNumber / secondNumber
        }
    }
    
    private lazy var firstAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 40
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 3
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(TrainViewController.leftAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var secondAnswerButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 40
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 3
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(TrainViewController.rightAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemYellow, for: .normal)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.layer.shadowColor = UIColor.darkGray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 3
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        return button
    }()
    
    private var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: 00"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "30 + 2 = "
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureQuestion()
        updateButtons()
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        
        view.backgroundColor = .white
        view.addSubview(firstAnswerButton)
        view.addSubview(secondAnswerButton)
        view.addSubview(questionLabel)
        view.addSubview(scoreLabel)
        view.addSubview(backButton)
        
// create firstAnswerButton
        let firstAnswerButtonLeftConstraint = NSLayoutConstraint(item: firstAnswerButton, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 100)
        
        let firstAnswerButtonBottomConstraint = NSLayoutConstraint(item: firstAnswerButton, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: -180)

        let firstAnswerButtonHeightConstraint = NSLayoutConstraint(item: firstAnswerButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.12, constant: 0)
        
        let firstAnswerButtonWidthConstraint = NSLayoutConstraint(item: firstAnswerButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstAnswerButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
// create secondAnswerButton
        let secondAnswerButtonRightConstraint = NSLayoutConstraint(item: secondAnswerButton, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: -100)
        
        let secondAnswerButtonBottomConstraint = NSLayoutConstraint(item: secondAnswerButton, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstAnswerButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        
        let secondAnswerButtonHeightConstraint = NSLayoutConstraint(item: secondAnswerButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstAnswerButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
        let secondAnswerButtonWidthConstraint = NSLayoutConstraint(item: secondAnswerButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstAnswerButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
// create questionLabel
        let questionLabelLeftConstraint = NSLayoutConstraint(item: questionLabel, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        
        let questionLabelRightConstraint = NSLayoutConstraint(item: questionLabel, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        
        let questionLabelButtonBottomConstraint = NSLayoutConstraint(item: questionLabel, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstAnswerButton, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: -60)
        
// create scoreLabel
        let scoreLabelRightConstraint = NSLayoutConstraint(item: scoreLabel, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: -50)
        
        let scoreLabelTopConstraint = NSLayoutConstraint(item: scoreLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 50)
        
// create backButton
        let backButtonLeftConstraint = NSLayoutConstraint(item: backButton, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 40)
        
        let backButtonTopConstraint = NSLayoutConstraint(item: backButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 45)
        
        let backButtonWidthConstraint = NSLayoutConstraint(item: backButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.2, constant: 0)
        
        self.view.addConstraints([firstAnswerButtonLeftConstraint, firstAnswerButtonBottomConstraint, firstAnswerButtonHeightConstraint, firstAnswerButtonWidthConstraint, secondAnswerButtonRightConstraint, secondAnswerButtonBottomConstraint, secondAnswerButtonHeightConstraint, secondAnswerButtonWidthConstraint, questionLabelLeftConstraint, questionLabelRightConstraint, questionLabelButtonBottomConstraint, scoreLabelTopConstraint, scoreLabelRightConstraint, backButtonTopConstraint, backButtonLeftConstraint, backButtonWidthConstraint])
    }
    
    // MARK: - Actions
    
    @objc private func leftAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    
    @objc private func rightAction(_ sender: UIButton) {
        check(answer: sender.titleLabel?.text ?? "",
              for: sender)
    }
    
    // MARK: - Methods
    
    @objc private func tapBackButton() {
        
        completion?(type, count) // COMPLETION
    
        let mainVC = ViewController()
        mainVC.modalPresentationStyle = .fullScreen
        mainVC.modalTransitionStyle = .crossDissolve
        
        dismiss(animated: true)
    }
    
    private func updateButtons() {
        let buttonsCollection = [firstAnswerButton, secondAnswerButton]
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

            firstAnswerButton.setTitle(isRightAnswer ? String(answer) : String(randomAnswer), for: .normal)
            secondAnswerButton.setTitle(isRightAnswer ? String(randomAnswer) : String(answer), for: .normal)
        }
    
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
    
    @objc private func check(answer: String, for button: UIButton) {
        let isRightAnswer = Int(answer) == self.answer
        
        button.backgroundColor = isRightAnswer ? .systemGreen : .systemRed
        
        let isSecondAttempt = secondAnswerButton.backgroundColor == .systemRed || firstAnswerButton.backgroundColor == .systemRed
        count += isSecondAttempt ? 0 : 1
        
        if count < 10 {
            scoreLabel.text = "SCORE: 0\(count)"
        } else {
            scoreLabel.text = "SCORE: \(count)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.configureQuestion()
            self?.updateButtons()
        }
    }
}
