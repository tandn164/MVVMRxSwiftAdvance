//
//  TopViewController.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 10/07/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SkeletonView

class TopViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    
    private var viewModel: TopViewModel!
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewType = .top
        viewModel = DIContainer.shared.resolve(TopViewModel.self)
        setupCollectionView()
        
        view.isSkeletonable = true
        showSkeleton()
        bindViewModel()
        viewModel.getPhotos()
    }
    
    private func bindViewModel() {
        viewModel.photos.drive(onNext: {[unowned self] (_) in
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func setupCollectionView() {
        collectionView.isSkeletonable = true
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = BouncyLayout()
        collectionView.collectionViewLayout = layout
        
        collectionView.registerCellByNib(PhotoCollectionViewCell.self)
    }
    
    private func showSkeleton() {
        collectionView.prepareSkeleton(completion: { done in
            self.view.showAnimatedGradientSkeleton()
        })
    }
    
    private func hideSkeleton() {
        self.view.hideSkeleton()
    }
}

extension TopViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfImages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(PhotoCollectionViewCell.self, forIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.imageView.setImage(withPath: viewModel.photo(indexPath.item).downloadURL)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 15)/2, height: 120)
    }
}
