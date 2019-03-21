//
//  Image.swift
//  TypiCodeImages
//
//  Created by Sanwal, Manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Foundation

/// Protocol defining image contract
protocol ImageProtocol {
    /// an albumID
    var albumId: Int { get }
    /// image identifier
    var id: Int { get }
    /// image title
    var title: String { get }
    /// image URL
    var url: URL { get }
    /// thumbnail URL
    var thumbnailUrl: URL { get }
}

/// concrete implementation
struct Image: ImageProtocol, Decodable {
    /// an albumID
    let albumId: Int
    /// image identifier
    let id: Int
    /// image title
    let title: String
    /// image URL
    let url: URL
    /// thumbnail URL
    let thumbnailUrl: URL
}
