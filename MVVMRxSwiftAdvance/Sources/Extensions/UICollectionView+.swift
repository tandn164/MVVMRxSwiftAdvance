//
//  UICollectionView+.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 22/04/2023.
//

import UIKit

extension UICollectionViewCell {
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    class var identifier: String {
        return String(describing: self)
    }
    
    class func dequeueCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> Self? {
        return collectionView.dequeueCell(self, forIndexPath: indexPath)
    }
    
}

extension UICollectionView {
    
    func registerCellByNib<T: UICollectionViewCell>(_ type: T.Type) {
        register(type.nib, forCellWithReuseIdentifier: type.identifier)
    }
    
    func registerCell<T: UICollectionViewCell>(_ type: T.Type) {
        register(type, forCellWithReuseIdentifier: type.identifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }

}
