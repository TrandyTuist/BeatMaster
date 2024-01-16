//
//  AppDIContainer.swift
//  BeatMaster
//
//  Created by 서원지 on 1/16/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import Swinject
import DiContainer

public final class AppDIContainer {
    public static let shared: AppDIContainer = .init()
    
    private let diContainer: Container = DIContainer.container
    
    private init() {}

    public func registerDependencies() {
        registerRepositories()
        registerUseCases()
    }
    
    // MARK: - Use Cases
    private func registerUseCases() {
        
        
    }
    
    
    
    // MARK: - Repositories  등록
    private func registerRepositories() {
        
        
    }
}
