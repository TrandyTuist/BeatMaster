//
//  RootView.swift
//  Root
//
//  Created by 서원지 on 2/19/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture
import SwiftUI
import Auth
import Profile
import DesignSystem

public struct RootView: View {
   @Bindable var store: StoreOf<RootFeature>
    
    public init(store: StoreOf<RootFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack(path: self.$store.scope(state: \.path, action: \.path)){
            VStack {
                
                Spacer()
                    .frame(height: 20)
                
                settingTap()
                
                Spacer()
                    
                
                Text(store.state.title)
                    .pretendardFont(family: .Bold, size: 40)
                
                Spacer()
            }
            .navigationBarBackButtonHidden()
        } destination: { swithStore in
            switch swithStore.case {
            case let .auth(authStore):
                AuthView(store: authStore, backAction: {
                    store.send(.removePath)
                })
                .navigationBarBackButtonHidden()
                
            case let .login(loginStore):
                LoginView(store: loginStore) {
                    store.send(.removePath)
                }
                .navigationBarBackButtonHidden()
                
            case let .signUp(signUpStore):
                SignUpView(store: signUpStore) {
                    store.send(.removePath)
                }
                .navigationBarBackButtonHidden()
                
            case let .web(webStore):
                WebViews(
                    store: webStore,
                    loading: $store.webLoading
                )
                .navigationBarBackButtonHidden()
                
            case let .authInfo(authInfoStore):
                AuthInfromationView(
                    store: authInfoStore){
                        store.send(.removePath)
                    }
                .navigationBarBackButtonHidden()
                
            case let .profile(profileStore):
                ProfileView(store: profileStore) {
                    store.send(.removeAllPath)
                }
                .navigationBarBackButtonHidden()
            }
            
            //MARK: -  1.7 이하
//            switch swithStore.state {
//            case .auth:
//                if let authStore = swithStore.scope(
//                    state: \.auth,
//                    action: \.auth
//                ) {
//                    AuthView(store: authStore) {
//                        store.send(.removePath)
//                    }
//                    .navigationBarBackButtonHidden()
//                }
//            }
        }
        .onAppear{
            store.send(.isLoginPresntAuth)
        }
    }
}


fileprivate extension RootView {
    
    @ViewBuilder
    private func settingTap() -> some View {
        HStack {
            Spacer()
            
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.primaryOrangeDark)
                .onTapGesture {
                    store.send(.presentAuth)
                }
            
        }
        .padding(.horizontal, 20)
    }
    
}


#if DEBUG || Dev
#Preview {
    RootView(
        store: Store(
            initialState: RootFeature.State(),
            reducer: {
                RootFeature()
                    ._printChanges()
            }
        )
    )
}
#endif
