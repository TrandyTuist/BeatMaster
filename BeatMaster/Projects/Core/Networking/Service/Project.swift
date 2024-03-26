import Foundation
import ProjectDescription
import ProjectTemplatePlugin
import DependencyPlugin


let project = Project.makeAppModule(
    name: "Service",
    bundleId: .appBundleID(name: "Service"),
    product: .staticFramework,
    settings: .appBaseSetting(appName: "Service"),
    dependencies: [
        .Networking(implements: .ThirdPartys),
        .Networking(implements: .API),
        .sdk(name: "OSLog", type: .framework)
    ],
    sources: ["Sources/**"]
)
