import Foundation
import ProjectDescription
import ProjectTemplatePlugin
import DependencyPackagePlugin


let project = Project.makeAppModule(
    name: "ThirdPartys",
    bundleId: .appBundleID(name: ".ThirdPartys"),
    product: .staticFramework,
    settings: .appBaseSetting(appName: "ThirdPartys") ,
    dependencies: [
        .SPM.combineMoya,
        .SPM.moya,
        .SPM.swiftJWT,
        .SPM.composableArchitecture,
        .SPM.keychainAccess,
        .SPM.kakaoSDKAuth,
        .SPM.kakaoSDKUser,
        .SPM.kakaoSDKCommon
    ],
    sources: ["Sources/**"]
)
