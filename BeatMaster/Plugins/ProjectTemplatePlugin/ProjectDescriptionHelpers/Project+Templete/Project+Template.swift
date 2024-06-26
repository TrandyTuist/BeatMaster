//
//  Project+Template.swift
//  MyPlugin
//
//  Created by 서원지 on 1/6/24.
//

import ProjectDescription

public extension Project {
    static func makeAppModule(
        name: String = Environment.appName,
        bundleId: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = Environment.organizationName,
        packages: [Package] = [],
        deploymentTarget: DeploymentTargets = Environment.deploymentTarget,
        destinations: Destinations = Environment.deploymentDestination,
        settings: Settings,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = .sources,
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default,
        entitlements: Entitlements? = nil,
        schemes: [Scheme] = []
    ) -> Project {
        let appTarget = Target(
            name: name,
            destinations: destinations,
            product: product,
            bundleId: bundleId,
            deploymentTargets: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies
        )
        
        let appDevTarget = Target(
            name: "\(name)-QA",
            destinations: destinations,
            product: product,
            bundleId: "\(bundleId)",
            deploymentTargets: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources,
            resources: resources,
            entitlements: entitlements,
            scripts: scripts,
            dependencies: dependencies
        )
        
        let appTestTarget = Target(
            name: "\(name)Tests",
            destinations: destinations,
            product: .unitTests,
            bundleId: "\(bundleId).\(name)Tests",
            deploymentTargets: deploymentTarget,
            infoPlist: .default,
            sources: ["\(name)Tests/Sources/**"],
            dependencies: [.target(name: name)]
        )
        
        let targets = [appTarget, appDevTarget, appTestTarget]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: schemes
        )
    }
}


extension Scheme {
    public static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Tests"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
    
}
