//
//  TypiImageListViewModelTests.swift
//  TypiCodeImagesTests
//
//  Created by Sanwal, Manish on 3/21/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Quick
import Nimble
import RxBlocking
import RxTest
import RxSwift
import Cuckoo

@testable import TypiCodeImages

class TypiImageListViewModelTests: QuickSpec {
    override func spec() {
        describe("TypiImageListViewModel") {
            let photo = Asset.placeholder.image
            let image1 = Image(albumId: 1, id: 1, title: "test title", url: URL(string: "www.test.url")!, thumbnailUrl: URL(string: "www.test.url")!)
            let image2 = Image(albumId: 2, id: 2, title: "test title 2", url: URL(string: "www.test2.url")!, thumbnailUrl: URL(string: "www.test2.url")!)

            context("APIs") {
                let apiClient = MockApiClientProtocol()
                let viewModel = TypiImageListViewModel(apiClient: apiClient, selectionClosure: {_ in})

                beforeEach {
                    stub(apiClient, block: { stub in
                        when(stub.images()).thenReturn(Single.just(Result.success([image1, image2])))
                        when(stub.image(forUrl: any())).thenReturn(Single.just(photo))
                    })
                    viewModel.fetchImageList()
                }

                it("numberOfSections - Should return 2") {
                    expect(viewModel.numberOfSections()).to(equal(2))
                }


                it("numberOfRows Should return 1 row for index = 0") {
                    expect(viewModel.numberOfRows(forSection: 0)).to(equal(1))
                }

                it("title(forIndex: should return `test title` for index 0,0") {
                    expect(viewModel.title(forIndex: IndexPath(row: 0, section: 0))).to(equal("test title"))
                }

                it("title(forSection: should return `album1` for index 0,0") {
                    expect(viewModel.title(forSection: 0)).to(equal("Album 1"))
                }

                it("getThumbnailImage should return correct image") {
                    let pic = try! viewModel.getThumbnailImage(forIndex: IndexPath(row: 0, section: 0)).toBlocking().first()!
                    expect(pic?.pngData()).to(equal(photo.pngData()))
                }
            }

            context("select APIs") {
                var selectionClosureCalled = false
                let apiClient = MockApiClientProtocol()
                let viewModel = TypiImageListViewModel(apiClient: apiClient, selectionClosure: {_ in selectionClosureCalled = true})

                beforeEach {
                    stub(apiClient, block: { stub in
                        when(stub.images()).thenReturn(Single.just(Result.success([image1, image2])))
                        when(stub.image(forUrl: any())).thenReturn(Single.just(photo))
                    })
                    viewModel.fetchImageList()
                }

                afterEach {
                    selectionClosureCalled = false
                }

                it("should call the closure injected") {
                    viewModel.select(index: IndexPath(row: 0, section: 0))
                    expect(selectionClosureCalled).to(beTrue())
                }
                it("should not call the closure if the image index doesn't exist") {
                    viewModel.select(index: IndexPath(row: 0, section: 3))
                    expect(selectionClosureCalled).to(beFalse())
                }
            }
        }
    }
}
