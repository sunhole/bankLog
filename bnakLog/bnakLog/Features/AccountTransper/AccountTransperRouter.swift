//
//  AccountTransperRouter.swift
//  bnakLog
//
//  Created by vision on 10/16/25.
//

import UIKit

final class AccountTransperRouter: Router<AccountTransperInteractable>, AccountTransperRouting {
    private let viewController: AccountTransperViewController
    
    init(interactor: AccountTransperInteractable, viewController: AccountTransperViewController) {
        self.viewController = viewController
        super.init(interactor: interactor)
    }
    
    var viewControllable: Viewable {
        return viewController
    }
}
