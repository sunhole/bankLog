//
//  AccountTransperBuilder.swift
//  bnakLog
//
//  Created by vision on 10/16/25.
//

import UIKit

final class AccountTransperBuilder: AccountTransperBuildable {
    func build(withListener listener: any AccountTransperListener) -> any AccountTransperRouting {
        let viewController = AccountTransperViewController()
        let interactor = AccountTransperInteractor()
        interactor.listener = listener
        interactor.viewController = viewController
        
        viewController.listener = interactor
        
        let router = AccountTransperRouter(
            interactor: interactor,
            viewController: viewController
        )
        
        interactor.router = router
        
        return router
    }
    
}
