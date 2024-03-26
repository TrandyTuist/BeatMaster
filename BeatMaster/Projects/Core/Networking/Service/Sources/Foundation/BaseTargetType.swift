//
//  BaseTargetType.swift
//  Service
//
//  Created by 서원지 on 3/19/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Moya
import API

public protocol BaseTargetType: TargetType {}


extension BaseTargetType {
    public var baseURL: URL {
        return URL(string: BeatMaserAPI.baseURL)!
    }
    
    public var headers: [String : String]? {
        return APIConstants.baseHeader
    }
    
}
