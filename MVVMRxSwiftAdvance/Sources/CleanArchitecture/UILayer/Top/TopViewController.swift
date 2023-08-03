//
//  TopViewController.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 10/07/2023.
//

import UIKit
import RxSwift
import RxCocoa

class TopViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    
    private var viewModel: TopViewModel!
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DIContainer.shared.resolve(TopViewModel.self)
        setupCollectionView()
        
        bindViewModel()
        viewModel.getPhotos()
    }
    
    private func bindViewModel() {
        viewModel.photos.drive {[unowned self] _ in
            self.collectionView.reloadData()
        }.disposed(by: disposeBag)
        
        viewModel.isFetching.drive { [unowned self] loading in
            if loading {
//                LoadingHud.show()
                self.collectionView.showSkeletonView()
            } else {
//                LoadingHud.hide()
                self.collectionView.hideSkeletonView()
            }
        }.disposed(by: disposeBag)
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = true
        
        collectionView.delegate = self
        collectionView.dataSource = viewModel.dataSource
        
        let layout = BouncyLayout()
        collectionView.collectionViewLayout = layout
        
        collectionView.registerCellByNib(PhotoCollectionViewCell.self)
    }
}

extension TopViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 15)/2, height: 120)
    }
}
