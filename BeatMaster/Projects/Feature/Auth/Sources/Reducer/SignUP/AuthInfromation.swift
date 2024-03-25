//
//  AuthInfromationFeature.swift
//  Auth
//
//  Created by 서원지 on 3/17/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//


import Foundation

import Model

import ComposableArchitecture

@Reducer
public struct AuthInfromationFeature {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        var title: String = "회원가입 정보입력"
        var auth: UserAuth?
        var selectJob: SelectJob? = nil
        var disableSignUpButtonb: Bool = false
        
        public init(auth: UserAuth? = nil) {
            self.auth = auth
        }
       
    }
    
    @Dependency(\.dismiss) var dismiss
    @Dependency(AuthUseCase.self) var authUseCase
    
    public enum Action {
        case backAction
        case appear
        case selectJobButton(selectJob: SelectJob?)
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backAction:
                return .run { send in
                     await dismiss()
                }
                
            case .appear:
                state.auth = state.auth
                return .none
                        
                
            case let .selectJobButton(selectJob: selectJob):
                if state.selectJob == selectJob {
                    state.selectJob = nil
                } else {
                    state.selectJob = selectJob
                }
                state.disableSignUpButtonb = state.selectJob != nil
                return .none
            }
        }
    }
}


public enum SelectJob: String, CaseIterable {
    case drummer
    case drumlesson
    case hobbyDrum
    
    public var desc: String {
        switch self {
        case .drummer:
            return "드러마/연주자"
        case .drumlesson:
            return "드럼레슨생"
        case .hobbyDrum:
            return "드럼 취미생"
        }
    }
    
}
