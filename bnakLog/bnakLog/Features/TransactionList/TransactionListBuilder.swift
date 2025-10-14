//
//  TransactionListBuilder.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

final class TransactionListBuilder: TransactionListBuildable {
    func build(withListener listener: any TransactionListListener) -> any TransactionListRouting {
        let viewController = TransactionListViewController()
        let interactor = TransactionListInteractor()
        let router = TransactionListRouter(interactor: interactor, viewController: viewController)
        
        interactor.router = router
        interactor.listener = listener
        
        // --- 의존성 주입 ---
        // ViewController가 Interactor의 업데이트를 받을 수 있도록 연결합니다.
        interactor.viewController = viewController
        
        return router
    }

}
