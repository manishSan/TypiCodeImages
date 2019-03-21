//
//  ImageCache.swift
//  TypiCodeImages
//
//  Created by manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import UIKit

/// image cache specification
protocol ImageCacheProtocol {
    /// get image from the cache
    ///
    /// - Parameter forURL: key URL
    /// - Returns: An option UIImage
    func getImage(forURL: URL) -> UIImage?

    /// Add an image to cache
    ///
    /// - Parameters:
    ///   - image: image to be saved
    ///   - forURL: a key URL
    func setImage(_ image: UIImage, forURL: URL)
}

/// image cache concrete implementation
struct ImageCache: ImageCacheProtocol {

    /// an in memory cache
    let memoryCache = NSCache<NSString, UIImage>()

    /// get image from the cache
    ///
    /// - Parameter forURL: key URL
    /// - Returns: An option UIImage
    func getImage(forURL: URL) -> UIImage? {
        return memoryCache.object(forKey: forURL.absoluteString as NSString)
    }

    /// Add an image to cache
    ///
    /// - Parameters:
    ///   - image: image to be saved
    ///   - forURL: a key URL
    func setImage(_ image: UIImage, forURL: URL) {
        memoryCache.setObject(image, forKey: forURL.absoluteString as NSString)
    }
}
