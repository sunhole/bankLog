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
    lazy var homeBuilder: HomeBuildable = HomeBuilder(dependency: self)
}

extension AppComponent: HomeDependency { }

final class RootBuilder: RootBuildable {

    // RootRIB을 구성하는 모든 컴포넌트를 생성하고 조립하여 반환합니다.
    // Root는 최상위 RIB이므로 Listener가 필요 없습니다.
    func build() -> RootRouting {
        // 1. 의존성(부품)을 관리하는 AppComponent를 생성합니다.
        let appComponent = AppComponent()
        
        // 2. Interactor, ViewController를 생성합니다.
        let interactor = RootInteractor()
        let viewController = RootViewController()
        
        // 3. Router를 생성할 때, AppComponent로부터 homeBuilder를 가져와 전달합니다.
        let router = RootRouter(
            interactor: interactor,
            viewController: viewController,
            homeBuilder: appComponent.homeBuilder
        )
        
        interactor.router = router
        
        return router
    }
}
