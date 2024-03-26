//
//  AppleAuthService.swift
//  Service
//
//  Created by 서원지 on 3/19/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import API
import Moya

public enum AppleAuthService {
    case getRefreshToken(code: String, clientSecret: String)
}

extension AppleAuthService: AppleLoginTarget {
    public var path: String {
        switch self {
        case .getRefreshToken:
            return BeatMaserAuthAPI.appleLogin
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .getRefreshToken:
            return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .getRefreshToken(let code, let clientSecret):
            let parameters: [String: Any] = [
                "client_id": "com.Haejoo.BeatMaster",
                "client_secret": clientSecret,
                "code": code,
                "grant_type": "authorization_code"
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            
        }
    }
    
}
