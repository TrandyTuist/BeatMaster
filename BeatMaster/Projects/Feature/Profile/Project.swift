import Foundation
import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin


let localHelper = LocalHelper(name: "MyPlugin")

let project = Project.makeAppModule(
    name: "Profile",
    bundleId: .appBundleID(name: ".Profile"),
    product: .staticFramework,
    settings:  .settings(),
    dependencies: [
        .Shared(implements: .Shareds),
        .Networking(implements: .Networkings)
    ],
    sources: ["Sources/**"]
)
