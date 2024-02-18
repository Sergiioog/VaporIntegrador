
import PackageDescription

let package = Package(
    name: "ProyectoIntegrador",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        
        .package(url: "https://github.com/vapor/vapor.git", from: "4.89.0"),
        
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0"),
       
        .package(url: "https://github.com/vapor/leaf.git", from: "4.2.4"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor"),
            ]
        ),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
            .product(name: "Fluent", package: "fluent"),
            .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
            .product(name: "Leaf", package: "leaf"),
        ])
    ]
)