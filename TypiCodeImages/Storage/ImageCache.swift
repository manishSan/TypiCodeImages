//
//  ImageCache.swift
//  TypiCodeImages
//
//  Created by manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    func getImage(forURL: URL) -> UIImage?

    func setImage(_ image: UIImage, forURL: URL)
}

struct ImageCache: ImageCacheProtocol {

    let memoryCache = NSCache<NSString, UIImage>()

    func getImage(forURL: URL) -> UIImage? {
        return memoryCache.object(forKey: forURL.absoluteString as NSString)
    }

    func setImage(_ image: UIImage, forURL: URL) {
        memoryCache.setObject(image, forKey: forURL.absoluteString as NSString)
    }
}
