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
    //sample 데이터
    var Transactions = [
        Transaction(name: "카카오뱅크", date: "10월 15일", amount: 150000, isDeposit: true),
        Transaction(name: "배달의민족", date: "10월 14일", amount: 25000, isDeposit: false),
        Transaction(name: "스타벅스", date: "10월 14일", amount: 6500, isDeposit: false),
        Transaction(name: "월급", date: "10월 13일", amount: 3000000, isDeposit: true),
        Transaction(name: "쿠팡", date: "10월 12일", amount: 120000, isDeposit: false),
    ]
    
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
        router?.routeToTransactionHistory(transactions: Transactions)
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
    
    func transferDidFinish(with newTransaction: Transaction) {
        Transactions.insert(newTransaction, at: 0)
    }
}
