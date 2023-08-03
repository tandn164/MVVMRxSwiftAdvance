//
//  TopCollectionViewSkeletonDataSource.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 03/08/2023.
//

import UIKit
import SkeletonView

class TopCollectionViewSkeletonDataSource: TopCollectionDataSource, SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return PhotoCollectionViewCell.identifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        guard let cell = skeletonView.dequeueCell(PhotoCollectionViewCell.self, forIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        return cell
    }
}
