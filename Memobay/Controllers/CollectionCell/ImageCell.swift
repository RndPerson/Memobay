//
//  ImageCell.swift
//  Lesson 6
//
//  Created by Guest User on 22.12.2020.
//

import UIKit

class ImageCell: UICollectionViewCell {
    var url: String = ""
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cardBack: UIView!
    
    override func prepareForReuse () {
        imageView.image = nil
    }
    
    func demoCard () {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        {
            UIView.transition(from: self.cardBack, to: self.imageView,
                          duration: 1,
                   options: [.transitionFlipFromRight, .showHideTransitionViews],
                   completion: nil)    }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5)
        {
            UIView.transition(from: self.imageView, to: self.cardBack,
                          duration: 1,
                   options: [.transitionFlipFromRight, .showHideTransitionViews],
                   completion: nil)    }    }
    
    func flipView () {
        UIView.transition(from: cardBack, to: imageView,
                          duration: 0.5,
                   options: [.transitionFlipFromRight, .showHideTransitionViews],
                   completion: nil)    }

    func flipViewBack() {
        UIView.transition(from: imageView, to: cardBack,
                          duration: 0.5,
                   options: [.transitionFlipFromRight, .showHideTransitionViews],
                   completion: nil)
    }
    
    func setImageWithURLSession(photoModel: PhotoSource, completion: @escaping (UIImage?) -> Void) {
        if let image = photoModel.image {
            imageView.image = image
            return
        }
        
        guard let imageURL = URL(string: photoModel.medium) else { return }

        self.url = photoModel.medium
        
        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
            if let data = data, let image = UIImage (data: data) {
                completion(image)
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}
