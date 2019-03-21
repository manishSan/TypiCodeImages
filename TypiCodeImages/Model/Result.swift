//
//  Result.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation

// An Enum type to describe the `Result` type of assocaite type `T`
/// - success(T): Notifies of the completion.
/// - failure(TypiCodeImagesError): Notifies and passes the WebServiceError.
enum Result<T> {
    case success(T)
    case failure(TypiCodeImagesError)
}
