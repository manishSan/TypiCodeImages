//
//  ApiClient.swift
//  TypiCodeImages
//
//  Created by manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import RxSwift

/// API Client specification
protocol ApiClientProtocol {

    func images() -> Single<Result<[Image]>>
}

/// ApiClient concrete implementation
struct ApiClient: ApiClientProtocol {

    let networkProvider: NetworkProtocol

    func images() -> Single<Result<[Image]>> {
        return networkProvider
            .fetchImages().map({ (result) -> Result<[Image]> in
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
}
