//
//  TypiCodeImagesError.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
/// Registry Error type
protocol TypiCodeImagesError: Error {
    /// error status
    var status: Int { get }
    /// error description
    var message: String { get }
}

struct NetworkError: TypiCodeImagesError, Decodable {
    /// error status
    let status: Int
    /// error description
    let message: String
}

enum AppError: Int {
    case errorParsingData = 1001
    case networkFailure = 1002
    case parameterLength = 1003
    case unknownError = 9999
}

extension AppError {
    func error() -> TypiCodeImagesError {
        switch self {
        case .errorParsingData:
            return createErrorObj(message: Constants.Error.parsingData)
        case .networkFailure:
            return createErrorObj(message: Constants.Error.networkFailure)
        case .parameterLength:
            return createErrorObj(message: Constants.Error.parameterLength)
        case .unknownError:
            return createErrorObj(message: Constants.Error.unknownError)
        }
    }

    private func createErrorObj(message: String) -> TypiCodeImagesError {
        return NetworkError(status: self.rawValue, message: message)
    }
}
