//
//  MoyaNetworkImplementation.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import RxSwift
import Moya

/// Concrete implementation of `NetworkProtocol`
struct MoyaNetworkImplementation: NetworkProtocol {

    /// moya provider
    let nwProvider: MoyaProvider<TypiImageEndPoint>

    /// Initializer
    ///
    /// - Parameter source: the sourceBehavior
    init(source: SourceBehavior) {
        nwProvider = NetworkUtils.imageDataProvider(sourceBehaviour: source)
    }

    /// download the images
    ///
    /// - Returns: `Single<Result<Data>>`
    func fetchImages() -> Single<Result<Data>> {
        return nwProvider
            .rx
            .request(.getImages)
            .debug()
            .map {
                do {
                    let data = try $0.filterSuccessfulStatusCodes().data
                    return Result.success(data)
                } catch {
                    let nwError = try JSONDecoder().decode(NetworkError.self, from: $0.data)
                    return Result.failure(nwError)
                }
        }
    }

    /// download image for a given URL
    ///
    /// - Parameter url: url
    /// - Returns: Single<Result<Data>>
    func downloadImage(url: URL) -> Single<Result<Data>> {
        return Single.just(Result.failure(AppError.unknownError.error()))
    }
}
