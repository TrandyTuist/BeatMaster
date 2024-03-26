//
//  base.swift
//  BeatMaster
//
//  Created by 서원지 on 2024/03/26
//  Copyright © 2024 Team.hae.jo, All rights reserved.
//

import SwiftUI

import DesignSystem

import ComposableArchitecture

public struct ProfileView: View {
    @Bindable var store : StoreOf<ProfileFeature>
    var backAction: () -> Void = { }
    
    public init(
        store: StoreOf<ProfileFeature>,
        backAction: @escaping () -> Void
    ) {
        self.store = store
        self.backAction = backAction
    }
    
    public var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            
            NavigationBackButton(buttonAction: {
               backAction()
            })
            
            Spacer()
            
            Text(store.state.title)
                .pretendardFont(family: .Bold, size: 40)
            
            Spacer()
                .frame(height: 20)
            
            Text("로그아웃")
                .pretendardFont(family: .Bold, size: 20)
                .onTapGesture {
                    store.send(.logout)
                    backAction()
                }
            
            Spacer()
        }
    }
}
    


