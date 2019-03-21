//
//  TypiCodeImageErrorTests.swift
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

class TypiCodeImageErrorTests: QuickSpec {
    override func spec() {
        describe("TypiCodeImagesError") {
            context("AppError") {
                it("parsingData returns correct message") {
                    expect(AppError.errorParsingData.error().message).to(equal(Constants.Error.parsingData))
                }
                it("networkFailure returns correct message") {
                    expect(AppError.networkFailure.error().message).to(equal(Constants.Error.networkFailure))
                }
                it("parameterLength returns correct message") {
                    expect(AppError.parameterLength.error().message).to(equal(Constants.Error.parameterLength))
                }
                it("unknownError returns correct message") {
                    expect(AppError.unknownError.error().message).to(equal(Constants.Error.unknownError))
                }
            }
        }
    }
}
