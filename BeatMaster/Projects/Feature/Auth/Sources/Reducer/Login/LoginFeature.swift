//
//  LoginFeature.swift
//  Auth
//
//  Created by 서원지 on 2/25/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import AuthenticationServices

import DesignSystem
import Model

import ComposableArchitecture
import KeychainAccess

@Reducer
public struct LoginFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var loginMainImage: ImageAsset = .logoIcon
        var loginMainViewTitle: String = "BeatMaster"
        var auth: UserAuth?
        var isLogin: Bool = false
        var nonce: String = ""
        public init(auth: UserAuth? = nil) {
            self.auth = auth
        }
    }
    
    public enum Action: BindableAction {
        case backAction
        case isLogin(socialType: SocialType)
        case disappear
        case binding(BindingAction<State>)
        case appleLogin(
            result: Result<ASAuthorization, Error>,
            completion: () -> Void
        )
        case kakaoLogin(completion: () -> Void)
        
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(AuthUseCase.self) var authUseCase
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .backAction:
                return .run { _ in 
                    await self.dismiss()
                    
                }
                
            case let .isLogin(socialType: socialType):
                switch socialType {
                case .apple:
                    state.auth = state.auth
                    state.auth?.socialType = .apple
                    try? Keychain().set(state.auth?.socialType?.desc ?? "", key: "SocialType")
                    state.auth?.isLogin?.toggle()
                case .kakao:
                    state.auth = state.auth
                    state.auth?.socialType = .kakao
                    try? Keychain().set(state.auth?.socialType?.desc ?? "", key: "SocialType")
                    state.auth?.isLogin?.toggle()
                default:
                    break
                    
                }
                return .none
                
            case let .appleLogin(result: result, completion: completion):
                return .run { send in
                    await authUseCase.handleAppleLoginResult(
                        result: result,
                        completion: completion
                     )
                }
                
            case let .kakaoLogin(completion: completion):
                return .run { send in
                    await authUseCase.requestKakaoTokenAsync(completion: completion)
                }
                
            case .disappear:
                state.auth = state.auth
                return .none
                
            case .binding(_):
                return .none
            
                
            }
        }
        
    }
}

