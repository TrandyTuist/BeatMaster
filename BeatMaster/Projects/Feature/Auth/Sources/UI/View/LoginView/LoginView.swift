//
//  LoginView.swift
//  Auth
//
//  Created by 서원지 on 2/25/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture
import KakaoSDKAuth
import KakaoSDKUser
import AuthenticationServices


public struct LoginView: View {
    @Bindable var store: StoreOf<LoginFeature>
    var backAction: () -> Void = { }
    
    
    public init(
        store: StoreOf<LoginFeature>,
        backAction: @escaping () -> Void
    ) {
        self.store = store
        self.backAction = backAction
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            
            Spacer()
                .frame(height: 20)
            
            appleLoginButton()
            
            kakoTalkLoginButton()
               
            Spacer()
        }
    }
    
}

fileprivate extension LoginView {
    
    @ViewBuilder
    private func appleLoginButton() -> some View {
        Spacer()
            .frame(height: UIScreen.screenHeight*0.03)
        
        LazyVStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.basicBlack.opacity(0.9))
                .frame(height: 56)
                .overlay {
                    SignInWithAppleButton(.signIn) { request in
                        store.nonce = AppleLoginManger.shared.randomNonceString()
                        request.requestedScopes = [.fullName, .email]
                        request.nonce = AppleLoginManger.shared.sha256(store.nonce)
                    } onCompletion: { result in
                        store.send(.appleLogin(result: result, completion: {
                            
                        }))
                        store.send(.isLogin(socialType: .apple), animation: .default)
                        backAction()
                    }
                    .padding(.horizontal, 5)
                    
                }
            
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func kakoTalkLoginButton() -> some View {
        Spacer()
            .frame(height: 12)
        
        LazyVStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.clear, style: .init(lineWidth: 2))
                .frame(height: 56)
                .overlay {
                    Image(asset: .kakao_login)
                        .resizable()
                        .scaledToFit()
                    
                }
                .onTapGesture {
                    store.send(.kakaoLogin(completion: {
                        
                    }))
                    
                    store.send(.isLogin(socialType: .kakao), animation: .default)
                    backAction()
                }
            
        }
        .padding(.horizontal, 20)
    }
    
    
    
}

