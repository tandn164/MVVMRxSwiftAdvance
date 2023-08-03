//
//  PhotoUseCase.swift
//  RepositoryPattern
//
//  Created by Nguyễn Đức Tân on 28/07/2023.
//

import Foundation
import RxSwift

final class PhotoUseCase {
    private final let photoRepo: PhotoRepositoryProtocol
    
    init(photoRepo: PhotoRepositoryProtocol) {
        self.photoRepo = photoRepo
    }
    
    func getPhotos() -> Observable<[PhotoViewEntity]> {
        photoRepo.getPhotos().map { dataEntities in
            return dataEntities.map({PhotoViewEntity(url: $0.downloadURL)})
        }
    }
}
