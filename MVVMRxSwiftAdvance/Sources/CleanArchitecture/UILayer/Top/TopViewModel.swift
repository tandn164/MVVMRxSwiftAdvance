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
    private let _dataSource = TopCollectionViewSkeletonDataSource()
    private let _isFetching = BehaviorRelay<Bool>(value: true)
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
                self?._dataSource.data.accept(response.map({PhotoViewEntity(url: $0.downloadURL)}))
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
    
    var error: Driver<String?> {
        return _error.asDriver()
    }
    
    var hasError: Bool {
        return _error.value != nil
    }
    
    var photos: Driver<[PhotoViewEntity]> {
        return _dataSource.data.asDriver()
    }
    
    var dataSource: TopCollectionViewSkeletonDataSource {
        return _dataSource
    }
}
