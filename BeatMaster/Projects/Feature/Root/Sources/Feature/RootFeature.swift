//
//  RootFeature.swift
//  Root
//
//  Created by 서원지 on 2/19/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Auth
import Profile
import DesignSystem
import API
import Model


import ComposableArchitecture
import KeychainAccess

@Reducer
public struct RootFeature{
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        
        var title: String = "Root"
        var isLogin: Bool = false
        var webLoading: Bool = false
        var path: StackState<Path.State> = .init()
    }
    
    public enum Action: BindableAction{
        case path(StackAction<Path.State, Path.Action>)
        
        case binding(BindingAction<State>)
        case presentAuth
        case isLoginPresntAuth
        case removePath
        case removeAllPath
    }
    
    @Reducer(state: .equatable)
    public enum Path {
        case auth(AuthFeature)
        case login(LoginFeature)
        case signUp(SignUpFeature)
        case authInfo(AuthInfromationFeature)
        case profile(ProfileFeature)
        case web(WebFeature)
    }
    
    //MARK: - 1.8 이하 버전 path 추가
//    @Reducer
//    public struct Path {
//        public init() {}
//        
//        
//        @ObservableState
//        public enum State: Equatable {
//            case auth(AuthFeature.State)
//        }
//        
//        public enum Action: Equatable {
//            case auth(AuthFeature.Action)
//        }
//        
//        
//        public var body: some ReducerOf<Self> {
//            Scope(state: /State.auth, action: /Action.auth) {
//                AuthFeature()
//            }
//        }
//    }
    
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
//            case .path:
//                return .none
                
            case .isLoginPresntAuth:
                return .none
//                if state.userModel.first?.isLogin == true {
//                    state.userModel.append(Auth(isLogin: true, token: "", name: "", email: ""))
//                } else {
//                    state.userModel.append(Auth(isLogin: false, token: "", name: "", email: ""))
//                }
                
                
            case .presentAuth:
                let login: String = (try? Keychain().get("isLogin")) ?? ""
                
                switch login {
                case "true":
                    let email: String = (try? Keychain().get("EMAIL")) ?? ""
                    let name: String = (try? Keychain().get("NAME")) ?? ""
                    let token = (try? Keychain().get("Token")) ?? ""
                    let socialTypeString: String = (try? Keychain().get("SocialType")) ?? ""
                    let socialType: SocialType = SocialType(rawValue: socialTypeString) ?? .unknown
                    let login: String = (try? Keychain().get("isLogin")) ?? ""
                    print(socialTypeString, socialType)
                    state.path.append(.profile(.init(auth: UserAuth(isLogin: Bool(login) ,token: token, socialType: socialType, name: name, email: email))))
                case "false":
                    state.path.append(.auth(.init()))
                default:
                    state.path.append(.auth(.init()))
                }
                return .none
                
            case .path(.element(id:_, action: .auth(.presentLogin))):
                let email: String = (try? Keychain().get("EMAIL")) ?? ""
                let nickname: String = (try? Keychain().get("NAME")) ?? ""
                state.path.append(.login(.init(auth: UserAuth(token: "", socialType: .apple, name: nickname, email: email))))
                return .none
                
//            case .path(.element(id:_, action: .auth(.presentAuthInformation))):
//                state.path.append(.authInformation(.init()))
//                return .none
                
            case .path(.element(id: _, action: .auth(.presentSignUp))):
                let email: String = (try? Keychain().get("EMAIL")) ?? ""
                let nickname: String = (try? Keychain().get("NAME")) ?? ""
                state.path.append(.signUp(.init(auth: UserAuth(token: "", socialType: .apple, name: nickname, email: email))))
                return .none
                
            case .path(.element(id: _, action: .signUp(.presentPolicyAgreedWeb))):
                state.path.append(.web(.init(url: APIManger.shared.privacyPolicyURL)))
                return .none
                
            case .path(.element(id: _, action: .signUp(.presentWebTermsofServiceAgreed))):
                state.path.append(.web(.init(url: APIManger.shared.serviceAgreeMentURL)))
                return .none
                
            case .path(.element(id: _, action: .signUp(.presentMarketingInformationAgreed))):
                state.path.append(.web(.init(url: APIManger.shared.marketAgreeMentURL)))
                return .none
                
            case .path(.element(id: _, action: .authInfo(.presntProfile))):
                let email: String = (try? Keychain().get("EMAIL")) ?? ""
                let name: String = (try? Keychain().get("NAME")) ?? ""
                let token = (try? Keychain().get("Token")) ?? ""
                let socialTypeString: String = (try? Keychain().get("SocialType")) ?? ""
                let socialType: SocialType = SocialType(rawValue: socialTypeString) ?? .unknown
                let login: String = (try? Keychain().get("isLogin")) ?? ""
                print(socialTypeString, socialType)
                state.path.append(.profile(.init(auth: UserAuth(isLogin: Bool(login) ,token: token, socialType: socialType, name: name, email: email))))
                return .none
                
            case .path(.element(id: _, action: .signUp(.presntAuthInfo))):
                let email: String = (try? Keychain().get("EMAIL")) ?? ""
                let name: String = (try? Keychain().get("NAME")) ?? ""
                let token: String = (try? Keychain().get("Token")) ?? ""
                let socialTypeString: String = (try? Keychain().get("SocialType")) ?? ""
                let socialType: SocialType = SocialType(rawValue: socialTypeString) ?? .unknown
                state.path.append(.authInfo(.init(auth: UserAuth(token: token, socialType: socialType, name: name, email: email))))
                return .none
                
            case .removePath:
                state.path.removeLast()
                return .none
                
            case .removeAllPath:
                state.path.removeAll()
                return .none
                
            case  .binding(_):
                return .none
                
            default:
                return .none
            }
        }
        //MARK: -  1.8 이하
//        .forEach(\.path, action: \.path) {
//            Path()
//        }
        .forEach(\.path, action: \.path)
    }
}

