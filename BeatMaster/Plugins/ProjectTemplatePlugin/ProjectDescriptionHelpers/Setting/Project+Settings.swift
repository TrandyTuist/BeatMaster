//
//  Project+Settings.swift
//  MyPlugin
//
//  Created by 서원지 on 1/6/24.
//

import Foundation
import ProjectDescription

extension Settings {
    public static let appMainSetting: Settings = .settings(
        base: [ "PRODUCT_NAME": "\(Project.Environment.appName)",
                "CFBundleDisplayName" : "\(Project.Environment.appName)",
                "MARKETING_VERSION": .string(.appVersion()),
                "AS_AUTHENTICATION_SERVICES_ENABLED": "YES",
                "PUSH_NOTIFICATIONS_ENABLED":"YES",
                "ENABLE_BACKGROUND_MODES" : "YES",
                "BACKGROUND_MODES" : "remote-notification",
//                "ASSOCIATED_DOMAINS": "applinks:PingPong.page.link",
                "CURRENT_PROJECT_VERSION": .string(.appBuildVersion()),
                "CODE_SIGN_IDENTITY": "iPhone Developer",
//                "CODE_SIGN_STYLE": "Automatic",
                "DEVELOPMENT_TEAM": "\(Project.Environment.organizationTeamId)",
                "VERSIONING_SYSTEM": "apple-generic",
                "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File",
                "DEVELOPMENT_ASSET_PATH" : "\"Resources/Preview Content\""]
        ,configurations: [
            .debug(name: .debug, settings: [
                "PRODUCT_NAME" : "\(Project.Environment.appName)",
                "DISPLAY_NAME" : "\(Project.Environment.appName)",
                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                "OTHER_LDFLAGS": [
                      "-all_load", // Set the strip style to non-global symbols
                ],
                "STRIP_STYLE": [
                    "non-global"
                ],
            ]),
            .debug(name: "Dev", settings: [
                "PRODUCT_NAME" : "\(Project.Environment.appDevName)",
                "DISPLAY_NAME" : "\(Project.Environment.appDevName)",
                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                "OTHER_LDFLAGS": [
                     "-all_load", // Set the strip style to non-global symbols
                ],
                "STRIP_STYLE": [
                    "non-global"
                ],
                
            ]),
            .release(name: .release, settings: [
                "DEVELOPMENT_ASSET_PATHS": "\"Resources/Preview Content\"",
                "PRODUCT_NAME" : "\(Project.Environment.appName)" ,
                "DISPLAY_NAME" : "\(Project.Environment.appName)" ,
                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                "OTHER_LDFLAGS": [
                    "-all_load",
                ],
                "STRIP_STYLE": [
                    "non-global"
                ],
                
            ])], defaultSettings: .recommended)
    
    public static func appBaseSetting(appName: String) -> Settings {
         let appBaseSetting: Settings = .settings(
            base: ["PRODUCT_NAME": "\(appName)",
                   "MARKETING_VERSION": .string(.appVersion()),
                   "CURRENT_PROJECT_VERSION": .string(.appBuildVersion()),
                   "CODE_SIGN_IDENTITY": "iPhone Developer",
                   "AS_AUTHENTICATION_SERVICES_ENABLED": "YES",
//                   "CODE_SIGN_STYLE": "Automatic",
//                   "DEVELOPMENT_TEAM": "\(Project.Environment.organizationTeamId)",
                   "VERSIONING_SYSTEM": "apple-generic",
                   "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File"],
            configurations: [
                .debug(name: .debug, settings: [
                    "PRODUCT_NAME": "\(appName)",
    //                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                    "OTHER_LDFLAGS": [
                          "-all_load", // Set the strip style to non-global symbols
                    ],
                    "STRIP_STYLE": [
                        "non-global"
                    ],
//                    "OTHER_SWIFT_FLAGS": [
//                        "$(inherited)", "-enable-actor-data-race-checks"
//                    ]
                ]),
                .debug(name: "Dev", settings: [
                    "PRODUCT_NAME" : "\(appName)-Dev",
    //                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                    "OTHER_LDFLAGS": [
                         "-all_load", // Set the strip style to non-global symbols
                    ],
                    "STRIP_STYLE": [
                        "non-global"
                    ],
//                    "OTHER_SWIFT_FLAGS": [
//                        "$(inherited)", "-enable-actor-data-race-checks"
//                    ]
                    
                ]),
                .release(name: .release, settings: [
                    "PRODUCT_NAME": "\(appName)",
    //                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                    "OTHER_LDFLAGS": [
                        "-all_load",
                    ],
                    "STRIP_STYLE": [
                        "non-global"
                    ],
//                    "OTHER_SWIFT_FLAGS": [
//                        "$(inherited)", "-enable-actor-data-race-checks"
//                    ]
                ])], defaultSettings: .recommended)
        
        return appBaseSetting
        
    }
    
    public static func appDesignSetting(appName: String) -> Settings {
         let appDesignSetting: Settings = .settings(
            base: ["PRODUCT_NAME": "\(appName)",
                   "MARKETING_VERSION": .string(.appVersion()),
                   "CURRENT_PROJECT_VERSION": .string(.appBuildVersion()),
                   "CODE_SIGN_IDENTITY": "iPhone Developer",
//                   "CODE_SIGN_STYLE": "Automatic",
//                   "DEVELOPMENT_TEAM": "\(Project.Environment.organizationTeamId)",
                   "VERSIONING_SYSTEM": "apple-generic",
                   "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File"],
            configurations: [
                .debug(name: .debug, settings: [
                    "PRODUCT_NAME": "\(appName)",
    //                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                    "OTHER_LDFLAGS": [
                          "-all_load", // Set the strip style to non-global symbols
                    ]
                ]),
                .debug(name: "Dev", settings: [
                    "PRODUCT_NAME" : "\(appName)-Dev",
    //                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                    "OTHER_LDFLAGS": [
                         "-all_load", // Set the strip style to non-global symbols
                    ]
                ]),
                .release(name: .release, settings: [
                    "PRODUCT_NAME": "\(appName)",
    //                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                    "OTHER_LDFLAGS": [
                        "-all_load",
                    ]
                ])], defaultSettings: .recommended)
        
        return appDesignSetting
        
    }
    
    public static func appBaseLibraySetting(appName: String) -> Settings {
         let appBaseLibraySetting: Settings = .settings(
            base: ["PRODUCT_NAME": "\(appName)",
                   "MARKETING_VERSION": .string(.appVersion()),
                   "CURRENT_PROJECT_VERSION": .string(.appBuildVersion()),
                   "CODE_SIGN_IDENTITY": "iPhone Developer",
//                   "CODE_SIGN_STYLE": "Automatic",
//                   "DEVELOPMENT_TEAM": "\(Project.Environment.organizationTeamId)",
                   "VERSIONING_SYSTEM": "apple-generic",
                   "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File"],
            configurations: [
                .debug(name: .debug, settings: [
                    "PRODUCT_NAME": "\(appName)",
    //                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                    "OTHER_LDFLAGS": [
                          "-all_load", // Set the strip style to non-global symbols
                    ],
                    "STRIP_STYLE": [
                        "non-global"
                    ],
                    
                    "OTHER_SWIFT_FLAGS": [
                        "$(inherited)", "-enable-actor-data-race-checks"
                    ]
                    
                ]),
                .debug(name: "Dev", settings: [
                    "PRODUCT_NAME" : "\(appName)-Dev",
    //                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                    "OTHER_LDFLAGS": [
                         "-all_load", // Set the strip style to non-global symbols
                    ],
                    "STRIP_STYLE": [
                        "non-global"
                    ],
                    
                    "OTHER_SWIFT_FLAGS": [
                        "$(inherited)", "-enable-actor-data-race-checks"
                    ]
                    
                ]),
                .release(name: .release, settings: [
                    "PRODUCT_NAME": "\(appName)",
    //                "PROVISIONING_PROFILE_SPECIFIER": "BeatMaster",
                    "OTHER_LDFLAGS": [
                        "-all_load",
                    ],
                    "STRIP_STYLE": [
                        "non-global"
                    ],
                    "OTHER_SWIFT_FLAGS": [
                        "$(inherited)", "-enable-actor-data-race-checks"
                    ]
                ])], defaultSettings: .recommended)
        
        return appBaseLibraySetting
        
    }
    
    public static let appDemoSetting: Settings = .settings(
        base: [ "PRODUCT_NAME": "\(Project.Environment.appDemoName)",
                "CFBundleDisplayName" : "\(Project.Environment.appDemoName)",
                "MARKETING_VERSION": .string(.appVersion()),
                "AS_AUTHENTICATION_SERVICES_ENABLED": "YES",
                "PUSH_NOTIFICATIONS_ENABLED":"YES",
                "ENABLE_BACKGROUND_MODES" : "YES",
                "BACKGROUND_MODES" : "remote-notification",
//                "ASSOCIATED_DOMAINS": "applinks:PingPong.page.link",
                "CURRENT_PROJECT_VERSION": .string(.appBuildVersion()),
                "CODE_SIGN_IDENTITY": "iPhone Developer",
//                "CODE_SIGN_STYLE": "Automatic",
                "DEVELOPMENT_TEAM": "\(Project.Environment.organizationTeamId)",
                "VERSIONING_SYSTEM": "apple-generic",
                "DEBUG_INFORMATION_FORMAT": "DWARF with dSYM File",
                "DEVELOPMENT_ASSET_PATH" : "\"Resources/Preview Content\""]
        ,configurations: [
            .debug(name: .debug, settings: [
                "PRODUCT_NAME" : "\(Project.Environment.appDemoName)",
                "DISPLAY_NAME" : "\(Project.Environment.appDemoName)",
                "PROVISIONING_PROFILE_SPECIFIER": "BeatMasterDemo",
                "OTHER_LDFLAGS": [
                      "-all_load", // Set the strip style to non-global symbols
                ],
                "STRIP_STYLE": [
                    "non-global"
                ],
            ]),
            .debug(name: "Dev", settings: [
                "PRODUCT_NAME" : "\(Project.Environment.appDemoName)",
                "DISPLAY_NAME" : "\(Project.Environment.appDemoName)",
                "PROVISIONING_PROFILE_SPECIFIER": "BeatMasterDemo",
                "OTHER_LDFLAGS": [
                     "-all_load", // Set the strip style to non-global symbols
                ],
                "STRIP_STYLE": [
                    "non-global"
                ],
                
            ]),
            .release(name: .release, settings: [
                "DEVELOPMENT_ASSET_PATHS": "\"Resources/Preview Content\"",
                "PRODUCT_NAME" : "\(Project.Environment.appDemoName)" ,
                "DISPLAY_NAME" : "\(Project.Environment.appDemoName)" ,
                "PROVISIONING_PROFILE_SPECIFIER": "BeatMasterDemo",
                "OTHER_LDFLAGS": [
                    "-all_load",
                ],
                "STRIP_STYLE": [
                    "non-global"
                ],
                
            ])], defaultSettings: .recommended)
    
    
}
