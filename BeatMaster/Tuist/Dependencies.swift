//
//  Dependencies.swift
//  Manifests
//
//  Created by 서원지 on 1/6/24.
//

import Foundation
import ProjectDescription

let swiftpackage = SwiftPackageManagerDependencies(
    [
        .remote(url: "http://github.com/pointfreeco/swift-composable-architecture", requirement: .exact("1.9.2")),
        .remote(url: "https://github.com/Moya/Moya.git", requirement: .upToNextMinor(from: "15.0.0")),
        .remote(url: "https://github.com/Swinject/Swinject.git", requirement: .upToNextMajor(from: "2.8.4")),
        .remote(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", requirement: .upToNextMajor(from: "2.0.0")),
        .remote(url: "https://github.com/Kitura/Swift-JWT.git", requirement: .branch("master")),
        .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMajor(from: "10.22.0")),
        .remote(url: "https://github.com/kishikawakatsumi/KeychainAccess", requirement: .upToNextMajor(from: "4.2.2")),
        .remote(url: "https://github.com/kakao/kakao-ios-sdk", requirement: .upToNextMajor(from: "2.21.0"))
//        .remote(url: "https://github.com/supabase-community/supabase-swift.git", requirement: .upToNextMajor(from: "2.3.1"))
        //    .remote(url: "https://github.com/supabase-community/supabase-swift.git", requirement: .exact("2.0.0"))
    ],
    baseSettings: .settings(
       configurations: [
         .debug(name: .debug),
         .release(name: .release)
       ]
     )
)

let dependencies = Dependencies(
    swiftPackageManager: swiftpackage,
    platforms: [.iOS]
)



