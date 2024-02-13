//
//  TrainViewController.swift
//  iOSDev 2.2 - MathTrainer
//
//  Created by Dmitrii Dorogov on 12.02.2024.
//

import UIKit

final class TrainViewController: UIViewController {
    
    @IBOutlet var buttonsCollection: [UIButton]!
    
    @IBOutlet weak var backButtonOutlet: UIButton!
    
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureButtons()
    }
    
    // MARK: - Methods
    
    private func configureButtons() {
        // add shadow›
        buttonsCollection.forEach{ button in
            button.layer.shadowColor = UIColor.darkGray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 2)
            button.layer.shadowOpacity = 0.4
            button.layer.shadowRadius = 3
        }
        
        backButtonOutlet.setTitleColor(.black, for: .normal)
        backButtonOutlet.layer.shadowColor = UIColor.darkGray.cgColor
        backButtonOutlet.layer.shadowOffset = CGSize(width: 0, height: 2)
        backButtonOutlet.layer.shadowOpacity = 0.4
        backButtonOutlet.layer.shadowRadius = 3
        backButtonOutlet.tintColor = .systemYellow
    }
}
