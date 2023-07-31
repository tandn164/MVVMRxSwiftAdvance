//
//  PhotoReponsitory.swift
//  RepositoryPattern
//
//  Created by Nguyễn Đức Tân on 28/07/2023.
//

import Foundation
import RxSwift

protocol PhotoRepositoryProtocol {
    func getPhotos() -> Observable<[PhotoDataEntity]>
}

final class PhotoRepositoryImpl: PhotoRepositoryProtocol {
    
    private final let request: Request<PhotoDataEntity>
    
    init(request: Request<PhotoDataEntity>) {
        self.request = request
    }
    
    func getPhotos() -> Observable<[PhotoDataEntity]> {
        request.getItems("list")
    }
}
