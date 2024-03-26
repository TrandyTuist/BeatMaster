import Foundation
import ProjectDescription
import ProjectTemplatePlugin
import DependencyPlugin


let project = Project.makeAppModule(
    name: "API",
    bundleId: .appBundleID(name: ".API"),
    product: .staticFramework,
    settings:  .settings(),
    dependencies: [
        
    ],
    sources: ["Sources/**"]
)
