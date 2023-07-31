// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length
// MARK: - Strings

internal enum Localizable {
  /// エラー
  internal static let error = Localizable.tr("Localizable", "Error")
  /// -
  internal static let hyphenCharacter = Localizable.tr("Localizable", "hyphenCharacter")
  /// 
  internal static let noCharacterString = Localizable.tr("Localizable", "noCharacterString")
  /// オッケ
  internal static let ok = Localizable.tr("Localizable", "OK")
  /// 設定
  internal static let tabSetting = Localizable.tr("Localizable", "tabSetting")
  /// トップ
  internal static let tabTop = Localizable.tr("Localizable", "tabTop")
}

// MARK: - Implementation Details

extension Localizable {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle.main, comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}


