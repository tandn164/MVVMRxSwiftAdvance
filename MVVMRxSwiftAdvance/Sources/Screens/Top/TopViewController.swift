//
//  TopViewController.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 10/07/2023.
//

import UIKit
import RxSwift

class TopViewController: UIViewController {

    private final let disposeBag: DisposeBag = DisposeBag()
    var viewModel: TopViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DIContainer.shared.resolve(TopViewModel.self)
        bindingViewModel()
        viewModel.getPhotos()
    }
    
    private func bindingViewModel() {
        viewModel.photos.asDriverOnErrorJustComplete().drive(onNext: {
            print("Photos length: ", $0.count)
        }).disposed(by: disposeBag)
    }
}
