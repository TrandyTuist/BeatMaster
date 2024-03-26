//
//  Extension+TargetDependency.swift
//  Plugins
//
//  Created by 서원지 on 2/21/24.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let moya = TargetDependency.external(name: "Moya", condition: .none)
    static let combineMoya = TargetDependency.external(name: "CombineMoya", condition: .none)
    static let composableArchitecture = TargetDependency.external(name: "ComposableArchitecture", condition: .none)
    static let swinject = TargetDependency.external(name: "Swinject", condition: .none)
    static let supabase = TargetDependency.external(name: "Supabase", condition: .none)
    static let sdwebImage = TargetDependency.external(name: "SDWebImageSwiftUI", condition: .none)
    static let swiftJWT = TargetDependency.external(name: "SwiftJWT", condition: .none)
    static let firebaseFirestoreSwift = TargetDependency.external(name: "FirebaseFirestoreSwift", condition: .none)
    static let firebaseAuth = TargetDependency.external(name: "FirebaseAuth", condition: .none)
    static let firebaseDatabase = TargetDependency.external(name: "FirebaseDatabase", condition: .none)
    static let firebaseMessaging = TargetDependency.external(name: "FirebaseMessaging", condition: .none)
    static let firebaseFirestore = TargetDependency.external(name: "FirebaseFirestore", condition: .none)
    static let keychainAccess = TargetDependency.external(name: "KeychainAccess", condition: .none)
    static let kakaoSDKAuth = TargetDependency.external(name: "KakaoSDKAuth", condition: .none)
    static let kakaoSDKUser = TargetDependency.external(name: "KakaoSDKUser", condition: .none)
    static let kakaoSDKCommon = TargetDependency.external(name: "KakaoSDKCommon", condition: .none)

}

