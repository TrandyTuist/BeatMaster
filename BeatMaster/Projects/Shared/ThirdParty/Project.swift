import Foundation
import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: "ThirdParty",
    bundleId: .appBundleID(name: ".ThirdParty"),
    product: .staticFramework,
    settings:  .settings(),
    dependencies: [
        .SPM.ComposableArchitecture,
        .SPM.Swinject,
        .SPM.NeedleFoundation
        
        
    ],
    sources: ["Sources/**"]
)