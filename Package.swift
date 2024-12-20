// swift-tools-version:6.0

import Foundation
import PackageDescription

extension String {
    static let basicAuth: Self = "BasicAuth"
}

extension Target.Dependency {
    static var basicAuth: Self { .target(name: .basicAuth) }
}

extension Target.Dependency {
    static var urlRouting: Self { .product(name: "URLRouting", package: "swift-url-routing") }
}

let package = Package(
    name: "swift-basic-auth",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(name: .basicAuth, targets: [.basicAuth]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-url-routing", from: "0.6.0"),
    ],
    targets: [
        .target(
            name: .basicAuth,
            dependencies: [
                .urlRouting
            ]
        ),
        .testTarget(
            name: .basicAuth + " Tests",
            dependencies: [
                .basicAuth,
                .urlRouting
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)
