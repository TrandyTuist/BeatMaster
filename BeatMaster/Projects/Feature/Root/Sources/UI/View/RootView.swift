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
import DesignSystem

public struct RootView: View {
   let store: StoreOf<RootFeature>
    
    public init(store: StoreOf<RootFeature>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: \.path)) {
            VStack {
                
                Spacer()
                    .frame(height: 20)
                
                settingTap()
                
                Spacer()
                    
                
                Text(store.state.title)
                    .pretendardFont(family: .Bold, size: 40)
                
                Spacer()
            }
        } destination: { swithStore in
            switch swithStore.state {
            case .auth:
                if let authStore = swithStore.scope(state: \.auth, action: \.auth) {
                    AuthView(store: authStore) {
                        store.send(.removePath)
                    }
                    .navigationBarBackButtonHidden()
                }
            }
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
