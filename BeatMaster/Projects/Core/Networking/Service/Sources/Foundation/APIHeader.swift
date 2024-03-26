//
//  APIHeader.swift
//  Service
//
//  Created by 서원지 on 3/19/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//


import Foundation
import API

struct APIConstants{
    
    static let contentType = "Content-Type"
    static let appPackageName = "App-Package-Name"
    static let apikey =  "apikey"
    static let cookie = "Cookie"
    
}

extension APIConstants {
    static var baseHeader: Dictionary<String, String> {
        [
          contentType : APIHeaderManger.shared.contentType
        ]
    }
    static var appleLoginHeader: Dictionary<String, String> {
        [
          contentType : APIHeaderManger.shared.contentAppleType
        ]
    }
}

