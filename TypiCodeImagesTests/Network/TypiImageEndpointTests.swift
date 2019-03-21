//
//  TypiImageEndpointTests.swift
//  TypiCodeImagesTests
//
//  Created by manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Quick
import Nimble

@testable import TypiCodeImages

class TypiImageEndpointTests: QuickSpec {
    override func spec() {
        describe("Image endpoint") {
            let endpoint = TypiImageEndPoint.getImages
            it("must have correct baseURL") {
                expect(endpoint.baseURL.absoluteString).to(equal("http://jsonplaceholder.typicode.com"))
            }
            it("must have correct path") {
                expect(endpoint.path).to(equal("photos"))
            }
            it("must have correct method") {
                expect(endpoint.method).to(equal(.get))
            }
            it("must have correct task") {
                switch endpoint.task {
                case .requestPlain:
                    break
                default:
                    XCTFail("Wrong task type")
                }
            }
            it("must have correct headers") {
                expect(endpoint.headers).to(beNil())
            }
        }
    }
}
