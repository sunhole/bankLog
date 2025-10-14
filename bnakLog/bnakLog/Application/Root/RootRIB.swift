//
//  RootRIB.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

protocol RootBuildable: Buildable {
    func build() -> RootRouting
}

protocol RootRouting: ViewableRouting {
    //자식 rib 붙히는 메서드 구현 예정
}

protocol RootInteractable: Interactable {
    var router: RootRouting? { get set }
    var listener: RootListener? {get set }
}

protocol RootListener: AnyObject {}
