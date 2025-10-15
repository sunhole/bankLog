//
//  AccountTransperRIB.swift
//  bnakLog
//
//  Created by vision on 10/16/25.
//

import UIKit
import RIBs

protocol AccountTransperBuildable: Buildable {
    func build(withListener listener: AccountTransperListener) -> AccountTransperRouting
}

protocol AccountTransperRouting: ViewableRouting {
    
}

protocol AccountTransperListener: AnyObject {
    func accountTransperDidFinish()
    func transferDidFinish(with newTransaction: Transaction)
}

protocol AccountTransperInteractable: Interactable {
    var router: AccountTransperRouting? { get set }
    var listener: AccountTransperListener? { get set }
}
