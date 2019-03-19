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

            context("should return correct images") {
                let nwProvider = MockNetworkProtocol()
                var client: ApiClientProtocol?
                beforeEach {
                    stub(nwProvider) { stub in
                        when(stub.fetchImages()).then({ _ -> PrimitiveSequence<SingleTrait, Result<Data>> in
                            return Single.just(Result.success(FileLoader().loadJSON(filename: "sampleImages")!))
                        })
                    }
                    client = ApiClient(networkProvider: nwProvider)
                }
                afterEach {
                    client = nil
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
                let nwProvider = MockNetworkProtocol()
                var client: ApiClientProtocol?
                let nwError = NetworkError(status: 404, message: "Not reachable")
                beforeEach {
                    stub(nwProvider) { stub in
                        when(stub.fetchImages()).then({ _ -> PrimitiveSequence<SingleTrait, Result<Data>> in
                            return Single.just(Result.failure(nwError))
                        })
                    }
                    client = ApiClient(networkProvider: nwProvider)
                }
                afterEach {
                    client = nil
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
    }
}
