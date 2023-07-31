//
//  TopViewModel.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 28/07/2023.
//

import Foundation
import RxSwift

final class TopViewModel {
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    public let photos: PublishSubject<[PhotoDataEntity]> = .init()
    
    private final let photoUseCase: PhotoUseCase
    
    init(photoUseCase: PhotoUseCase) {
        self.photoUseCase = photoUseCase
    }
    
    func getPhotos() {
        photoUseCase.getPhotos()
            .subscribe(onNext: {
                self.photos.onNext($0)
            }, onError: {
                print($0.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
}
