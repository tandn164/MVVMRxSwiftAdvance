//
//  Date+.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 24/04/2023.
//

import UIKit

enum DateFormatConstant: String {
    case yyyyMMddWithoutSlash = "yyyyMMdd"
    case yyyyMMddHHmmss = "yyyyMMddhhmmss"
    case dd_MM_yyyy_HH_mm_ss_sss = "dd/MM/yyy HH:mm:ss.SSS"
    case yyyyMMdd_HHmmss = "yyyyMMdd-HHmmss"
    case dd_MM_yyyy = "dd/MM/yyy"
    case yyyyMMdd = "yyyy/MM/dd"
    case yyyy年MM月dd日HHmm = "yyyy年MM月dd日 HH:mm"
    case yyyy年MM月dd日 = "yyyy年MM月dd日"
    case HHmm = "HH:mm"
    case HHmmss = "HH:mm:ss"
    case yyyyMMddHHmmss2 = "yyyy/MM/dd HH:mm:ss"
    case yyyyMMddShow = "yyyy-MM-dd"
    case yyyyMMddHHmmShow = "yyyy-MM-dd HH:mm"
    case yyyyMMddHHmmSS = "yyyy-MM-dd HH:mm:ss"
    case yyyy = "yyyy"
    case hh = "HH"
    case mm = "mm"
    case server = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case yyyy年MM月dd日EEEE = "yyyy年MM月dd日EEEE"
    case history_formatDateTimeFull = "history_formatDateTimeFull"
    case history_formatDate = "history_formatDate"
    case history_formatTime = "history_formatTime"
    case coupon_formatTIme = "coupon_formatTime"
    case yyyyMMddDateOfWeek = "yyyy/MM/dd (EEE)"
    case HH_mm_MM_dd_EE = "HH:mm  MM月dd日(EEE)"
    case MMM_dd_yyyy_EEE = "MMM/dd/yyyy(EEE)"
    case yyyy_MM_dd_HH = "yyyy/MM/dd/HH"
    case HH_mm__yyyy_MM_DD = "HH:mm yyyy/MM/dd"
    case yyyy_MM_dd_T_HH_mm_ssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case yyyy_MM_dd_T_HH_mm_ssSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
    case EEE = "EEE"
    case yyyy_MM_dd_EE_HH_mm_ss = "yyyy/MM/dd(EEE) HH:mm:ss"
    case yyyy_MM_dd_EE_HH_mm = "yyyy/MM/dd(EEE) HH:mm"
    var defaultDateFormatter: DateFormatter {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "en_US")
        dateFormater.timeZone = TimeZone.current
        dateFormater.dateFormat = self.rawValue
        return dateFormater
    }
    
    var jpDateFormatter: DateFormatter {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.timeZone = TimeZone.jpTimeZone
        dateFormater.dateFormat = self.rawValue
        return dateFormater
    }
    
    var severDateFormatter: DateFormatter {
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.timeZone = TimeZone(identifier: "GMT+0000") ?? TimeZone.current
        dateFormater.dateFormat = self.rawValue
        return dateFormater
    }
    
    var multiLanguageDateFormatter: DateFormatter {
        let dateFormater = DateFormatter()
        dateFormater.timeZone = TimeZone.jpTimeZone
        dateFormater.amSymbol = "AM"
        dateFormater.pmSymbol = "PM"
        dateFormater.monthSymbols = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        dateFormater.dateFormat = self.rawValue.localized
        return dateFormater
    }
    
}

extension TimeZone {
    
    static var jpTimeZone: TimeZone {
        return TimeZone(identifier: "Asia/Tokyo") ?? TimeZone.current
    }
}

extension Date {
    static func - (recent: Date, previous: Date) -> (month: Int?, day: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        return (month: month, day: day)
    }
    
}

extension TimeInterval{
    func stringFromTimeInterval() -> String {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d",hours,minutes)
        
    }
}

extension Date {
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return date1.compare(self) == .orderedAscending && date2.compare(self) == .orderedDescending
    }
}
