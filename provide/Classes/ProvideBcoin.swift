/**
 *  Copyright (c) Provide Technologies Inc.
 *
 *  Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import Foundation
import JavaScriptCore

public class ProvideBcoinService {
    public static let shared = ProvideBcoinService()

    private var bcoinaddrJS: String? {
        let bcoinaddrjsURL = Bundle.main.url(forResource: "bcoinaddr", withExtension: "js")!
        if let bcoinaddrJS = try? String(bytes: Data(contentsOf: bcoinaddrjsURL), encoding: .utf8)! {
            return bcoinaddrJS
        }
        return nil
    }

    public final func generateBcoinPublicKey(privateKey: Data) -> String? {
        let bcoinaddrjs = bcoinaddrJS
        if bcoinaddrjs == nil {
            print("bcoinaddr.js not present")
            return nil
        }

        var publicKey: String?

        let context = JSContext()!
        context.exceptionHandler = { context, exception in
            print("bcoinaddr.js error: \(exception!)")
        }

        context.evaluateScript("var privateKey = '\(privateKey.sha256().hexEncodedString())'")
        context.evaluateScript("var publicKey = null")
        context.evaluateScript(bcoinaddrjs);

        if let pubKey = context.objectForKeyedSubscript("publicKey")?.toObject() as? String {
            publicKey = pubKey
        }

        return publicKey
    }
}
