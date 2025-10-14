//
//  RootBuilder.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

// RootRIB이 필요로 하는 의존성(RootDependency)을 실제로 구현한 클래스입니다.
// 이 클래스가 TransactionListBuilder를 생성하여 공급합니다.
final class AppComponent: RootDependency {
    lazy var transactionListBuilder: TransactionListBuildable = TransactionListBuilder()
}

final class RootBuilder: RootBuildable {

    // RootRIB을 구성하는 모든 컴포넌트를 생성하고 조립하여 반환합니다.
    // Root는 최상위 RIB이므로 Listener가 필요 없습니다.
    func build() -> RootRouting {
        // 1. 의존성 컴포넌트를 생성합니다.
        let dependency = AppComponent()
        let viewController = RootViewController()
        
        // 2. Interactor를 생성합니다.
        let interactor = RootInteractor(dependency: dependency)
        
        // 3. Router를 생성하고, 필요한 모든 부품을 주입합니다.
        let router = RootRouter(
            interactor: interactor,
            viewController: viewController,
            transactionListBuilder: dependency.transactionListBuilder
        )
        
        // 4. Interactor와 Router를 연결합니다.
        interactor.router = router
        
        return router
    }
}
