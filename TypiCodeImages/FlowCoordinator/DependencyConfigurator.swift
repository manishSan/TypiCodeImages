//
//  DependencyConfigurator.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import Swinject

/// centralized palce to configure dependencies
struct DependencyConfigurator {
    /// configure base dependencies for the module
    ///
    /// - Parameter container: swinject container
    static func configureBaseDependencies(container: Container) {
        container.register(NetworkProtocol.self) { _ in MoyaNetworkImplementation(source: .live) }
        container.register(ImageCacheProtocol.self) { _ in ImageCache() }
        container.register(ApiClientProtocol.self) { r in ApiClient(networkProvider: r.resolveUnwrapped(NetworkProtocol.self),
                                                                    cache: r.resolveUnwrapped(ImageCacheProtocol.self))}
    }
}
