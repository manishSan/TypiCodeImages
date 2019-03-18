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

/// An Enum type to describe the Source Behaviour
///
/// - live: make live request
/// - stubbed: get data from stubbed json
/// - stubbedWithDelay: get data from stubbed json after a delay
enum SourceBehaviour {
    case live
    case stubbed
    case stubbedWithDelay(seconds: TimeInterval)
}

// An Enum type to describe the `NetworkWrapper` API result
/// - success(Any): Notifies of the completion and returns the available Json.
/// - failure(WebServiceError): Notifies and passes the WebServiceError.
enum NetworkResult {
    case success(Data)
    case failure()
}

/// an Abstraction over Network Requests
protocol NetworkProtocol {
    /// download the images
    ///
    /// - Returns: `Single<NetworkResult>`
    func fetchImages() -> Single<NetworkResult>
}
