import Foundation
import ProjectDescription
import ProjectTemplatePlugin


let project = Project.makeAppModule(
    name: "Metronome",
    bundleId: .appBundleID(name: ".Metronome"),
    product: .staticFramework,
    settings: .appBaseSetting(appName: "Metronome"),
    dependencies: [
        
    ],
    sources: ["Sources/**"]
)
