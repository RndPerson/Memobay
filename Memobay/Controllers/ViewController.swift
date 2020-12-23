//
//  ViewController.swift
//  Lesson 6
//
//  Created by Guest User on 22.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos = [PhotoSource]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        collectionView.delegate = self
//        setupPhotos()
        DispatchQueue.main.async {
        self.collectionView.reloadData()}    }
    
//    private func setupPhotos() {
//        guard let imageURL = URL(string: "https://pixabay.com/api/?key=19616972-a7ed02b324f20e470f79bf362&q=&image_type=photo") else { return }
//
//        URLSession.shared.dataTask(with: imageURL) { data, _, _ in
//            guard
//                let imageData = data,
//                let folder = try? JSONDecoder().decode(Folder.self, from: imageData)
//            else { return }
//
//            self.photos = folder.photos.prefix(6).map {Photo(url: $0.url) }
//
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//            }
//        }.resume()
//    }
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        
        cell.flipView()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthScreen = view.frame.width - 70
        let width = widthScreen/3
        return CGSize(width: width, height: width)
    }
}





//struct Photo : Codable {
//    let url: String
//
//    var image: UIImage?
//
//    init(url: String){
//        self.url = url
//    }
//
//    private enum CodingKeys: String, CodingKey {
//        case url = "webformatURL"
//    }
//}
//
//struct Folder : Codable {
//    let photos: [Photo]
//
//    private enum CodingKeys: String, CodingKey {
//        case photos = "hits"
//    }
//}
