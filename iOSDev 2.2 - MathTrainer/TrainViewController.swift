//
//  TrainViewController.swift
//  iOSDev 2.2 - MathTrainer
//
//  Created by Dmitrii Dorogov on 12.02.2024.
//

import UIKit

final class TrainViewController: UIViewController {
    // MARK: - Properties
    var type: MathTypes = .add {
        didSet {
            print(type)
        }
    }
}
