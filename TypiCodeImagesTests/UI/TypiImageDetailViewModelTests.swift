//
//  TypiImageDetailViewModelTests.swift
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

class TypiImageDetailViewModelTests: QuickSpec {
    override func spec() {
        describe("TypiImageDetailViewModelTests") {
            context("getFullImage") {
                let apiClient = MockApiClientProtocol()
                let photo = Asset.placeholder.image
                let image = Image(albumId: 1, id: 1, title: "test title", url: URL(string: "www.test.url")!, thumbnailUrl: URL(string: "www.test.url")!)
                let viewModel = TypiImageDetailViewModel(image: image, apiClient: apiClient)

                beforeEach {
                    stub(apiClient, block: { stub in
                        when(stub.image(forUrl: any())).thenReturn(Single.just(photo))
                    })
                }

                it("should return image retunred by APIClient") {
                    let result = try! viewModel.getFullImage().toBlocking().first()!
                    expect(result?.pngData()).to(equal(photo.pngData()))
                }
            }
        }
    }
}
