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
}

// MARK: - `TargetType` protocol implementation
extension TypiImageEndPoint: TargetType {
    var baseURL: URL {
        // swiftlint:disable force_unwrapping
        return URL(string: Constants.Network.baseURL)!
        // swiftlint:enable force_unwrapping
    }

    var path: String {
        return Constants.Network.Images.api
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return JSONLoader().loadJSON(filename: Constants.Network.Images.sampleResponse) ?? Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return nil
    }

}
