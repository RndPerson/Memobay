//
//  ResultViewController.swift
//  Memobay
//
//  Created by Guest User on 24.12.2020.
//

import UIKit

enum GameResult {
    case win
    case lose
}

class ResultViewController : UIViewController {
    var gameResult: GameResult = .win
    var level: Int = 1

 
    @IBAction func goToMainMenu(_ sender: Any) {
        goToMainMenu()
    }
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        if gameResult == .lose {
            statusLabel.text = "Не повезло"
            levelLabel.text = "Попробуй еще раз!"
        } else {
            statusLabel.text = "Молодец!"
            levelLabel.text = "Уровень \(level)"
        }
    }

    func goToMainMenu() {
        let alert = UIAlertController(title: "Вы уверены?", message: "Выход в главное меню сбросит весь ваш игровой прогресс", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Уверен", style: .destructive, handler: {_ in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let mainMenuView =
            storyboard.instantiateViewController(identifier: "MainViewController") as? MainViewController {

                self.navigationController?.pushViewController(mainMenuView, animated: true)
            }
        }))

        self.present(alert, animated: true)
    }
}
