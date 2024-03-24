//
//  ViewController.swift
//  iOSDev 2.2 - MathTrainer
//
//  Created by Dmitrii Dorogov on 09.02.2024.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multiply, divide
}

class ViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private let mathTrainerLabel: UILabel = {
        let label = UILabel()
        label.text = "Math Trainer"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 40)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to train?"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var scoreLabel1: UILabel = {
        let label = UILabel()
        return label
    }()
    var scoreLabel2: UILabel = {
        let label = UILabel()
        return label
    }()
    var scoreLabel3: UILabel = {
        let label = UILabel()
        return label
    }()
    var scoreLabel4: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.tag = 0
        button.setTitle("+", for: .normal)
        return button
    }()
    
    private lazy var subtractButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setTitle("-", for: .normal)
        return button
    }()
    
    private lazy var multypliButton: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.setTitle("*", for: .normal)
        button.contentVerticalAlignment = .bottom
        return button
    }()
    
    private lazy var divideButton: UIButton = {
        let button = UIButton()
        button.tag = 3
        button.setTitle("/", for: .normal)
        return button
    }()
    
//    var buttonsCollection: [UIButton] = [addButton, subtractButton]
    
    // MARK: - Properties
    
    private var selectedType: MathTypes = .add
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureButtons()
        configureScoreLabels()
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        
        view.backgroundColor = .white
        view.addSubview(mathTrainerLabel)
        view.addSubview(subLabel)
        view.addSubview(addButton)
        view.addSubview(subtractButton)
        view.addSubview(scoreLabel1)
        view.addSubview(scoreLabel2)
        view.addSubview(multypliButton)
        view.addSubview(divideButton)
        view.addSubview(scoreLabel3)
        view.addSubview(scoreLabel4)
        
// create mathTrainerLabel
        let mathTrainerLabelLeftConstraint = NSLayoutConstraint(item: mathTrainerLabel, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        
        let mathTrainerLabelTopConstraint = NSLayoutConstraint(item: mathTrainerLabel, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 180)
        
        let mathTrainerLabelRightConstraint = NSLayoutConstraint(item: mathTrainerLabel, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        
        let verticalMathTrainerLabelConstraint = NSLayoutConstraint(item: mathTrainerLabel, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subLabel, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: -40)
        
// create sublabel
        let subLabelLeftConstraint = NSLayoutConstraint(item: subLabel, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        
        let subLabelRightConstraint = NSLayoutConstraint(item: subLabel, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        
// create addButton
        let addButtonLeftConstraint = NSLayoutConstraint(item: addButton, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subLabel, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 100)
        
        let addButtonVerticalConstraint = NSLayoutConstraint(item: addButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 40)
        
        let addButtonHeightConstraint = NSLayoutConstraint(item: addButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.12, constant: 0)
        
        let addButtonWidthtConstraint = NSLayoutConstraint(item: addButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
// create subtractButton
        let subtractButtonRightConstraint = NSLayoutConstraint(item: subtractButton, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subLabel, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: -100)
        
        let subtractButtonVerticalConstraint = NSLayoutConstraint(item: subtractButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subLabel, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 40)
        
        let subtractButtonHeightConstraint = NSLayoutConstraint(item: subtractButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
        let subtractButtonWidthtConstraint = NSLayoutConstraint(item: subtractButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
// create scoreLabel1
        let scoreLabel1LeftConstraint = NSLayoutConstraint(item: scoreLabel1, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addButton, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        
        let scoreLabel1VerticalConstraint = NSLayoutConstraint(item: scoreLabel1, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        
        let scoreLabel1HeightConstraint = NSLayoutConstraint(item: scoreLabel1, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.35, constant: 0)
        
        let scoreLabel1WidthtConstraint = NSLayoutConstraint(item: scoreLabel1, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addButton, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
        
// create scoreLabel2
        let scoreLabe2LeftConstraint = NSLayoutConstraint(item: scoreLabel2, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subtractButton, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        
        let scoreLabel2VerticalConstraint = NSLayoutConstraint(item: scoreLabel2, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subtractButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        
        let scoreLabel2HeightConstraint = NSLayoutConstraint(item: scoreLabel2, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: scoreLabel1, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
        let scoreLabel2WidthtConstraint = NSLayoutConstraint(item: scoreLabel2, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subtractButton, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)

// create multypliButton
        let multypliButtonLeftConstraint = NSLayoutConstraint(item: multypliButton, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: scoreLabel1, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        
        let multypliButtonVerticalConstraint = NSLayoutConstraint(item: multypliButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: scoreLabel1, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 20)
        
        let multypliButtonHeightConstraint = NSLayoutConstraint(item: multypliButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
        let multypliButtonWidthtConstraint = NSLayoutConstraint(item: multypliButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addButton, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
        
// create divideButton
        let divideButtonRightConstraint = NSLayoutConstraint(item: divideButton, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subtractButton, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        
        let divideButtonVerticalConstraint = NSLayoutConstraint(item: divideButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: scoreLabel2, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 20)
        
        let divideButtonHeightConstraint = NSLayoutConstraint(item: divideButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
        let divideButtonWidthtConstraint = NSLayoutConstraint(item: divideButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addButton, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
// create scoreLabel3
        let scoreLabel3LeftConstraint = NSLayoutConstraint(item: scoreLabel3, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: multypliButton, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
                
        let scoreLabel3VerticalConstraint = NSLayoutConstraint(item: scoreLabel3, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: multypliButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
                
        let scoreLabel3HeightConstraint = NSLayoutConstraint(item: scoreLabel3, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: scoreLabel1, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
                
        let scoreLabel3WidthtConstraint = NSLayoutConstraint(item: scoreLabel3, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: scoreLabel1, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
        
// create scoreLabel4
        let scoreLabe4LeftConstraint = NSLayoutConstraint(item: scoreLabel4, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subtractButton, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        
        let scoreLabel4VerticalConstraint = NSLayoutConstraint(item: scoreLabel4, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: divideButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        
        let scoreLabel4HeightConstraint = NSLayoutConstraint(item: scoreLabel4, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: scoreLabel1, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 0)
        
        let scoreLabel4WidthtConstraint = NSLayoutConstraint(item: scoreLabel4, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: subtractButton, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 0)
        
        self.view.addConstraints([mathTrainerLabelTopConstraint, mathTrainerLabelLeftConstraint, mathTrainerLabelRightConstraint, subLabelLeftConstraint, subLabelRightConstraint, verticalMathTrainerLabelConstraint, addButtonLeftConstraint, addButtonVerticalConstraint, addButtonHeightConstraint, addButtonWidthtConstraint, subtractButtonRightConstraint, subtractButtonVerticalConstraint, subtractButtonHeightConstraint, subtractButtonWidthtConstraint, scoreLabel1LeftConstraint, scoreLabel1HeightConstraint, scoreLabel1WidthtConstraint, scoreLabel1VerticalConstraint, scoreLabe2LeftConstraint, scoreLabel2VerticalConstraint, scoreLabel2HeightConstraint, scoreLabel2WidthtConstraint, multypliButtonLeftConstraint, multypliButtonVerticalConstraint, multypliButtonHeightConstraint, multypliButtonWidthtConstraint, divideButtonRightConstraint, divideButtonVerticalConstraint, divideButtonHeightConstraint, divideButtonWidthtConstraint, scoreLabel3LeftConstraint, scoreLabel3VerticalConstraint, scoreLabel3HeightConstraint, scoreLabel3WidthtConstraint, scoreLabe4LeftConstraint, scoreLabel4VerticalConstraint, scoreLabel4HeightConstraint, scoreLabel4WidthtConstraint])
    }
    
    // MARK: - Methods
    
    @objc private func getMathTypeButtonPressed(_ sender: UIButton) {
        selectedType = MathTypes(rawValue: sender.tag) ?? .add
        let trainVC = TrainViewController()
        trainVC.type = selectedType
    
        trainVC.completion = { [weak self] type, score in
            DispatchQueue.main.async {
                self?.updateScore(for: type, score: score)
            }
        }
    
        trainVC.modalPresentationStyle = .fullScreen
        trainVC.modalTransitionStyle = .crossDissolve
        
        present(trainVC, animated: true)
    }
    
    private func configureButtons() {
        let buttonsCollection = [addButton, subtractButton, multypliButton, divideButton]
        buttonsCollection.forEach { button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
            button.layer.cornerRadius = 40
            button.backgroundColor = .systemYellow
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
            button.clipsToBounds = false
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(getMathTypeButtonPressed), for: .touchUpInside)
        }
    }
    
    private func configureScoreLabels() {
        let scoreLabelsCollection = [scoreLabel1, scoreLabel2, scoreLabel3, scoreLabel4]
        scoreLabelsCollection.forEach { label in
            label.text = "-"
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 17)
            label.textColor = .black
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func updateScore(for type: MathTypes, score: Int) {
        switch type {
        case .add:
            scoreLabel1.text = String(score)
        case .subtract:
            scoreLabel2.text = String(score)
        case .multiply:
            scoreLabel3.text = String(score)
        case .divide:
            scoreLabel4.text = String(score)
        }
    }
}
