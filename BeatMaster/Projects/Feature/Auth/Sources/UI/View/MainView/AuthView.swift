//
//  AuthView.swift
//  Auth
//
//  Created by 서원지 on 2/25/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import ComposableArchitecture


public struct AuthView: View {
    @Bindable var store: StoreOf<AuthFeature>
    var backAction: () -> Void = { }
    
    public init(
        store: StoreOf<AuthFeature>,
        backAction: @escaping () -> Void
    ) {
        self.store = store
        self.backAction = backAction
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            
            Spacer()
                .frame(height: 20)
            
            NavigationBackButton(buttonAction: backAction)
            
            logoImage()
            
            Spacer()
                .frame(height: 20)
            
            BounceAnimationView(text: store.state.authMainViewTitle, startTime: 0.0, fontSize: 40)
            
            Text(self.store.authModel?.isLogin?.description ?? "")
            
            signUpButtonView()
            
            loginButtonView()
               
            Spacer()
        }
        .onAppear {
            store.send(.appearLogin)
        }
        
        
        .sheet(item: $store.scope(state: \.loginFeature, action: \.presentBottomSheet)) { loginStore in
            LoginView(store: loginStore, backAction: {
                self.store.send(.addLoginBottomSheet)
            })
                .presentationDetents([.fraction(0.3)])
                .presentationCornerRadius(20)
                .presentationDragIndicator(.visible)
        }
    }
}


fileprivate extension AuthView {
    
    @ViewBuilder
    private func logoImage() -> some View {
        LazyVStack {
            Spacer()
                .frame(height: UIScreen.screenHeight*0.1)
            
            Image(asset: self.store.state.authMainImage)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenWidth*0.5, height: 200)
        }
    }
    
    @ViewBuilder
    private func loginButtonView() -> some View {
        Spacer()
            .frame(height: 8)

        LazyVStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.basicBlack, style: .init(lineWidth: 2))
                .frame(height: 56)
                .overlay {
                    Text("로그인하기")
                        .foregroundStyle(Color.basicBlack)
                        .pretendardFont(family: .SemiBold, size: 16)
                    
                }
                .onTapGesture {
                    store.send(.presntLoginBottomSheet)
                }
            
        }
        .padding(.horizontal, 20)
    }
    
    
    @ViewBuilder
    private func signUpButtonView() -> some View {
        Spacer()
            .frame(height: UIScreen.screenHeight*0.2)
        
        LazyVStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.basicBlack.opacity(0.9))
                .frame(height: 56)
                .overlay {
                    Text("회원가입 하기")
                        .foregroundStyle(Color.basicWhite)
                        .pretendardFont(family: .SemiBold, size: 16)
                    
                }
                .onTapGesture {
                    store.send(.presentSignUp)
                }
            
        }
        .padding(.horizontal, 20)
    }
}

