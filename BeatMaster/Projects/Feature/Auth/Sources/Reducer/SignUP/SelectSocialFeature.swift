//
//  SelectSocialFeature.swift
//  Auth
//
//  Created by 서원지 on 3/16/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import AuthenticationServices

import Model

import ComposableArchitecture
import KeychainAccess


@Reducer
public struct SelectSocialFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var auth: UserAuth?
        
        public init(auth: UserAuth? = nil) {
            self.auth = auth
        }
        
    }
    
    @Dependency(AuthUseCase.self) var authUseCase
    
    public enum Action {
        case selectSignUp(socialType: SocialType)
        case appleSignUp(
            result: Result<ASAuthorization, Error>,
            completion: () -> Void
        )
        case kakaoSignUp(completion: () -> Void)
    }
    
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .selectSignUp(socialType: socialType):
                switch socialType {
                case .apple:
                    state.auth?.socialType = .apple
                    try? Keychain().set(state.auth?.socialType?.desc ?? "", key: "SocialType")
                    print("Apple 회원가입, \(state.auth)")
                    
                case .kakao:
                    state.auth?.socialType = .kakao
                    try? Keychain().set(state.auth?.socialType?.desc ?? "", key: "SocialType")
                    print("카카오 회원가입, \(state.auth)")
                default:
                    break
                }
                return .none
             
            case let .appleSignUp(result: result, completion: completion):
                guard let auth = state.auth
                else {return .none}
                authUseCase.authModelToReducer(auth: auth)
                return .run { send in
                    await authUseCase.handleAppleLoginResult(result: result, completion: completion)
                }
                
            case let .kakaoSignUp(completion: completion):
                guard let auth = state.auth
                else {return .none}
                authUseCase.authModelToReducer(auth: auth)
                return .run { send in
                    await authUseCase.requestKakaoTokenAsync(completion: completion)
                }
            }
        }
    }
}

