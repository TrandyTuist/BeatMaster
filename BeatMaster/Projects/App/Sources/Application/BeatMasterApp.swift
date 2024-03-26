import SwiftUI
//import Auth
import KakaoSDKCommon
import KakaoSDKAuth

import ComposableArchitecture

@main
struct BeatMasterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        initializeKakao()
        registerDependencies()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(
                store:
                    Store(
                        initialState: AppFeature.State(),
                        reducer: {
                            AppFeature()
                                ._printChanges()
                        }
                    )
            )
            .onOpenURL { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
    
    private func registerDependencies() {
        AppDIContainer.shared.registerDependencies()
    }
    
    private func initializeKakao() {
        guard let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String else {
            return
        }
        KakaoSDK.initSDK(appKey: kakaoAppKey)
    }
}
