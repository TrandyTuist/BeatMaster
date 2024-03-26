//
//  demoApplication.stencil.swift
//  BeatMaster
//
//  Created by 서원지 on 2024/01/14
//  Copyright © 2024 Team.hae.jo , Ltd. All rights reserved.
//

import SwiftUI
import Splash
import ComposableArchitecture
import Auth
import Root

@main
struct DemoBeatMaster: App {
    var body: some Scene {
        WindowGroup {
            AuthInfromationView(store: Store(
                initialState: AuthInfromationFeature.State(), reducer: {
                    AuthInfromationFeature()
                }), backAction: {})
        }
    }
}
