//
//  ImageCacheTests.swift
//  TypiCodeImagesTests
//
//  Created by Sanwal, Manish on 3/21/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Quick
import Nimble
import RxBlocking
import RxSwift
import Cuckoo

@testable import TypiCodeImages

class ImageCacheTests: QuickSpec {
    override func spec() {
        describe("Image cache ") {
            let image1 = Asset.placeholder.image
            let url1 = URL(string: "WWW.Placeholder.image")!
            let url2 = URL(string: "WWW.Sample.image")!
            context("setImage / getImage") {
                let cache = ImageCache()
                cache.setImage(image1, forURL: url1)
                it("should save the image provided") {
                    let returnImage = cache.getImage(forURL: url1)
                    expect(returnImage?.pngData()).to(equal(image1.pngData()))
                }

                it("should return nil if it can't find image") {
                    let returnImage = cache.getImage(forURL: url2)
                    expect(returnImage?.pngData()).to(beNil())
                }
            }
        }
    }
}
