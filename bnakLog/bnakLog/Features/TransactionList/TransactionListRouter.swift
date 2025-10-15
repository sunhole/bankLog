//
//  TransactionListRouter.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

final class TransactionListRouter: Router<TransactionListInteractable>, TransactionListRouting {
    
    private let viewController: TransactionListViewController
    
    init(interactor: TransactionListInteractable, viewController: TransactionListViewController) {
        self.viewController = viewController
        // 부모 클래스의 생성자를 호출합니다.
        super.init(interactor: interactor)
    }
    
    var viewControllable: Viewable {
        return viewController
    }
}

