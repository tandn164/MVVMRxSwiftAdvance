//
//  NumberUtil.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 24/04/2023.
//

import Foundation
import UIKit

struct NumberTypealias: NumberConvertible, Comparable {
    private(set) var text: String = Localizable.hyphenCharacter
    private(set) var value: NSDecimalNumber = NSDecimalNumber.notANumber
    
    var asNumber: NSDecimalNumber {
        return value
    }
    
    static func < (lhs: NumberTypealias, rhs: NumberTypealias) -> Bool {
        return lhs.value < rhs.value
    }
    
    static func <= (lhs: NumberTypealias, rhs: NumberTypealias) -> Bool {
        return lhs.value <= rhs.value
    }
    
    static func == (lhs: NumberTypealias, rhs: NumberTypealias) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func > (lhs: NumberTypealias, rhs: NumberTypealias) -> Bool {
        return lhs.value > rhs.value
    }
    
    static func >= (lhs: NumberTypealias, rhs: NumberTypealias) -> Bool {
        return lhs.value >= rhs.value
    }
    
    var removeGroupingSeparator: String {
        if let separator = FormatterNumberType.defaultLocale.groupingSeparator {
            return text.replacingOccurrences(of: separator, with: "")
        }
        return text
    }
}

enum FormatterNumberType {
    case cash
    case percent
    case option(roundingMode: NumberFormatter.RoundingMode?, maxFraction: Int?, minFraction: Int?)
    case none
    case percentSimple
    
    static let defaultLocale = Locale.init(identifier: "en_US")
    
    var formatter: NumberFormatter {
        switch self {
        case .cash:
            return cashFormatter
        case .percent:
            return percentFormatter
        case .none:
            return defaultFormatter
        case .option(let roundingMode, let maxFraction, let minFraction):
            return optionFormatter(roundingMode, maxFraction, minFraction)
        case .percentSimple:
            return percentSimpleFormatter
        }
    }
    
    var cashFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.locale = FormatterNumberType.defaultLocale
        formatter.roundingMode = .down
        return formatter
    }
    
    var percentFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .down
        formatter.locale = FormatterNumberType.defaultLocale
        return formatter
    }
    
    var defaultFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.locale = FormatterNumberType.defaultLocale
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = Constant.maximumFractionDigits
        return formatter
    }
    
    private func optionFormatter(_ roundingMode: NumberFormatter.RoundingMode?, _ maxFraction: Int?,_ minFraction: Int?) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .decimal
        if let maxFraction = maxFraction {
            formatter.maximumFractionDigits = maxFraction
        } else {
            formatter.maximumFractionDigits = Constant.maximumFractionDigits
        }        
        if let minFraction = minFraction {
            formatter.minimumFractionDigits = minFraction
        }
        if let roundingMode = roundingMode {
            formatter.roundingMode = roundingMode
        }
        formatter.locale = FormatterNumberType.defaultLocale
        return formatter
    }
    
    var percentSimpleFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.roundingMode = .down
        formatter.locale = FormatterNumberType.defaultLocale
        return formatter
    }
}

enum DefaultResultType {
    case zero           // "0", NSDecimalNumber.zero
    case undefined      // "-", NSDecimalNumber.notANumber
    case zeroUndefined  // "-", NSDecimalNumber.zero
    case noCharacter    // "", NSDecimalNumber.notANumber
    
    var defaultValue: NumberTypealias {
        switch self {
        case .zero:
            return NumberUtil.zero
        case .undefined:
            return NumberUtil.defaultNumberValue
        case .zeroUndefined:
            return NumberUtil.zeroUndefined
        case .noCharacter:
            return NumberUtil.noCharacter
        }
    }
}

class NumberUtil {
    static let defaultNumberValue = NumberTypealias()
    static let zero = NumberTypealias(text: NSDecimalNumber.zero.stringValue, value: NSDecimalNumber.zero)
    static let one = NumberTypealias(text: NSDecimalNumber.one.stringValue, value: NSDecimalNumber.one)
    static let zeroUndefined = NumberTypealias(text: Localizable.hyphenCharacter, value: NSDecimalNumber.zero)
    static let noCharacter = NumberTypealias(text: Localizable.noCharacterString, value: NSDecimalNumber.notANumber)
    
    //MARK: - formatterNumber
    /// formatterNumber util
    ///
    /// - Parameters:
    ///   - number: value
    ///   - formatterType: format text
    ///   - resultType: default result if input is nil or NotANumber
    ///   - roundMode: round value
    /// - Returns: text to display and value to calculator
    static func formatterNumber(_ number: NumberConvertible?, formatterType: FormatterNumberType = .none, resultType: DefaultResultType = .undefined, roundMode: NSDecimalNumber.RoundingMode = .plain, scale: Int? = nil) -> NumberTypealias {
        if let number = number, number.asNumber != NSDecimalNumber.notANumber {
            let handler = NSDecimalNumberHandler.init(roundingMode: roundMode, scale: Int16(scale ?? Constant.maximumFractionDigits), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
            let round = number.asNumber.rounding(accordingToBehavior: handler)
            
            if let text = formatterType.formatter.string(from: round) {
                return NumberTypealias(text: text, value: round.asNumber)
            }
        }
        return resultType.defaultValue
    }

    //MARK: - add +
    /// numberutil add func
    ///
    /// - Parameters:
    ///   - number1: value1
    ///   - number2: value2
    ///   - formatterType: format text
    ///   - resultType: default result if input is nil or NotANumber
    ///   - roundMode: round value
    /// - Returns: text to display and value to calculator
    static func add(_ number1: NumberConvertible?,_ number2: NumberConvertible?, formatterType: FormatterNumberType = .none, resultType: DefaultResultType = .undefined, roundMode: NSDecimalNumber.RoundingMode = .plain, scale: Int? = nil) -> NumberTypealias {
        if let number1 = number1, let number2 = number2 {
            let handler = NSDecimalNumberHandler.init(roundingMode: roundMode, scale: Int16(scale ?? Constant.maximumFractionDigits), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
            let result = number1.asNumber.adding(number2.asNumber, withBehavior: handler)
            return formatterNumber(result, formatterType: formatterType, resultType: resultType, roundMode: roundMode, scale: scale)
        } else {
            return resultType.defaultValue
        }
    }
    
    //MARK: - sub --
    /// numberutil sub func
    ///
    /// - Parameters:
    ///   - number1: value1
    ///   - number2: value2
    ///   - formatterType: format text
    ///   - resultType: default result if input is nil or NotANumber
    ///   - roundMode: round value
    /// - Returns: text to display and value to calculator
    static func sub(_ number1: NumberConvertible?,_ number2: NumberConvertible?, formatterType: FormatterNumberType = .none, resultType: DefaultResultType = .undefined, roundMode: NSDecimalNumber.RoundingMode = .plain, scale: Int? = nil) -> NumberTypealias {
        if let number1 = number1, let number2 = number2 {
            let handler = NSDecimalNumberHandler.init(roundingMode: roundMode, scale: Int16(scale ?? Constant.maximumFractionDigits), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
            let result = number1.asNumber.subtracting(number2.asNumber, withBehavior: handler)
            return formatterNumber(result, formatterType: formatterType, resultType: resultType, roundMode: roundMode, scale: scale)
        } else {
            return resultType.defaultValue
        }
    }
    
    //MARK: - multiple *
    /// numberutil multiple func
    ///
    /// - Parameters:
    ///   - number1: value1
    ///   - number2: value2
    ///   - formatterType: format text
    ///   - resultType: default result if input is nil or NotANumber
    ///   - roundMode: round value
    /// - Returns: text to display and value to calculator
    static func multiple(_ number1: NumberConvertible?,_ number2: NumberConvertible?, formatterType: FormatterNumberType = .none, resultType: DefaultResultType = .undefined, roundMode: NSDecimalNumber.RoundingMode = .plain, scale: Int? = nil) -> NumberTypealias {
        if let number1 = number1, let number2 = number2 {
            let handler = NSDecimalNumberHandler.init(roundingMode: roundMode, scale: Int16(scale ?? Constant.maximumFractionDigits), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
            let result = number1.asNumber.multiplying(by: number2.asNumber, withBehavior: handler)
            return formatterNumber(result, formatterType: formatterType, resultType: resultType, roundMode: roundMode, scale: scale)
        } else {
            return resultType.defaultValue
        }
    }
    
    //MARK: - divide /
    /// numberutil divide func
    ///
    /// - Parameters:
    ///   - number1: value1
    ///   - number2: value2
    ///   - formatterType: format text
    ///   - resultType: default result if input is nil or NotANumber
    ///   - roundMode: round value
    /// - Returns: text to display and value to calculator
    static func divide(_ number1: NumberConvertible?,_ number2: NumberConvertible?, formatterType: FormatterNumberType = .none, resultType: DefaultResultType = .undefined, roundMode: NSDecimalNumber.RoundingMode = .plain, scale: Int? = nil) -> NumberTypealias {
        if let number1 = number1, let number2 = number2 {
            let handler = NSDecimalNumberHandler.init(roundingMode: roundMode, scale: Int16(scale ?? Constant.maximumFractionDigits), raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
            let result = number1.asNumber.dividing(by: number2.asNumber, withBehavior: handler)
            return formatterNumber(result, formatterType: formatterType, resultType: resultType, roundMode: roundMode, scale: scale)
        } else {
            return resultType.defaultValue
        }
    }

    static func min(_ number1: NumberConvertible?,_ number2: NumberConvertible?, formatterType: FormatterNumberType = .none, resultType: DefaultResultType = .undefined) -> NumberTypealias {
        if let number1 = number1, let number2 = number2 {
            if number1.asNumber == NSDecimalNumber.notANumber && number2.asNumber == NSDecimalNumber.notANumber {
                return resultType.defaultValue
            } else {
                return number1.asNumber > number2.asNumber ? formatterNumber(number2) : formatterNumber(number1)
            }
        } else {
            return resultType.defaultValue
        }
    }

    static func max(_ number1: NumberConvertible?,_ number2: NumberConvertible?, formatterType: FormatterNumberType = .none, resultType: DefaultResultType = .undefined) -> NumberTypealias {
        if let number1 = number1, let number2 = number2 {
            if number1.asNumber == NSDecimalNumber.notANumber && number2.asNumber == NSDecimalNumber.notANumber {
                return resultType.defaultValue
            } else {
                return number1.asNumber < number2.asNumber ? formatterNumber(number2) : formatterNumber(number1)
            }            
        } else {
            return resultType.defaultValue
        }
    }
}

protocol NumberConvertible {
    var asNumber: NSDecimalNumber { get }
}

extension String: NumberConvertible {
    var asNumber: NSDecimalNumber {
        return NSDecimalNumber.init(string: self)
    }
}

extension Double: NumberConvertible {
    var asNumber: NSDecimalNumber {
        return NSDecimalNumber.init(value: self)
    }
}

extension Float: NumberConvertible {
    var asNumber: NSDecimalNumber {
        return NSDecimalNumber.init(value: self)
    }
}

extension NSDecimalNumber: NumberConvertible, Comparable {
    public static func < (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedAscending
    }
    
    public static func <= (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedAscending || lhs.compare(rhs) == .orderedSame
    }
    
    public static func == (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedSame
    }
    
    public static func > (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedDescending
    }
    
    public static func >= (lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedDescending || lhs.compare(rhs) == .orderedSame
    }
    
    var asNumber: NSDecimalNumber {
        return self
    }
    
    var isDecimal: Bool {
        let handler = NSDecimalNumberHandler.init(roundingMode: .down, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        let roundDown = self.rounding(accordingToBehavior: handler)
        if self.compare(roundDown) == .orderedSame {
            return false
        }
        return true
    }
    
    var fractionalDecimalDigits: Int {
        return max(-self.decimalValue.exponent, 0)
    }
    
    var intergerDigits: Int {
        if let separator = FormatterNumberType.defaultLocale.decimalSeparator {
            return self.stringValue.components(separatedBy: separator).first?.count ?? 1
        }
        return 1
    }
    
    func round(_ decimals: Int) -> NSDecimalNumber {
        return self.rounding(accordingToBehavior: NSDecimalNumberHandler(roundingMode: self < 0 ? .up : .down,
                                                                         scale: Int16(decimals),
                                                                         raiseOnExactness: false,
                                                                         raiseOnOverflow: false,
                                                                         raiseOnUnderflow: false,
                                                                         raiseOnDivideByZero: false))
    }
    
    func roundUp(_ decimals: Int) -> NSDecimalNumber {
        return self.rounding(accordingToBehavior: NSDecimalNumberHandler(roundingMode: self < 0 ? .down : .up,
                                                                         scale: Int16(decimals),
                                                                         raiseOnExactness: false,
                                                                         raiseOnOverflow: false,
                                                                         raiseOnUnderflow: false,
                                                                         raiseOnDivideByZero: false))
    }
}

extension Int: NumberConvertible {
    var asNumber: NSDecimalNumber {
        return NSDecimalNumber.init(value: self)
    }    
}

extension Decimal: NumberConvertible {
    var asNumber: NSDecimalNumber {
        return NSDecimalNumber.init(decimal: self)
    }
}
