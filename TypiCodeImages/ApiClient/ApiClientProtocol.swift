//
//  ApiClientProtocol.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import RxSwift

/// API Client specification
protocol ApiClientProtocol {

    /// get Images
    ///
    /// - Returns: Single<Result<[ImageProtocol]>>
    func images() -> Single<Result<[ImageProtocol]>>

    /// get image for a given URL
    ///
    /// - Parameter forUrl: an Image URL
    /// - Returns: `Single<UIImage?>`
    func image(forUrl: URL) -> Single<UIImage?>
}
