// Copyright 2017-2022 Provide Technologies Inc.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//
//  XCTestCaseExtensions.swift
//  provide_Tests
//
//  Created by Kevin Munc on 09/20/18.
//  Copyright © 2018 Provide. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    // MARK: - Expectation Helpers
    
    func expectedPass(_ expectation: XCTestExpectation) {
        expectation.fulfill()
    }
    
    func unexpectedPass(_ expectation: XCTestExpectation, file: StaticString = #file, line: UInt = #line) {
        expectation.fulfill()
        XCTFail("Request should have failed", file: file, line: line)
    }
    
    func expectedFail(_ expectation: XCTestExpectation) {
        expectation.fulfill()
    }
    
    func unexpectedFail(_ expectation: XCTestExpectation, file: StaticString = #file, line: UInt = #line) {
        expectation.fulfill()
        XCTFail("Request should have passed.", file: file, line: line)
    }
    
}
