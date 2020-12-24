//
//  ViewController.swift
//  Lesson 6
//
//  Created by Guest User on 22.12.2020.
//

import UIKit

struct PressedItem {
    var url: String
    var index: IndexPath

    init(url: String, index: IndexPath) {
        self.url = url
        self.index = index
    }
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var restHP2: UILabel!
    @IBOutlet weak var restHP3: UILabel!
    @IBOutlet weak var restHP4: UILabel!
    
    var hp = 4
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var gameView: UIView!
    
    @IBOutlet weak var currentLevelLabel: UILabel!


    
    var photos = [PhotoSource]()
    var currentLevel = 1
    var pressedItems: [PressedItem] = []
    var foundedPairsCount = 0
    
    
    @IBAction func goToMainMenu(_ sender: Any) {
        goToMainMenu()
    }
    
    
    @IBAction func goToMainMenuFromResult(_ sender: Any) {
        goToMainMenu()
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

    func subtractHP() {
        switch self.hp {
        case 4:
            hp -= 1
            restHP4.alpha = 0
        case 3:
            hp -= 1
            restHP3.alpha = 0
        case 2:
            hp -= 1
            restHP2.alpha = 0
        default:
            goToResult(gameResult: .lose)
        }
    }
    
    func goToResult(gameResult: GameResult) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let resultView =
        storyboard.instantiateViewController(identifier: "ResultViewController") as? ResultViewController {
            resultView.gameResult = gameResult
            resultView.level = currentLevel

            self.navigationController?.pushViewController(resultView, animated: true)
        }
    }

    func checkWin() {
        if foundedPairsCount == 6 {
            Store.level += 1
            goToResult(gameResult: .win)
        }
    }
    
    override func viewDidLoad() {
        print("LEVEL: \(Store.level)")
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        currentLevelLabel.text = "Уровень \(currentLevel)"
    }
    
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        cell.setImageWithURLSession(photoModel: photos[indexPath.item]) { [weak self] (image) in
            self?.photos[indexPath.item].image = image
        }
        
        cell.demoCard()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.pressedItems.count < 2 {
            let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
            self.pressedItems.append(PressedItem(url: cell.url, index: indexPath))
            cell.flipView()

            if self.pressedItems.count == 2 {
                if self.pressedItems[0].url == self.pressedItems[1].url {
                    let secondFoundCell = collectionView.cellForItem(at: self.pressedItems[0].index)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        UIView.animate (withDuration: 0.5) {
                            cell.alpha = 0
                            secondFoundCell?.alpha = 0
                            self.foundedPairsCount += 1
                            self.pressedItems = []
                            self.checkWin()
                        }
                    }
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        UIView.animate (withDuration: 0.5) {
                            cell.flipViewBack()
                            let secondCell = collectionView.cellForItem(at: self.pressedItems[0].index)  as! ImageCell

                            secondCell.flipViewBack()
                            self.pressedItems = []
                            self.subtractHP()
                        }
                    }
                }
            }
        }
    }
    
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthScreen = view.frame.width - 70
        let width = widthScreen/3
        return CGSize(width: width, height: width)
    }
}
