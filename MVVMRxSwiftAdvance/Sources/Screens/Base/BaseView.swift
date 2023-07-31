//
//  BaseView.swift
//  MVVMRxSwift
//
//  Created by Nguyễn Đức Tân on 11/05/2023.
//

import Foundation

protocol BaseView {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func viewDidAppear()
    func viewDidDisappear()
}
