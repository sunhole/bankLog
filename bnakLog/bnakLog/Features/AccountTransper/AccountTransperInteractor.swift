//
//  AccountTransperInteractor.swift
//  bnakLog
//
//  Created by vision on 10/16/25.
//

import Foundation

final class AccountTransperInteractor: Interactor, AccountTransperInteractable, AccountTransperPresentableListener {
    weak var router: AccountTransperRouting?
    weak var listener: AccountTransperListener?
    weak var viewController: AccountTransperViewController?
    
    func didFinish() {
        listener?.accountTransperDidFinish()
    }
    
}
