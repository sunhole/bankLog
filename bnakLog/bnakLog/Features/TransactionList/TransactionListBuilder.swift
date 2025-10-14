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
        
        // Interactor가 부모(HomeRIB)와 통신할 수 있도록 listener를 연결합니다.
        interactor.listener = listener
        // Interactor가 ViewController에게 데이터를 전달할 수 있도록 연결합니다.
        interactor.viewController = viewController
        
        // ✅✅✅ 이 연결 코드가 마지막 핵심이었습니다! ✅✅✅
        // ViewController가 Interactor에게 "뒤로가기" 신호를 보낼 수 있도록 listener를 연결합니다.
        viewController.listener = interactor
        
        let router = TransactionListRouter(
            interactor: interactor,
            viewController: viewController
        )
        
        interactor.router = router
        
        return router
    }
    
}
