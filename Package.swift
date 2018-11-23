// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "Provide",
    products: [
        .library(
            name: "provide",
            targets: ["provide"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "4.7.3"),
//        .package(url: "https://github.com/tristanhimmelman/AlamofireObjectMapper.git", from: "5.0.0"),
        .package(url: "https://github.com/tristanhimmelman/ObjectMapper.git", from: "3.4.1"),
        .package(url: "https://github.com/kthomas/JWTDecode.swift.git", from: "2.1.4"),
        .package(url: "https://github.com/kthomas/UICKeyChainStore.git", from: "2.1.4"),
    ],
    targets: [
        .target(
            name: "provide",
            dependencies: [
                "Alamofire",
//                "AlamofireObjectMapper",
                "ObjectMapper",
                "JWTDecode.swift",
                "UICKeyChainStore",
            ],
            path: "Sources"),

        .testTarget(
            name: "provide-swiftTests",
            dependencies: ["provide"],
            path: "Tests"),
    ]
)
