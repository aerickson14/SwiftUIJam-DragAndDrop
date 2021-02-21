import Foundation
import os

struct Logger {

    static func log(_ message: String, type: OSLogType = .debug) {
        os_log("%@", log: .default, type: type, message)
    }

    static func error(_ message: String) {
        log("❌ ERROR: \(message)", type: .error)
    }

    static func warn(_ message: String) {
        log("⚠️ WARN: \(message)", type: .error)
    }
}
