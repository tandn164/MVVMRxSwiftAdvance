//
//  TopCollectionViewDataSource.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 03/08/2023.
//

import UIKit

class TopCollectionDataSource: ArrayDataSource<PhotoViewEntity>, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(PhotoCollectionViewCell.self, forIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.imageView.setImage(withPath: data.value[indexPath.row].url)
        return cell
    }
}
