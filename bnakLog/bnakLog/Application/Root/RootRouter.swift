//
//  RootRouter.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

final class RootRouter: Router<RootInteractable>, RootRouting {
    
    private let viewController: RootViewController
    private let transactionListBuilder: TransactionListBuildable
    
    private var transactionListRouter: Routing?

    init(
        interactor: RootInteractable,
        viewController: RootViewController,
        transactionListBuilder: TransactionListBuildable
    ) {
        self.viewController = viewController
        self.transactionListBuilder = transactionListBuilder
        // 부모 클래스의 생성자를 호출합니다.
        super.init(interactor: interactor)
    }
    
    var viewControllable: Viewable {
        return viewController
    }

    func routeToTransactionList() {
        guard transactionListRouter == nil else { return }
        
        let router = transactionListBuilder.build(withListener: interactor)
        self.transactionListRouter = router
        attach(child: router)
        
        viewController.attachChild(viewControllable: router.viewControllable)
    }
}
