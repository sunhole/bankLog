//
//  HomeRIB.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit
import RIBs

// MARK: - Dependency

// HomeRIB이 부모 RIB으로부터 받아야 할 의존성을 정의합니다.
// 지금은 비어있지만, 나중에 자식 RIB(TransactionList, Transfer)을 만들 때 필요한 Builder들을 여기에 추가하게 됩니다.
protocol HomeDependency: AnyObject {
    var transactionListBuilder: TransactionListBuildable { get }
}

// HomeDependency를 실제로 구현할 Component 클래스입니다.
// Builder가 Interactor나 Router를 만들 때 필요한 것들을 여기서 생성합니다.
final class HomeComponent: Component<HomeDependency> {
    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

protocol HomePresentable: AnyObject {
    var listener: HomePresentableListener? { get set }
}

// MARK: - Builder

protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener) -> HomeRouting
}

// MARK: - Router

protocol HomeRouting: ViewableRouting {
    func routeToTransactionHistory()
    func detachTransactionHistory()
    func routeToTransectionTransfer()
}

protocol HomeViewControllable: Viewable {
    func push(viewControllable: Viewable)
}

// MARK: - Listener

protocol HomeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

// MARK: - Interactor

protocol HomeInteractable: Interactable, HomePresentableListener, TransactionListListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}
