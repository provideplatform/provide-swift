//
//  ProvideApiClientTests.swift
//  provide_Tests
//
//  Created by Kevin Munc on 09/20/18.
//  Copyright © 2018 Provide. All rights reserved.
//

import XCTest
import provide
// @testable import provide_Example

class ProvideApiClientTests: XCTestCase {
    
    static let scheme = "https"
    static let host = "sub.domain.tld"
    static let api = "/api/v1.2"
    static let path = "/purple/is/a/color"

    // MARK: - Helper Tests
    
    func testBuildUrlWithPath() {
        performTestForBuildUrl(path: "/path-to-resource")
    }

    func testBuildUrlWithPathAndQueryString() {
        performTestForBuildUrl(path: "/path-to-resource", query: "key=value&with=a few spaces in it&special=#%")
    }
    
    func testBuildUrlWithPathAndEmoji() {
        performTestForBuildUrl(path: "/path-to-✊🦃👀")
    }
    
    // MARK: - Helper Methods
    
    // Using the ident interface for now (since the domain is overridable anyway).
    func performTestForBuildUrl(path: String,
                                query: String? = nil,
                                scheme: String = scheme,
                                host: String = host,
                                api: String = api,
                                file: StaticString = #file,
                                line: UInt = #line) {
        let result = ProvideApiClient().buildIdentUrl(path: path, queryString: query, baseScheme: scheme, baseHost: host, apiBasePath: api)
        XCTAssertNotNil(result, file: file, line: line)
        // Note: we are only encode-handling for path and query string in these tests.
        var encodedPath = path
        if let encoded = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            encodedPath = encoded
        }
        var queryString = ""
        if let query = query {
            let queryPart = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            XCTAssertNotNil(queryPart)
            queryString = "?\(queryPart)"
        }
        let expected = "\(scheme)://\(host)\(api)\(encodedPath)\(queryString)"
        XCTAssertEqual(result!.absoluteString, expected, file: file, line: line)
    }

}
