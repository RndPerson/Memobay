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
    
    var isLeftFlipped = false
    var isRightFlipped = false

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        emodjiLabel.alpha = 0
        errorLabel.alpha = 0
    }

    func checkCardsFlipped() {
        if (isLeftFlipped && isRightFlipped) {
            emodjiLabel.alpha = 1
            errorLabel.alpha = 1

//            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                UIView.transition(from: self.rightView, to: self.rightBackCard,
//                                  duration: 0.5,
//                            options: [.transitionFlipFromLeft, .showHideTransitionViews],
//                            completion: nil )
//                UIView.transition(from: self.leftView, to: self.leftBackCard,
//                                  duration: 0.5,
//                            options: [.transitionFlipFromLeft, .showHideTransitionViews],
//                            completion: nil)
//            }
        }
    }
    
    @IBAction func tapRightCard(_ sender: Any) {
        UIView.transition(from: rightBackCard,
                          to: rightView,
                          duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: { _ in
                        self.isRightFlipped.toggle()
                        self.checkCardsFlipped()
                    } )
    }
    
    
    @IBAction func tapLeftCard(_ sender: Any) {
        UIView.transition(from: leftBackCard,
                          to: leftView,
                          duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: { _ in
                        self.isLeftFlipped.toggle()
                        self.checkCardsFlipped()
                    } )
        
    }
    
  /*
    @IBAction func goToSettingsView(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let popUpView =
            storyboard.instantiateViewController(identifier: "SetupViewController") as? SetupViewController {
//        show(popUpView, sender: nil)
            navigationController?.pushViewController(popUpView, animated: true)
      }
    }
    */
}

