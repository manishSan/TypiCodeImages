//
//  NetworkProtocol.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import RxSwift
import Moya

/// An Enum type to describe the Source Behavior
///
/// - live: make live request
/// - stubbed: get data from stubbed json
/// - stubbedWithDelay: get data from stubbed json after a delay
enum SourceBehavior {
    case live
    case stubbed
    case stubbedWithDelay(seconds: TimeInterval)
}

/// an Abstraction over Network Requests
protocol NetworkProtocol {
    /// download the images
    ///
    /// - Returns: `Single<Result<Data>>`
    func fetchImages() -> Single<Result<Data>>

    /// download image for a given URL
    ///
    /// - Parameter url: url
    /// - Returns: Single<Result<Data>>
    func downloadImage(url: URL) -> Single<Result<Data>>
}
