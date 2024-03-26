//
//  Project.swift
//  Manifests
//
//  Created by 서원지 on 1/6/24.
//

import ProjectDescription
import DependencyPlugin
import ProjectTemplatePlugin

// Local plugin loaded

let project = Project.makeAppModule(
    name: Project.Environment.appName,
    bundleId: .mainBundleID(),
    product: .app,
    settings: .appMainSetting,
    dependencies: [
        .Core(implements: .Core),
        .Shared(implements: .Shareds),
        .Networking(implements: .Networkings),
        
    ],
    sources: ["Sources/**", "Resources/FontAsset/**"],
    resources: ["Resources/**", "../Support/AuthKey_P552TDR3Q2.p8", "../Support/PrivacyInfo.xcprivacy"],
    infoPlist: .file(path: "../Support/Info.plist"),
    entitlements: .file(path: "../Entitlements/BeatMaster.entitlements")
    
)

