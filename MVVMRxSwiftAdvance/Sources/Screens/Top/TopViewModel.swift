//
//  TopViewModel.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 28/07/2023.
//

import Foundation
import RxSwift
import RxCocoa

class TopViewModel {
    private let _photos = BehaviorRelay<[PhotoDataEntity]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    private let disposeBag: DisposeBag = DisposeBag()
        
    private final let photoUseCase: PhotoUseCase
    
    init(photoUseCase: PhotoUseCase) {
        self.photoUseCase = photoUseCase
    }
    
    func getPhotos() {
        photoUseCase.getPhotos()
            .subscribe(onNext: { [weak self] response in
                self?._isFetching.accept(false)
                self?._photos.accept(response)
            }, onError: { [weak self] error in
                self?._isFetching.accept(false)
                self?._error.accept(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
}

extension TopViewModel {
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var photos: Driver<[PhotoDataEntity]> {
        return _photos.asDriver()
    }
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    var numberOfImages: Int {
        return _photos.value.count
    }
    
    func photo(_ index: Int) -> PhotoDataEntity {
        return _photos.value[index]
    }
}
