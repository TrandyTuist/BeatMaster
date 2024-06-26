import Foundation
import ProjectDescription
import ProjectTemplatePlugin
import DependencyPlugin


let project = Project.makeAppModule(
    name: "Networkings",
    bundleId: .appBundleID(name: ".Networkings"),
    product: .staticFramework,
    settings: .appBaseSetting(appName: "Networkings"),
    dependencies: [
        .Networking(implements: .Model),
        .Networking(implements: .Service),
        .Networking(implements: .DiContainer),
        .Networking(implements: .UseCase)
    ],
    sources: ["Sources/**"]
)
