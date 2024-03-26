import Foundation
import ProjectDescription
import ProjectTemplatePlugin
import DependencyPackagePlugin

let project = Project.makeAppModule(
    name: "ThirdParty",
    bundleId: .appBundleID(name: ".ThirdParty"),
    product: .staticFramework,
    settings:  .appBaseLibraySetting(appName: "ThirdParty"),
    dependencies: [
        .SPM.composableArchitecture,
        .SPM.sdwebImage,
        .SPM.swiftJWT,
        .SPM.firebaseAuth,
        .SPM.firebaseDatabase,
        .SPM.firebaseMessaging,
        .SPM.keychainAccess,
        .SPM.kakaoSDKAuth,
        .SPM.kakaoSDKUser,
        .SPM.kakaoSDKCommon
//        .SPM.supabase
    ],
    sources: ["Sources/**"]
)
