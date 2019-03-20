//
//  FlowCoordinator.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import Swinject

struct BaseFlowCoordinator {
    /// a swinject container
    let container: Container

    /// the main window
    private let mainWindow = UIWindow(frame: UIScreen.main.bounds)

    /// api client
    var apiClient: ApiClientProtocol {
        return container.resolveUnwrapped(ApiClientProtocol.self)
    }

    /// initializer
    ///
    /// - Parameter container: swinject container
    init(container: Container) {
        self.container = container
        DependencyConfigurator.configureBaseDependencies(container: container)
    }

    /// Configures the `mainWindow` with its `rootViewController` and presents it
    /// Called by the `AppController` during launch to present the user interface
    ///
    /// - Parameters:
    ///   - application: The running `UIApplication`.
    ///   - launchOptions: launch-time options via `UIApplicationDelegate`.
    /// - Returns: Whether or not `RootFlowCoordinator` can handle the launch
    ///            directives prescribed in the `launchOptions` dictionary.
    func presentRootInterface(application: UIApplication, withOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureWindow(window: mainWindow)
        showRootImagesViewController(window: mainWindow)
        makeKeyAndVisible(window: mainWindow)
        return true
    }

    // MARK: - Configure Window

    /// Configure a window with a root `UINavigationController` and set `UIAppearance` settings
    ///
    /// - Parameters:
    ///   - window: the window to configure
    ///   - rootNavigationController: the navigation controller to be the `window`'s `rootViewController`
    private func configureWindow(window: UIWindow) {
        window.backgroundColor = UIColor.white
    }

    /// Make the given window key and visible
    ///
    /// - Parameter window: `UIWindow` to make key and visible
    private func makeKeyAndVisible(window: UIWindow) {
        window.makeKeyAndVisible()
    }

    /// show root Images view controller
    private func showRootImagesViewController(window: UIWindow) {
        let navCtrl = UINavigationController()
        let vm = TypiImageListViewModel(apiClient: apiClient,
                                        selectionClosure: {
                                            navCtrl.pushViewController(self.showDetailView(forImage: $0), animated: true)
        })
        //let vc = TypiImageListViewController(viewModel: vm)
        let vc = TypiImageCollectionViewController(viewModel: vm)
        navCtrl.viewControllers = [vc]
        window.rootViewController = navCtrl
    }

    /// get detail view
    ///
    /// - Parameter forImage: an image
    /// - Returns: a UIviewController
    private func showDetailView(forImage: ImageProtocol) -> UIViewController {
        let vm = TypiImageDetailViewModel(image: forImage, apiClient: apiClient)
        let vc = TypiImageDetailViewController(viewModel: vm)
        return vc
    }
}
