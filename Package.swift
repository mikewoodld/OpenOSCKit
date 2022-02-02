// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OpenOSCKit",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_10),
        .tvOS(.v9)
    ],
    products: [
        .library(
            name: "OpenOSCKit",
            targets: ["OpenOSCKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/robbiehanson/CocoaAsyncSocket", from: "7.6.5"),
        .package(name: "NetUtils" ,url: "https://github.com/svdo/swift-netutils", from: "4.2.0"),
        .package(url: "https://github.com/dsmurfin/OpenOSC", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "OpenOSCKit",
            dependencies: ["CocoaAsyncSocket", "NetUtils", "OpenOSC"]),
        .testTarget(
            name: "OpenOSCKitTests",
            dependencies: ["OpenOSCKit"]),
    ]
)
