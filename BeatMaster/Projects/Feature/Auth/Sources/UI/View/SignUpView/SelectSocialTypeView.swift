//
//  SelectSocialTypeView.swift
//  Auth
//
//  Created by 서원지 on 3/16/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import AuthenticationServices

import DesignSystem

import ComposableArchitecture

public struct SelectSocialTypeView: View {
    @Bindable var store: StoreOf<SelectSocialFeature>
    var selectLoginAction: () -> Void = { }
    
    public init(
        store: StoreOf<SelectSocialFeature>,
        selectLoginAction: @escaping () -> Void
    ) {
        self.store = store
        self.selectLoginAction = selectLoginAction
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


extension SelectSocialTypeView {
    
    @ViewBuilder
    private func appleLoginButton() -> some View {
        Spacer()
            .frame(height: UIScreen.screenHeight*0.03)
        
        LazyVStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.basicBlack.opacity(0.9))
                .frame(height: 56)
                .overlay {
                    SignInWithAppleButton(.signUp) { request in
                        request.requestedScopes = [.fullName, .email]
                    } onCompletion: { result in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            store.send(.appleSignUp(result: result, completion: {
                                store.send(.selectSignUp(socialType: .apple))
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    selectLoginAction()
                                }
                            }), animation: .default)
                        }
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
                    store.send(.kakaoSignUp(completion: {
                        store.send(.selectSignUp(socialType: .kakao))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            selectLoginAction()
                        }
                    }), animation: .default)
                    
                }
            
        }
        .padding(.horizontal, 20)
    }
}
