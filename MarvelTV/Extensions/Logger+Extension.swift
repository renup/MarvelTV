//
//  Logger+Extension.swift
//  MarvelTV
//
//  Created by Renu Punjabi on 5/23/24.
//

import Foundation
import OSLog

public extension Logger {
    init(subsystem: String, category: String, forDebugBuild: Bool = false) {
#if DEBUG
        self.init(subsystem: subsystem, category: category)
#else
        if forDebugBuild {
            self.init(OSLog.disabled)
        } else {
            self.init(subsystem: subsystem, category: category)
        }
#endif
    }
}
