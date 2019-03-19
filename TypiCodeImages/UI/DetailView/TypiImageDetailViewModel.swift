//
//  TypiImageDetailViewModel.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation

protocol TypiImageDetailViewModelProtocol {
    var image: ImageProtocol { get }
}

struct TypiImageDetailViewModel: TypiImageDetailViewModelProtocol {
    let image: ImageProtocol
}
