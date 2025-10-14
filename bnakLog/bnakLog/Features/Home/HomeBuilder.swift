//
//  HomeBuilder.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit
import RIBs

final class HomeBuilder: HomeBuildable {
    private let dependency: HomeDependency
    
    init(dependency: HomeDependency) {
        self.dependency = dependency
    }
    
    func build(withListener listener: any HomeListener) -> any HomeRouting {
        let viewController = HomeViewController()
        let interactor = HomeInteractor()
        
        interactor.listener = listener
        viewController.listener = interactor
        
        let router = HomeRouter(
            interactor: interactor,
            viewController: viewController,
            transactionListBuilder: dependency.transactionListBuilder
        )
        
        interactor.router = router
        
        return router
    }
}
