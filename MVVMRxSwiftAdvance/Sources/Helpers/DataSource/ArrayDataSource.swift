//
//  ArrayDataSource.swift
//  MVVMRxSwiftAdvance
//
//  Created by Nguyễn Đức Tân on 03/08/2023.
//

import Foundation
import RxCocoa

class ArrayDataSource<T> : NSObject {
    var data = BehaviorRelay<[T]>(value: [])
}
