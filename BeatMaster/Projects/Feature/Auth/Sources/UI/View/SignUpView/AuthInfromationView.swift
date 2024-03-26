//
//  AuthInfromationView.swift
//  Auth
//
//  Created by 서원지 on 3/17/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem

import ComposableArchitecture
import KakaoSDKAuth
import KakaoSDKUser
import Profile

public struct AuthInfromationView: View {
    @Bindable var store: StoreOf<AuthInfromationFeature>
    var backAction: ()  -> Void = { }
    
    public init(
        store: StoreOf<AuthInfromationFeature>,
        backAction: @escaping () -> Void
    ) {
        self.store = store
        self.backAction = backAction
    }
    
    
    
    public  var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            
            NavigationBackButton(buttonAction: {
                self.store.send(.backAction)
                
                backAction()
            })
            
            Spacer()
                .frame(height: 30)
            
            headerView()
            
            authInfoInputView()
            
            selectJob()
            
            signUPButton()
            
            Spacer()
            
        }
        .onAppear {
            
        }
    }
}

fileprivate extension AuthInfromationView {
    
    @ViewBuilder
    private func headerView() -> some View {
        LazyVStack  {
            HStack {
                Text(self.store.title)
                    .pretendardFont(family: .SemiBold, size: 30)
                    .foregroundColor(Color.basicBlack)
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func signupSocailType() -> some View {
        LazyVStack {
            HStack {
                Text(self.store.auth?.socialType?.desc ?? "")
                    .pretendardFont(family: .SemiBold, size: 30)
                    .foregroundColor(Color.basicBlack)
                
                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func authInfoInputView() -> some View {
        LazyVStack{
            Spacer()
                 .frame(height: 20)
             
             AuthInputBox(inputBoxName: "이름", authInputBox: store.auth?.name ?? "")
            
            Spacer()
                .frame(height: 12)
            
            AuthInputBox(inputBoxName: "이메일", authInputBox: store.auth?.email ?? "")
            
            Spacer()
                .frame(height: 12)
            
            
            
        }
    }
    
    @ViewBuilder
    private func selectJob() -> some View {
        LazyVStack {
            HStack {
                Text("드럼연주자")
                    .pretendardFont(family: .SemiBold, size: 20)
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 12)
            
            HStack {
                ForEach(SelectJob.allCases, id: \.self) { item in
                    HStack {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(store.selectJob == item ? Color.clear : Color.basicBlack, style: .init(lineWidth: 1))
                            .fill(store.selectJob == item ? Color.lightPurple : Color.clear)
                            .frame(width: UIScreen.screenWidth*0.3, height: 30)
                            .overlay {
                                Text(item.desc)
                                    .pretendardFont(family: .SemiBold, size: 15)
                                    .foregroundColor(store.selectJob == item ? Color.basicWhite : Color.basicBlack)
                            }
                            .onTapGesture {
                                store.send(.selectJobButton(selectJob: item))
                            }
                        
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private func signUPButton() -> some View {
        Spacer()
            .frame(height: UIScreen.screenHeight * 0.3)
        
        LazyVStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(store.disableSignUpButtonb ? Color.lightPurple : Color.basicGray5)
                .frame(height: 56)
                .overlay {
                    Text("회원가입")
                        .pretendardFont(family: .SemiBold, size: 20)
                        .foregroundColor(store.disableSignUpButtonb ? Color.basicWhite : Color.basicBlack)
                }
                .disabled(!self.store.disableSignUpButtonb)
                .onTapGesture {
                    self.store.send(.presntProfile)
                }
        }
        .padding(.horizontal, 20)
    }
}
