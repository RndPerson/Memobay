//
//  Photos.swift
//  Memobay
//
//  Created by Guest User on 23.12.2020.
//

import Foundation
import UIKit


struct PhotoSource : Codable {
    let medium: String

    var image: UIImage?

    init(url: String) {
        self.medium = url
    }

    private enum CodingKeys: String, CodingKey {
        case medium = "medium"
    }
}

struct Photo : Codable {
    let src: PhotoSource
    let avgColor: String
    
    private enum CodingKeys: String, CodingKey {
        case src = "src"
        case avgColor = "avg_color"
    }
}

struct Folder : Codable {
    let photos: [Photo]

    private enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}
