//
//  MainViewController.swift
//  Memobay
//
//  Created by Guest User on 23.12.2020.
//

import UIKit

class  MainViewController: UIViewController {
    
    
    @IBOutlet weak var goodTutorialView: UIView!
    @IBOutlet weak var likeGT: UILabel!
    @IBOutlet weak var goodAdvice: UILabel!
    @IBOutlet weak var goodMotive: UILabel!
    @IBOutlet weak var leftCardGT: UIView!
    @IBOutlet weak var rightCardGT: UIView!
    @IBOutlet weak var leftBackCardGT: UIView!
    @IBOutlet weak var rightBackCardGT: UIView!
    
    
    @IBOutlet weak var badTutorialView: UIView!
    @IBOutlet weak var dislikeBT: UILabel!
    @IBOutlet weak var badAdvice: UILabel!
    @IBOutlet weak var badMotive: UILabel!
    @IBOutlet weak var leftCardBT: UIView!
    @IBOutlet weak var rightCardBT: UIView!
    @IBOutlet weak var leftBackCardBT: UIView!
    @IBOutlet weak var rightBackCardBT: UIView!
    
    var isLeftGTFlipped = false
    var isRightGTFlipped = false
    var isLeftBTFlipped = false
    var isRightBTFlipped = false

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        dislikeBT.alpha = 0
        badMotive.alpha = 0
        likeGT.alpha = 0
        goodMotive.alpha = 0
    }

    
    func checkGoodCardsFlipped() {
        if (isLeftGTFlipped && isRightGTFlipped) {
            goodAdvice.alpha = 0
            UIView.animate (withDuration: 2) {            self.likeGT.alpha = 1
                self.goodMotive.alpha = 1
            }
            UIView.animate (withDuration: 1.3) {
                self.leftCardGT.alpha = 0
                self.rightCardGT.alpha = 0
            }
        }
    }
    
    func checkBadCardsFlipped() {
        if (isLeftBTFlipped && isRightBTFlipped) {
            badAdvice.alpha = 0
            UIView.animate (withDuration: 2) {            self.dislikeBT.alpha = 1
                self.badMotive.alpha = 1
            }
            UIView.animate (withDuration: 1.3) {
                self.leftCardGT.alpha = 0
                self.rightCardGT.alpha = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                UIView.transition(from: self.badTutorialView,
                                  to: self.goodTutorialView,
                                  duration: 0.5,
                            options: [.transitionCrossDissolve, .showHideTransitionViews],
                            completion:
                                { _ in
                                    self.leftCardGT.alpha = 1
                                    self.rightCardGT.alpha = 1
                                }
                            )
            }
        }
    }
    
    
    
    
    @IBAction func tapLeftCardBT(_ sender: Any) {
        UIView.transition(from: leftBackCardBT,
                          to: leftCardBT,
                          duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: { _ in
                        self.isLeftBTFlipped.toggle()
                        self.checkBadCardsFlipped()
                    } )    }
    
    
    @IBAction func tapRightCardBT(_ sender: Any) {
        UIView.transition(from: rightBackCardBT,
                          to: rightCardBT,
                          duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: { _ in
                        self.isRightBTFlipped.toggle()
                        self.checkBadCardsFlipped()
                    } )    }
    
    
    @IBAction func tapLeftCardGT(_ sender: Any) {
        UIView.transition(from: leftBackCardGT,
                          to: leftCardGT,
                          duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: { _ in
                        self.isLeftGTFlipped.toggle()
                        self.checkGoodCardsFlipped()
                    } )    }
    
    
    @IBAction func tapRightCardGT(_ sender: Any) {
        UIView.transition(from: rightBackCardGT,
                          to: rightCardGT,
                          duration: 0.5,
                    options: [.transitionFlipFromRight, .showHideTransitionViews],
                    completion: { _ in
                        self.isRightGTFlipped.toggle()
                        self.checkGoodCardsFlipped()
                    } )    }
    
    
}

