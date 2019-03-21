//
//  Container+UnwrappedResolve.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import Swinject

// swiftlint:disable force_unwrapping
extension Resolver {
    /// Resolve a given `Service.Type` to the registered Service. This method will `fatalError` if no `Service` is registered
    /// for `Service.Type`, rather than the default which will return an implicitly unwrapped optional
    ///
    /// - Parameter type: A given `Service.Type` which needs to be resolved to a concrete instance
    /// - Returns: An instance of `Service` that the `Service.Type` is registered for
    func resolveUnwrapped<Service>(_ type: Service.Type) -> Service {
        let result = resolve(type)
        assert(result != nil, String(format: "Could not resolve type \(type)"))
        return result!
    }
}
// swiftlint:enable force_unwrapping
