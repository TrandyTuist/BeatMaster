//
//  Auth.swift
//  Model
//
//  Created by 서원지 on 3/8/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation

public struct AuthModel: Equatable, Identifiable {
    public var data: UserAuth
    public var id: UUID = UUID()
    
    public init(data: UserAuth) {
        self.data = data
    }
}

public struct UserAuth : Equatable, Identifiable{
    public var id: UUID = UUID()
    public var isLogin: Bool?
    public var socialType: SocialType?
    public var token: String
    public var name: String
    public var email: String
    
    public init(
        isLogin: Bool? = false,
        token: String,
        socialType: SocialType?,
        name: String,
        email: String) {
            self.isLogin = isLogin
            self.token = token
            self.name = name
            self.socialType = socialType 
            self.email = email
        }
    
}

public enum SocialType: String {
    case apple = "Apple"
    case kakao = "Kakao"
    case unknown
    
    public var desc: String {
        switch self {
        case .apple:
            return "Apple"
        case .kakao:
            return "Kakao"
        case .unknown:
            return "Unknown"
        }
    }
}
