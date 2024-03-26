//
//  AuthInputBox.swift
//  DesignSystem
//
//  Created by 서원지 on 3/24/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import SwiftUI

 public struct AuthInputBox: View {
    var inputBoxName: String
    var authInputBox: String
    
    public init(
        inputBoxName: String,
        authInputBox: String) {
        self.inputBoxName = inputBoxName
        self.authInputBox = authInputBox
    }
    
    public var body: some View {
        LazyVStack {
            HStack {
                Text(inputBoxName)
                    .pretendardFont(family: .SemiBold, size: 20)
                    .foregroundColor(Color.basicBlack)
                
                
                Spacer()
            }
            
            Spacer()
                .frame(height: 12)
            
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.basicGray3.opacity(0.8))
                .frame(height: 56)
                .overlay {
                    HStack {
                        Text(authInputBox)
                            .pretendardFont(family: .SemiBold, size: 18)
                            .foregroundColor(Color.basicBlack)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                }
            
        }
        .padding(.horizontal, 20)
    }
}
