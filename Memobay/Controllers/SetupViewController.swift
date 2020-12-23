//
//  SetupViewController.swift
//  Memobay
//
//  Created by Guest User on 23.12.2020.
//

import UIKit

class SetupViewController : UIViewController, UITextFieldDelegate {
    var MAX_PHOTO_COUNT = 6
    var photos = [PhotoSource]()
    
    @IBOutlet weak var inputTheme: UITextField!
    
    @IBOutlet weak var emptyError: UILabel!

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        emptyError.alpha = 0
        self.inputTheme.delegate = self
    }

    @IBAction func startGame(_ sender: Any) {
        let theme: String? = inputTheme.text
        loadImagesAndStart(theme)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let theme: String? = inputTheme.text
        loadImagesAndStart(theme)

        
        
        return true
    }
    
    func loadImagesAndStart(_ theme: String?) {
        if (theme == nil || theme == "") {
            self.emptyError.alpha = 1
            return
        }

//        guard let imageURL = URL(string: "https://pixabay.com/api/?key=19616972-a7ed02b324f20e470f79bf362&q=\(theme ?? "car")&page=1&per_page=6&image_type=photo") else { return }
        guard let imageURL = URL(string: "https://api.pexels.com/v1/search?query=\(theme ?? "car")&per_page=30") else { return }

        var request = URLRequest(url: imageURL)
        request.setValue("563492ad6f91700001000001abc3509b30c44156b8e6fda9cd2af318", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard
                let imageData = data,
                let folder = try? JSONDecoder().decode(Folder.self, from: imageData)
            else { return }

            var uniquePhotos: [Photo] = []

            for photo in folder.photos {
                if (!uniquePhotos.contains { $0.avgColor == photo.avgColor }) {
                    uniquePhotos.append(photo)

                    if (uniquePhotos.count == self.MAX_PHOTO_COUNT) {
                        break
                    }
                }
            }

            if (uniquePhotos.count < self.MAX_PHOTO_COUNT) {
                self.emptyError.alpha = 1
                return
            }
            
            self.photos = uniquePhotos.map {PhotoSource(url: $0.src.medium) }

            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let gameView =
                storyboard.instantiateViewController(identifier: "ViewController") as? ViewController {
    //        show(gameView, sender: nil)
                    gameView.photos = self.photos + self.photos
                    gameView.photos.shuffle()

                    self.navigationController?.pushViewController(gameView, animated: true)
                }
          }
        }.resume()
    }
}
