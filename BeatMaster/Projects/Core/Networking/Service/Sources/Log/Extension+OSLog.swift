//
//  Extension+OSLog.swift
//  Service
//
//  Created by 서원지 on 3/19/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import Foundation
import OSLog

extension OSLog {
    static let subsystem = Bundle.main.bundleIdentifier!
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let debug = OSLog(subsystem: subsystem, category: "Debug")
    static let info = OSLog(subsystem: subsystem, category: "Info")
    static let error = OSLog(subsystem: subsystem, category: "Error")
}

