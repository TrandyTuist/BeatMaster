//
//  DIContainer.swift
//  BeatMaster
//
//  Created by 서원지 on 2024/01/16
//  Copyright © 2024 Team.hae.jo, All rights reserved.
//

import Foundation
import Service
import OSLog

public final class DependencyContainer {
    private var registry = [String: Any]()
    private var releaseHandlers = [String: () -> Void]()

    public init() { }

    @discardableResult
    public func register<T>(_ type: T.Type, build: @escaping () -> T) async -> () -> Void {
        let key = String(describing: type)
        registry[key] = build
        Log.debug("Registered", key)
        
        // Closure to release memory
        let releaseHandler = { [weak self] in
            self?.registry[key] = nil
            self?.releaseHandlers[key] = nil
            Log.debug("Released", key)
        }
        // Store release handler for later use
        releaseHandlers[key] = releaseHandler
        return releaseHandler
    }

    public func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        if let factory = registry[key] as? () -> T {
            // If factory exists, call the release handler after resolving
            let result = factory()
            if let releaseHandler = releaseHandlers[key] {
                releaseHandler()
            }
            return result
        } else {
            fatalError("No registered dependency found for \(key)")
        }
    }
}

public extension DependencyContainer {
    static let live = DependencyContainer()
}


