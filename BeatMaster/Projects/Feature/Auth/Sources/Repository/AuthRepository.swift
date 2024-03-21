//
//  AuthRepository.swift
//  Auth
//
//  Created by 서원지 on 3/19/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import AuthenticationServices
import SwiftUI
import Combine

import Model
import Service

import Moya
import CombineMoya
import SwiftJWT
import FirebaseFirestore
import Firebase
import FirebaseAuth
import KeychainAccess
import KakaoSDKAuth
import KakaoSDKUser

@Observable public class AuthRepository: AuthRepositoryProtocol {
    
    var userSession: Firebase.User?
    var authModel: UserAuth?
    var appleAuthModel: AppleTokenResponse?
    var appleAuthCancellable: AnyCancellable?
    
    
    public init() {
        self.userSession = Auth.auth().currentUser
    }
    
    //MARK: - 애플 로그인
    public func handleAppleLoginResult(
        result: Result<ASAuthorization, Error>,
        completion: @escaping () -> Void
    ) async {
        switch result {
        case .success(let authResults):
            switch authResults.credential {
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                guard let tokenData = appleIDCredential.identityToken,
                      let identityToken = String(data: tokenData, encoding: .utf8) else {
                    Log.error("Identity token is missing")
                    return
                }
                let lastName = appleIDCredential.fullName?.familyName ?? ""
                let firstName = appleIDCredential.fullName?.givenName ?? ""
                let name = "\(lastName)\(firstName)"
                let email = appleIDCredential.email ?? ""
                try? Keychain().set(appleIDCredential.email ?? "", key: "EMAIL")
                try? Keychain().set(name, key: "NAME")
                
                
                if let authorizationCode = appleIDCredential.authorizationCode {
                    let code = String(decoding: authorizationCode, as: UTF8.self)
                    print("Code - \(code), \(email), \(name)")
                    self.getAppleRefreshToken(code: code) { [weak self] data in
                        Log.debug("🚧", data ?? "-")
                        try? Keychain().set(data ?? "", key: "Token")
                        // UserDefaults.standard.set(data, forKey: "AppleRefreshToken")
                    }
                } else {
                    Log.error("🚧 authorizationCode is nil")
                }
                Log.debug("email: \(email)", (try? Keychain().get("EMAIL")) ?? "",  
                          (try? Keychain().get("NAME")) ?? "", self.authModel?.token)
                completion()
            default:
                break
            }
        case .failure(let error):
            Log.error("에러", error.localizedDescription, Self.self ,#function)
        }
    }
    
    
    public func requestKakaoTokenAsync(
        completion: @escaping () -> Void
    ) async {
         UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            guard let accessToken = oauthToken?.accessToken else {
                Log.error(error?.localizedDescription, "requestKakaoTokenAsync")
//                    continuation.resume(returning: (nil, nil))
                return
            }
             try? Keychain().set(accessToken, key: "Token")
             print("\(accessToken), \(self.authModel?.token)")
            completion()
        }
    }
    
    
    private func appleAuthToUseCase(_ list: AppleTokenResponse) {
        self.appleAuthModel = list
    }
    
    //MARK: - jwt 만들기
    func makeJWT() -> String {
        let myHeader = Header(kid: "P552TDR3Q2")
        
        // MARK: - client_secret(JWT) 발급 응답 모델
        struct MyClaims: Claims {
            let iss: String
            let iat: Int
            let exp: Int
            let aud: String
            let sub: String
        }
        
        var dateComponent = DateComponents()
        dateComponent.month = 6
        let iat = Int(Date().timeIntervalSince1970)
        let exp = iat + 3600
        let myClaims = MyClaims(iss: "N94CS4N6VR",
                                iat: iat,
                                exp: exp,
                                aud: "https://appleid.apple.com",
                                sub: "com.Haejoo.BeatMaster")
        
        var myJWT = JWT(header: myHeader, claims: myClaims)
        guard let url = Bundle.main.url(forResource: "AuthKey_P552TDR3Q2", withExtension: "p8"),
              let privateKey: Data = try? Data(contentsOf: url, options: .alwaysMapped),
              let signedJWT = try? myJWT.sign(using: JWTSigner.es256(privateKey: privateKey))
        else {
            return ""
        }
        Log.debug("🗝 singedJWT -", signedJWT)
        return signedJWT
    }
    
    //MARK: - 애플 리프레쉬 토근  발급
    public func getAppleRefreshToken(
        code: String,
        completionHandler: @escaping (String?) -> Void
    ) {
        if let cancellable = appleAuthCancellable {
            cancellable.cancel()
        }
        
        let secret = makeJWT()
        let provider = MoyaProvider<AppleAuthService>(plugins: [MoyaLoggingPlugin()])
        appleAuthCancellable = provider.requestWithProgressPublisher(.getRefreshToken(code: code, clientSecret: secret))
            .compactMap{$0.response?.data}
            .receive(on: DispatchQueue.main)
            .decode(type: AppleTokenResponse.self, decoder: JSONDecoder())
            .sink(receiveCompletion: { [weak self] result in
                switch result {
                case .finished:
                    break
                case .failure(let error):
                    Log.error("애플 토큰 발급 실패 -", error.localizedDescription)
                }
            }, receiveValue: { [weak self] model in
                self?.appleAuthToUseCase(model)
                Log.network("애플 토큰 발급 성공 ", model)
                if model.refresh_token == nil {
                    Log.error("if model.refresh_token == nil")
                } else {
                    completionHandler(model.refresh_token)
                }
            })
        
    }
    
    
}
