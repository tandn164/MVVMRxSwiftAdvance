// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// MARK: - Strings

internal enum LaunchScreen {
}

// MARK: - Implementation Details

extension LaunchScreen {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle.main, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}


