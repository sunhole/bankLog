//
//  RootRIB.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

// Builder가 생성되기 위해 필요한 외부 의존성을 정의합니다.
// Root는 최상위 RIB이므로 외부 의존성이 없습니다. 따라서 비워둡니다.
protocol RootDependency {
    var homeBuilder: HomeBuildable { get }
}

// Builder가 지켜야 할 약속입니다.
// RootBuilder는 파라미터 없이 RootRouting을 생성할 수 있어야 합니다.
protocol RootBuildable: AnyObject {
    func build() -> RootRouting
}

// Interactor가 Router에게 요청하는 내비게이션 동작을 정의합니다.
protocol RootRouting: ViewableRouting {
    func routeToHome()
}

// Interactor가 부모 Interactor와 소통하기 위한 프로토콜입니다.
// Root는 최상위이므로 부모가 없어, 내용은 비어있습니다.
protocol RootListener: AnyObject {}

// Interactor가 지켜야 할 약속입니다.
// 자식인 TransactionList의 Listener 역할을 수행합니다.
protocol RootInteractable: Interactable, HomeListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}
