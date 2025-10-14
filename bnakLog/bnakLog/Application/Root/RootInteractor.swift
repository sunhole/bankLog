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
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.routeToHome()
    }
    
    override func willResignActive() {
        super.willResignActive()
        // 구독 해제등 메모리 해제 할거 하기 
    }
}
