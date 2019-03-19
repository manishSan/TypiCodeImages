//
//  NetworkProtocolTests.swift
//  TypiCodeImagesTests
//
//  Created by manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Quick
import Nimble
import RxBlocking

@testable import TypiCodeImages

class NetworkTest: QuickSpec {
    override func spec() {
        describe("Network layer, test stubbed response") {
            var networkProvider: NetworkProtocol!

            beforeEach {
                networkProvider = MoyaNetworkImplementation(source: .stubbed)
            }

            afterEach {
                networkProvider = nil
            }

            context("Images endpoint") {
                var nwResult: Result<Data>?

                beforeEach {
                    let observable = networkProvider.fetchImages()
                    nwResult = try! observable.toBlocking().first()!
                }

                afterEach {
                    nwResult = nil
                }

                it("return must be non null") {
                    expect(nwResult).toNot(beNil())
                }

                it("return corrct json") {
                    if let result = nwResult {
                        switch result {
                        case .success(let json):
                            let images = try! JSONDecoder().decode([Image].self, from: json)
                            expect(images.count).to(beGreaterThan(0))
                        case .failure(let error):
                            XCTFail("failed with error - \(error.message)")
                        }
                    }
                }
            }
        }
    }
}
