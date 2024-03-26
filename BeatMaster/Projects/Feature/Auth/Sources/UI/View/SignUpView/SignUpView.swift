//
//  SignUpView.swift
//  Auth
//
//  Created by 서원지 on 3/2/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import SwiftUI

import ComposableArchitecture

import DesignSystem

public struct SignUpView: View {
    @Bindable var store: StoreOf<SignUpFeature>
    
    var backAction: () -> Void = { }
    
    public init(
        store: StoreOf<SignUpFeature>,
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
            
            policyTitle()
            
            serviceUseAgreeTextView()
            
            activeServiceButton()
            
            Spacer()
            
        }
        .onAppear {
            store.send(.appear)
        }
        .sheet(item: $store.scope(state: \.selectSocial, action: \.selectSocial)) { selectSocialStore in
            SelectSocialTypeView(store: selectSocialStore, selectLoginAction: {
                store.send(.saveSelectSocial)
            })
                .presentationDetents([.fraction(0.3)])
                .presentationCornerRadius(20)
                .presentationDragIndicator(.visible)
            
        }
    }
}


fileprivate extension SignUpView {
    
    @ViewBuilder
    private func policyTitle() -> some View {
        Spacer()
            .frame(height: 20)
        
        VStack(spacing: .zero) {
            HStack {
                Text(store.state.policyTitle)
                    .pretendardFont(family: .SemiBold, size: 24)
                    .foregroundColor(Color.lightPurple)
                
                Text("에")
                    .pretendardFont(family: .SemiBold, size: 24)
                    .foregroundColor(Color.basicBlack)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack {
                Text("동의해주세요")
                    .pretendardFont(family: .SemiBold, size: 24)
                    .foregroundColor(Color.basicBlack)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
       
        
    }
    
    @ViewBuilder
    private func serviceUseAgreeTextView() -> some View {
        VStack {
            Spacer()
                .frame(height: 40)
            

            AgreeMentListView(
                checkAgreeButton: $store.isAllAgreed,
                showleft: false,
                title: "전체 약관에 동의합니다",
                agreeAllService: true,
                essential: .essential,
                webViewLoading: .constant(false),
                allServiceAction: {
                    store.send(.didTapAgreeAllPolicy)
                },
                serviceAction: {},
                gotoWebView: {}
            )
            
            
            Spacer()
                .frame(height: 20)
            
            AgreeMentListView(
                checkAgreeButton: $store.isTermsofServiceAgreed,
                showleft: true,
                title: "서비스 이용약관 동의",
                agreeAllService: false,
                essential: .essential,
                webViewLoading: .constant(false), 
                allServiceAction: { } ,
                serviceAction: {
                    store.send(.didTapAgreeServicePolicy)
                },
                gotoWebView: {
                    self.store.send(.presentWebTermsofServiceAgreed)
                }
            )
            
            Spacer()
                .frame(height: 20)
            
            AgreeMentListView(
                checkAgreeButton: $store.isServicePolicyAgreed,
                showleft: true,
                title: "개인정보 수집 및 이용동의",
                agreeAllService: false,
                essential: .essential,
                webViewLoading: .constant(false),
                allServiceAction: { },
                serviceAction: {
                    store.send(.didTapAgreePrivacyPolicy)
                },
                gotoWebView: {
                    self.store.send(.presentPolicyAgreedWeb)
                }
            )
            
            Spacer()
                .frame(height: 20)
            
            AgreeMentListView(
                checkAgreeButton: $store.isMarketingInformationAgreed,
                showleft: true,
                title: "마켓팅 정보  수신 동의",
                agreeAllService: false,
                essential: .choice,
                webViewLoading: .constant(false),
                allServiceAction: {},
                serviceAction: {
//                    store.send(.didTapAgreeMarketingInformation)
                },
                gotoWebView: {
                    self.store.send(.presentMarketingInformationAgreed)
                }
            )
            
        }
    }
    
    @ViewBuilder
    private func activeServiceButton() -> some View {
        Spacer()
            .frame(height: UIScreen.screenHeight*0.4)
        
        VStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(self.store.isConfirmButtonActivated ? Color.lightPurple : Color.gray)
                .frame(height: 56)
                .overlay {
                    Text("다음")
                        .foregroundStyle(Color.basicWhite)
                        .pretendardFont(family: .SemiBold, size: 16)
                    
                }
                .onTapGesture {
                    self.store.send(.selectSocialBottomSheet)
                }
                .disabled(!self.store.isConfirmButtonActivated)
        }
        .padding(.horizontal, 20)
        
    }
}
