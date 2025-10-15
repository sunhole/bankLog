//
//  HomeInteractor.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import Foundation

final class HomeInteractor: Interactor, HomeInteractable, HomePresentableListener {
    weak var router: HomeRouting?
    weak var listener: HomeListener?

    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapTransactionHistory() {
        router?.routeToTransactionHistory()
    }
    
    func didTapTransfer() {
        router?.routeToTransectionTransfer()
    }
    
    func transactionListDidFinish() {
        router?.detachAllChildren(type: .transactionList)
    }
    
    func accountTransperDidFinish() {
        router?.detachAllChildren(type: .accountTransfer)
    }
}
