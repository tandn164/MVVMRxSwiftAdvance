//
//  AppConfig.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 14/08/2023.
//

import Foundation

struct AppConfig {
    public static var baseUrl: String {
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "base_url") as? String else {
            fatalError()
        }
        return baseUrl
    }
}
