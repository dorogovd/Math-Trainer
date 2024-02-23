//
//  ViewController.swift
//  iOSDev 2.2 - MathTrainer
//
//  Created by Dmitrii Dorogov on 09.02.2024.
//

import UIKit

enum MathTypes: Int {
    case add, subtract, multypli, divide
}
enum CountTypes: Int {
    case add, subtract, multypli, divide
}

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var buttonsCollection: [UIButton]!
    
    @IBOutlet var scoreLabelCollection: [UILabel]!
    
    
    // MARK: - Properties
    private var selectedType: MathTypes = .add
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureButtons()
        changeScore()
    }
    
    // MARK: - Actions
    @IBAction func buttonsAction(_ sender: UIButton) {
    selectedType = MathTypes(rawValue: sender.tag) ?? .add
    performSegue(withIdentifier: "goToNext", sender: sender)
    }
    
    @IBAction func unwindAction(unwindSegue: UIStoryboardSegue) { }
    

    // MARK: - Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? TrainViewController {
            viewController.type = selectedType
        }
    }
    
    private func configureButtons() {
        // add shadow
        buttonsCollection.forEach{ button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
    }
    
    func changeScore() {
        
        if TrainViewController().count == 0 {
            scoreLabelCollection.forEach { label in
                label.text = "-"
            }
        } else {
            scoreLabelCollection[0].text = String(TrainViewController().count)
            scoreLabelCollection[1].text = String(TrainViewController().count)
            scoreLabelCollection[2].text = String(TrainViewController().count)
            scoreLabelCollection[3].text = String(TrainViewController().count)
        }
    }
}

