//
//  ProfileFeature.swift
//  Profile
//
//  Created by 서원지 on 3/26/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//


import Foundation

import Model

import ComposableArchitecture
import KeychainAccess

@Reducer
public struct ProfileFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var title: String = "프로필"
        var auth: UserAuth?
        public init(
            auth: UserAuth? = nil
        ) {
            self.auth = auth
        }
    }
    
    public enum Action: Equatable {
        case backAction
        case logout
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backAction:
                return .run { send in
                    await dismiss()
                }
                
            case .logout:
                state.auth?.isLogin = false
                try? Keychain().set(state.auth?.isLogin?.description ?? "", key: "isLogin")
                return .none
            }
        }
    }
}

