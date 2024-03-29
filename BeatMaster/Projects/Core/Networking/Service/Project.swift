import Foundation
import ProjectDescription
import MyPlugin

let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: "Service",
    bundleId: .appBundleID(name: "Service"),
    product: .staticFramework,
    settings:  .settings(),
    dependencies: [
        .Networking(implements: .ThirdPartys)
    ],
    sources: ["Sources/**"]
)
