//
//  ApiClientTests.swift
//  TypiCodeImagesTests
//
//  Created by Sanwal, Manish on 3/19/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Quick
import Nimble
import RxBlocking
import RxSwift
import Cuckoo

@testable import TypiCodeImages

class ApiClientTests: QuickSpec {
    override func spec() {
        describe("Api Client") {

            context("GetImage") {
                let nwProvider = MockNetworkProtocol()
                let cache = MockImageCacheProtocol()
                var client: ApiClientProtocol?

                afterEach {
                    client = nil
                    clearStubs(cache)
                    clearStubs(nwProvider)
                }

                context("should return correct images") {
                    beforeEach {
                        stub(nwProvider) { stub in
                            when(stub.fetchImages()).then({ _ -> PrimitiveSequence<SingleTrait, Result<Data>> in
                                return Single.just(Result.success(FileLoader().loadJSON(filename: "sampleImages")!))
                            })
                        }
                        client = ApiClient(networkProvider: nwProvider, cache: cache)
                    }

                    it("result should not be nil") {
                        let result = try! client?.images().toBlocking().first()!
                        expect(result).toNot(beNil())
                    }

                    it("should return 100 images") {
                        let result = try! client?.images().toBlocking().first()!

                        switch result! {
                        case .success(let images):
                            expect(images.count).to(equal(100))
                        case .failure(let error):
                            XCTFail("Failed with error - \(error.message)")
                        }
                    }
                }

                context("should return error if network throws error") {
                    let nwError = NetworkError(status: 404, message: "Not reachable")
                    beforeEach {
                        stub(nwProvider) { stub in
                            when(stub.fetchImages()).then({ _ -> PrimitiveSequence<SingleTrait, Result<Data>> in
                                return Single.just(Result.failure(nwError))
                            })
                        }
                        client = ApiClient(networkProvider: nwProvider, cache: cache)
                    }

                    it("should return 404 error") {
                        let result = try! client?.images().toBlocking().first()!
                        switch result! {
                        case .success:
                            XCTFail("Failed, the result should throw error")
                        case .failure(let error):
                            expect(error.status).to(equal(nwError.status))
                        }
                    }
                }
            }

            context("when downloading image") {
                context("and When cache retuen valid image") {
                    let nwProvider = MockNetworkProtocol()
                    let cache = MockImageCacheProtocol()
                    var client: ApiClientProtocol?
                    let image = UIImage(named: "sample.png")!
                    let url = URL(string: "https://via.placeholder.com/150/a77d08")!

                    afterEach {
                        client = nil
                        clearStubs(cache)
                        clearStubs(nwProvider)
                    }

                    beforeEach {
                        stub(cache, block: { stub in
                            when(stub.getImage(forURL: any())).then({ _ -> Optional<UIImage> in
                                return image
                            })
                        })
                        client = ApiClient(networkProvider: nwProvider, cache: cache)
                    }

                    it("should return non-nil image") {
                        let result = try! client?.image(forUrl: url).toBlocking().first()!
                        expect(result).toNot(beNil())
                    }

                    it("should return image, returned from cache") {
                        let result = try! client?.image(forUrl: url).toBlocking().first()!
                        expect(result!.pngData()).to(equal(image.pngData()))
                    }

                    it("must not call network") {
                        let _ = try! client?.image(forUrl: url).toBlocking().first()!
                        verify(nwProvider, never()).fetchImages()
                    }
                }

                context("and When cache doesn't have image") {
                    let nwProvider = MockNetworkProtocol()
                    let cache = MockImageCacheProtocol()
                    var client: ApiClientProtocol?
                    let image = UIImage(named: "sample.png")!
                    let url = URL(string: "https://via.placeholder.com/150/a77d08")!

                    afterEach {
                        client = nil
                        clearStubs(cache)
                        clearStubs(nwProvider)
                    }

                    beforeEach {
                        stub(cache, block: { stub in
                            when(stub.getImage(forURL: any())).thenReturn(nil)
                            when(stub.setImage(any(), forURL: any())).thenDoNothing()
                        })
                        stub(nwProvider, block: { stub in
                            when(stub
                                .downloadImage(url: any()))
                                .thenReturn(Single.just(Result.success(image.pngData()!)))
                        })
                        client = ApiClient(networkProvider: nwProvider, cache: cache)
                    }

                    it("should return non-nil image") {
                        let result = try! client?.image(forUrl: url).toBlocking().first()!
                        expect(result).toNot(beNil())
                    }

                    it("should return image, returned from cache") {
                        let result = try! client?.image(forUrl: url).toBlocking().first()!
                        expect(result!.pngData()).to(equal(image.pngData()))
                    }

                    it("must call set image on Cache") {
                        let _ = try! client?.image(forUrl: url).toBlocking().first()!
                        verify(cache, atLeastOnce()).setImage(any(), forURL: any())
                    }
                }
            }
        }
    }
}
