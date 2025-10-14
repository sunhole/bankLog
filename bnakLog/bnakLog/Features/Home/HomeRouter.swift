//
//  HomeRouter.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

final class HomeRouter: Router<HomeInteractable>, HomeRouting {
    
    private let viewController: HomeViewControllable
    private let transactionListBuilder: TransactionListBuildable
    
    private var transactionListRouter: Routing?

    init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable,
        transactionListBuilder: TransactionListBuildable
    ) {
        self.viewController = viewController
        self.transactionListBuilder = transactionListBuilder
        super.init(interactor: interactor)
    }
    
    var viewControllable: Viewable {
        return viewController
    }
    
    // HomeRouting 프로토콜의 요구사항을 구현합니다.
    func routeToTransactionHistory() {
        // 이미 라우터가 있다면 중복 생성을 방지합니다.
        guard transactionListRouter == nil else { return }
        
        // 1. Builder를 사용해 자식 RIB을 만듭니다.
        let router = transactionListBuilder.build(withListener: interactor)
        self.transactionListRouter = router
        
        // 2. 자식 RIB을 attach 합니다.
        attach(child: router)
        
        // 3. ViewController에게 화면을 push 하라고 명령합니다.
        viewController.push(viewControllable: router.viewControllable)
    }
    
    func routeToTransectionTransfer() {
        //계좌이체 뷰로 이동 필요 
    }
    
    func detachTransactionHistory() {
        guard let router = transactionListRouter else { return }
        detach(child: router)
        transactionListRouter = nil
    }
}
