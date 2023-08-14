//
//  DIContainer.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 28/07/2023.
//

import Swinject

class DIContainer {
    static let shared = DIContainer()
    
    private let container: Container
    
    private init() {
        container = Container()
    }
    
    func resolve<T>(_ serviceType: T.Type) -> T {
        return container.resolve(serviceType)!
    }
    
    func register() {
        container.register(Request.self) { _ in Request<PhotoDataEntity>.init(AppConfig.baseUrl) }
        
        // Repository
        container.register(PhotoRepositoryProtocol.self) { resolver in
            let photoRepo = PhotoRepositoryImpl(request: resolver.resolve(Request<PhotoDataEntity>.self)!)
            return photoRepo
        }
        
        // UseCase
        container.register(PhotoUseCase.self) { resolver in
            PhotoUseCase(photoRepo: resolver.resolve(PhotoRepositoryProtocol.self)!)
        }
        
        // ViewModel
        container.register(TopViewModel.self) { resolver in
            TopViewModel(photoUseCase: resolver.resolve(PhotoUseCase.self)!)
        }
    }
}
