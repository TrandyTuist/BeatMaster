import Foundation
import ProjectDescription
import ProjectTemplatePlugin
import DependencyPlugin


let project = Project.makeAppModule(
    name: "Auth",
    bundleId: .appBundleID(name: ".Auth"),
    product: .staticFramework,
    settings: .appBaseSetting(appName: "Auth"),
    dependencies: [
        .Shared(implements: .Shareds),
        .Networking(implements: .Networkings),
        .Feature(implements: .Profile)
        
    ],
    sources: ["Sources/**"],
//    infoPlist: .file(path: "../Support/Info.plist"),
    entitlements: .file(path: "../../Entitlements/BeatMaster.entitlements")
)
