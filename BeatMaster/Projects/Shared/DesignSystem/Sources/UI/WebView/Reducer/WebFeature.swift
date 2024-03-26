//
//  WebFeature.swift
//  DesignSystem
//
//  Created by 서원지 on 3/14/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct WebFeature {
    public init(){}
    
    @ObservableState
    public struct State: Equatable {
        var url: String = ""
        
        public init(
            url: String
        ) {
            self.url = url
        }
        
    }
    
    public enum Action: Equatable {
        case didTapBackButton
    }
    
    @Dependency(\.dismiss) var dismiss
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapBackButton:
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
    }
}

