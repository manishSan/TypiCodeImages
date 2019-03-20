//
//  ApiClient.swift
//  TypiCodeImages
//
//  Created by manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import RxSwift

/// ApiClient concrete implementation
struct ApiClient: ApiClientProtocol {
    /// a network provider
    let networkProvider: NetworkProtocol

    /// a cacheProvider
    let cache: ImageCacheProtocol

    /// get Images
    ///
    /// - Returns: Single<Result<[Image]>>
    func images() -> Single<Result<[ImageProtocol]>> {
        return networkProvider
            .fetchImages()
            .map({ result -> Result<[ImageProtocol]> in
                switch result {
                case .success(let data):
                    do {
                        let images = try JSONDecoder().decode([Image].self, from: data)
                        return Result.success(images)
                    } catch {
                        return Result.failure(AppError.errorParsingData.error())
                    }
                case .failure(let error):
                    return Result.failure(error)
                }
            })
    }

    /// The method first checks if the image is availiable in cache
    ///     if yes -> return the image from cache
    ///     else -> try downoding the image
    ///         if image is successfully downloaded -> save image to cache and return the image
    ///         else -> retun nil
    ///
    /// - Parameter forUrl: image URL
    /// - Returns: `Single<UIImage?>`
    func image(forUrl: URL) -> Single<UIImage?> {
        if let cachedImage = cache.getImage(forURL: forUrl) {
            return Single.just(cachedImage)
        } else {
            return networkProvider
                .downloadImage(url: forUrl)
                .map({ result -> UIImage? in
                    switch result {
                    case .success(let data):
                        if let downloadedImage = UIImage(data: data) {
                            self.cache.setImage(downloadedImage, forURL: forUrl)
                            return downloadedImage
                        }
                        return nil
                    case .failure:
                        return nil
                    }
                })
        }
    }
}
