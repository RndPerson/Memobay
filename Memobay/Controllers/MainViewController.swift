//
//  MainViewController.swift
//  Memobay
//
//  Created by Guest User on 23.12.2020.
//

import UIKit

class  MainViewController: UIViewController {
    
    
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftBackCard: UIView!
    @IBOutlet weak var rightBackCard: UIView!
    @IBOutlet weak var emodjiLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var leftItem: UILabel!
    @IBOutlet weak var rightItem: UILabel!
    
    
    @IBAction func tapRightCard(_ sender: Any) {
        UIView.transition(from: rightBackCard, to: rightView,
                    duration: 1,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: nil)    }
    
    
    @IBAction func tapLeftCard(_ sender: Any) {
        UIView.transition(from: leftBackCard, to: leftView,
                    duration: 1,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: nil)    }
}


