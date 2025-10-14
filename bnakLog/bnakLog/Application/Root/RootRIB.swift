//
//  RootRIB.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

// Builder가 생성되기 위해 필요한 외부 의존성을 정의합니다.
// Root는 최상위 RIB이므로 외부 의존성이 없습니다. 따라서 비워둡니다.
protocol RootDependency: AnyObject {}

// Builder가 생성할 컴포넌트들을 정의합니다.
// Root는 자식 RIB을 가지므로, 자식의 Builder를 의존성으로 가집니다.
// 이 의존성은 Builder 내부의 AppComponent에서 생성하여 주입합니다.
protocol RootComponent: AnyObject {
    var transactionListBuilder: TransactionListBuildable { get }
}

// Builder가 지켜야 할 약속입니다.
// RootBuilder는 파라미터 없이 RootRouting을 생성할 수 있어야 합니다.
protocol RootBuildable: AnyObject {
    func build() -> RootRouting
}

// Interactor가 Router에게 요청하는 내비게이션 동작을 정의합니다.
protocol RootRouting: ViewableRouting {
    // RootRouter는 Interactor의 요청에 따라 TransactionList 화면으로 이동해야 합니다.
    func routeToTransactionList()
}

// Interactor가 부모 Interactor와 소통하기 위한 프로토콜입니다.
// Root는 최상위이므로 부모가 없어, 내용은 비어있습니다.
protocol RootListener: AnyObject {}

// Interactor가 지켜야 할 약속입니다.
// 자식인 TransactionList의 Listener 역할을 수행합니다.
protocol RootInteractable: Interactable, TransactionListListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}
