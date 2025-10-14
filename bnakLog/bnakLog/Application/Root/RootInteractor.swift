//
//  RootInteractor.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import RxSwift

final class RootInteractor: Interactor, RootInteractable {
    weak var router: RootRouting?
    weak var listener: RootListener?
    private let dependency: RootDependency
    
    // 생성자(initializer)를 통해 의존성을 주입
    init(dependency: RootDependency) {
        self.dependency = dependency
        super.init()
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.routeToTransactionList()
    }
    
    override func willResignActive() {
        super.willResignActive()
        // 구독 해제등 메모리 해제 할거 하기 
    }
}
