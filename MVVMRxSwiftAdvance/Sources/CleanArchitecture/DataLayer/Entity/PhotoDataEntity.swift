//
//  PhotoDataEntity.swift
//  RepositoryPattern
//
//  Created by Nguyễn Đức Tân on 28/07/2023.
//

import Foundation

struct PhotoDataEntity: Codable {
    let id, author, url, downloadURL: String?
    let width, height: Int?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
