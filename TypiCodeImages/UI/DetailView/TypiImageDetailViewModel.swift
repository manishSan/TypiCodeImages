//
//  TypiImageDetailViewModel.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation
import RxSwift

protocol TypiImageDetailViewModelProtocol {
    var image: ImageProtocol { get }
    /// get Image for a given URL
    ///
    /// - Returns: Single<UIImage?>
    func getFullImage() -> Single<UIImage?>
}

struct TypiImageDetailViewModel: TypiImageDetailViewModelProtocol {
    let image: ImageProtocol

    /// api client
    let apiClient: ApiClientProtocol

    /// get Image for a given URL
    ///
    /// - Returns: Single<UIImage?>
    func getFullImage() -> Single<UIImage?> {
        return apiClient.image(forUrl: image.url)
    }
}
