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

    /// get Images
    ///
    /// - Returns: Single<Result<[Image]>>
    func images() -> Single<Result<[ImageProtocol]>> {
        return networkProvider
            .fetchImages()
            .map({ (result) -> Result<[ImageProtocol]> in
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

    func image(forUrl: URL) -> Single<UIImage?> {
        let image = UIImage(named: "sample.png")
        return Single.just(image)
    }
}
