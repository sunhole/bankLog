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

final class TransactionListInteractor: Interactor, TransactionListInteractable, TransactionListPresentableListener {
    weak var router: TransactionListRouting?
    weak var listener: TransactionListListener?
    weak var viewController: TransactionListPresentable?
    
    private let transactions: [Transaction]
    
    init(initialTransactions: [Transaction]) {
        self.transactions = initialTransactions
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        viewController?.update(with: self.transactions)
    }
    
    func didFinish() {
        listener?.transactionListDidFinish()
    }
    
}
