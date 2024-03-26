//
//  AuthRepositoryProtocol.swift
//  Auth
//
//  Created by 서원지 on 3/19/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import AuthenticationServices
import Model

public protocol AuthRepositoryProtocol {
    
    func handleAppleLoginResult(
        result: Result<ASAuthorization, Error>,
        completion: @escaping () -> Void
    ) async
    
    func getAppleRefreshToken(
        code: String,
        completionHandler: @escaping (String?) -> Void
    )
    
        
    func requestKakaoTokenAsync(
        completion: @escaping () -> Void
    ) async 
    
    func authModelToReducer(auth: UserAuth)
    
    func getUserInfoKakao(auth: UserAuth)
}


final class DefaultAuthRepository : AuthRepositoryProtocol {
    
    func handleAppleLoginResult(
        result: Result<ASAuthorization, Error>,
        completion: @escaping () -> Void)  {
        
    }
    
    func getAppleRefreshToken(
        code: String,
        completionHandler: @escaping (String?) -> Void) {
            
        }
    
    
    func requestKakaoTokenAsync(
        completion: @escaping () -> Void
    ) async {
        
    }
    
    func authModelToReducer(auth: UserAuth)  {
        
    }
    
    func getUserInfoKakao(auth: UserAuth) {
        
    }
}
