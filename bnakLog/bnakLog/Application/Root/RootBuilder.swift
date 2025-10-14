//
//  RootBuilder.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

final class RootBuilder: RootBuildable {
    func build() -> any RootRouting {
        let viewController = RootViewController()
        let interactor = RootInteractor()
        let router = RootRouter(interactor: interactor, viewController: viewController)
        
        interactor.router = router
        
        return router
    }
}
