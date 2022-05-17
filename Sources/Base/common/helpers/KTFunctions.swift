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
//  Functions.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 6/27/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import UIKit

public typealias VoidBlock = () -> Void

let logTimestampDateFormatter = DateFormatter("HH:mm:ss.SSS")

public func classNameForObject(_ object: AnyObject) -> String {
    let objectName = NSStringFromClass(type(of: object))

    if let injectBundle = ENV("XCInjectBundle") {
        let testBundleName = NSString(string: NSString(string: injectBundle).lastPathComponent).deletingPathExtension
        return objectName.replacingOccurrences(of: "\(testBundleName).", with: "")
    } else {
        return objectName.components(separatedBy: ".").last!
    }
}

public func decodeJSON(_ data: Data) -> [String: Any] {
    do {
        return try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    } catch {
        log("\(error)")
        fatalError()
    }
}

public func dispatch_after_delay(_ seconds: Double, block: @escaping () -> Void) {
    let delay = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delay, execute: block)
}

public func dispatch_async_global_queue(_ qos: DispatchQoS.QoSClass = .default, block: @escaping () -> Void) {
    DispatchQueue.global(qos: qos).async(execute: block)
}

public func encodeJSON(_ input: Any, options: JSONSerialization.WritingOptions = []) -> Data {
    let data: Data?
    do {
        data = try JSONSerialization.data(withJSONObject: input, options: options)
    } catch let error as NSError {
        logError(error)
        data = nil
    }
    return data!
}

public func ENV(_ envVarName: String) -> String? {
    if var envVarValue = envVarRawValue(envVarName) {
        if envVarValue.hasPrefix("~") {
            let userHomeDir = envVarRawValue("SIMULATOR_HOST_HOME")!
            envVarValue = envVarValue.replacingOccurrences(of: "~", with: userHomeDir)
        }
        return envVarValue
    } else {
        return nil
    }
}

private func envVarRawValue(_ envVarName: String) -> String? {
    return ProcessInfo.processInfo.environment[envVarName]
}

public func infoDictionaryValueFor(_ key: String) -> String {
    return (Bundle.main.infoDictionary![key] ?? "") as! String
}

public func isRunningUnitTests() -> Bool {
    if let injectBundle = ENV("XCInjectBundle") {
        return NSString(string: injectBundle).lastPathComponent.hasSuffix("Tests.xctest")
    }
    return false
}

public func isSimulator() -> Bool {
    #if targetEnvironment(simulator)
        return true
    #else
        return false
    #endif
}

public func log(_ message: String, _ fileName: String = #file, _ functionName: String = #function, _ lineNumber: Int = #line) {
    if CurrentBuildConfig == .debug {
        let timestamp = logTimestampDateFormatter.string(from: Date())
        var fileAndMethod = "[\(timestamp)] [\(NSString(string: NSString(string: fileName).lastPathComponent).deletingPathExtension):\(lineNumber)] "
        fileAndMethod = fileAndMethod.replacingOccurrences(of: "ViewController", with: "VC")
        fileAndMethod = fileAndMethod.padding(toLength: 38, withPad: "-", startingAt: 0)
        let logStatement = "\(fileAndMethod)--> \(message)"
        print(logStatement)
    }
}

public func logError(_ error: NSError, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    log("❌ NSError: \(error.localizedDescription)", fileName, functionName, lineNumber)
}

public func logError(_ errorMessage: String, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    log("‼️ ERROR: \(errorMessage)", fileName, functionName, lineNumber)
}

public func logWarn(_ errorMessage: String, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    log("⚠️ WARNING: \(errorMessage)", fileName, functionName, lineNumber)
}

public func logInfo(_ infoMessage: String, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    log("🔵 INFO: \(infoMessage)", fileName, functionName, lineNumber)
}

public func why(_ message: String, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
    log("❓ WHY: \(message)", fileName, functionName, lineNumber)
}

public func stringFromFile(_ fileName: String, bundlePath: String? = nil, bundle: Bundle = Bundle.main) -> String {
    let resourceName = NSString(string: fileName).deletingPathExtension
    let type = NSString(string: fileName).pathExtension
    let filePath = bundle.path(forResource: resourceName, ofType: type, inDirectory: bundlePath)
    assert(filePath != nil, "File not found: \(resourceName).\(type)")

    let fileAsString: String?
    do {
        fileAsString = try String(contentsOfFile: filePath!, encoding: .utf8)
    } catch let error as NSError {
        logError(error.localizedDescription)
        fileAsString = nil
    }

    assert(fileAsString != nil)

    return fileAsString ?? ""
}

public func prettyPrintedJson(_ uglyJsonStr: String?) -> String {
    if let uglyJsonString = uglyJsonStr, let uglyJson = try? JSONSerialization.jsonObject(with: uglyJsonString.data(using: .utf8)!, options: []) {

        let options: JSONSerialization.WritingOptions
        if #available(iOS 11.0, *) {
            options = [.prettyPrinted, .sortedKeys]
        } else {
            options = [.prettyPrinted]
        }

        let prettyPrintedJson = encodeJSON(uglyJson, options: options)
        return String(data: prettyPrintedJson, encoding: .utf8) ?? ""
    } else {
        return ""
    }
}

public func swizzleMethodSelector(_ origSelector: String, withSelector: String, forClass: AnyClass) {
    if let originalMethod = class_getInstanceMethod(forClass, Selector(origSelector)),
        let swizzledMethod = class_getInstanceMethod(forClass, Selector(withSelector)) {
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

public func totalDeviceMemoryInGigabytes() -> CGFloat {
    return CGFloat(ProcessInfo.processInfo.physicalMemory) / 1073741824.0
}
