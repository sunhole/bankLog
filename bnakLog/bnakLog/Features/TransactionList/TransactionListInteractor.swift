//
//  TransactionListInteractor.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import RxSwift

//Interactor가 ViewController에게 명령을 내리기 위한 프로토콜
protocol TransactionListPresentable: AnyObject {
    func update(with transactions: [Transaction])
}

final class TransactionListInteractor: Interactor, TransactionListInteractable {
    weak var router: TransactionListRouting?
    weak var listener: TransactionListListener?
    weak var viewController: TransactionListPresentable?
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        let sampleTransactions = [
            Transaction(name: "카카오뱅크", date: "10월 15일", amount: 150000, isDeposit: true),
            Transaction(name: "배달의민족", date: "10월 14일", amount: 25000, isDeposit: false),
            Transaction(name: "스타벅스", date: "10월 14일", amount: 6500, isDeposit: false),
            Transaction(name: "월급", date: "10월 13일", amount: 3000000, isDeposit: true),
            Transaction(name: "쿠팡", date: "10월 12일", amount: 120000, isDeposit: false),
        ]
        
        
        viewController?.update(with: sampleTransactions)
    }
    
}
