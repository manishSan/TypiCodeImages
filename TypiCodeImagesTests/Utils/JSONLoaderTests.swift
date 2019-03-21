//
//  JSONLoaderTests.swift
//  TypiCodeImagesTests
//
//  Created by manish on 3/18/19.
//  Copyright © 2019 Sanwal. All rights reserved.
//

import Quick
import Nimble

@testable import TypiCodeImages

class JSONLoaderTests: QuickSpec {
    override func spec() {
        describe("JsonLoader") {
            var loader: FileLoader?

            beforeEach {
                loader = FileLoader()
            }

            afterEach {
                loader = nil
            }

            context("loadJSON", {
                it("loads file in bundle") {
                    expect(loader?.loadJSON(filename: "sampleImages")).toNot(beNil())
                }
                it("fails if file is not in bundle") {
                    expect(loader?.loadJSON(filename: "NotInBundle")).to(beNil())
                }
                it("fails if file extension is provided") {
                    expect(loader?.loadJSON(filename: "sampleImages.json")).to(beNil())
                }
            })
        }
    }
}
