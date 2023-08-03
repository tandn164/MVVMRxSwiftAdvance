//
//  PhotoCollectionViewCell.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 22/04/2023.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isSkeletonable = true
    }
    
    static func skeleton(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(PhotoCollectionViewCell.self, forIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.imageView.showAnimatedGradientSkeleton()
        return cell
      }

    static func configure(collectionView: UICollectionView, indexPath: IndexPath, photo: PhotoDataEntity) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(PhotoCollectionViewCell.self, forIndexPath: indexPath) else {
            return UICollectionViewCell()
        }
        cell.imageView.setImage(withPath: photo.url)
        cell.imageView.hideSkeleton()
        return cell
    }
}
