//
//  TypiImageEndPoint.swift
//  TypiCodeImages
//
//  Created by manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import Moya

/// TypiImage API description
///
/// - getImages: API to get the images
enum TypiImageEndPoint {
    case getImages
    case downloadImage(url: URL)
}

// MARK: - `TargetType` protocol implementation
extension TypiImageEndPoint: TargetType {
    var baseURL: URL {
        switch self {
        case .getImages:
            // swiftlint:disable force_unwrapping
            return URL(string: Constants.Network.baseURL)!
            // swiftlint:enable force_unwrapping
        case .downloadImage(let url):
            return url
        }

    }

    var path: String {
        switch self {
        case .getImages:
            return Constants.Network.Images.api
        case .downloadImage:
            return ""
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        switch self {
        case .getImages:
            return FileLoader().loadJSON(filename: Constants.Network.Images.sampleResponse) ?? Data()
        case .downloadImage:
            return Asset.sample.image.pngData() ?? Data()
        }

    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return nil
    }

}
