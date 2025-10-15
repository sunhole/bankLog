//
//  AccountTransperInteractor.swift
//  bnakLog
//
//  Created by vision on 10/16/25.
//

import Foundation

final class AccountTransperInteractor: Interactor, AccountTransperInteractable, AccountTransperPresentableListener {
    weak var router: AccountTransperRouting?
    weak var listener: AccountTransperListener?
    weak var viewController: AccountTransperViewController?
    
    func didFinish() {
        listener?.accountTransperDidFinish()
    }
    
    func send(accountNumber: String, amount: String) {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        let dateString = formatter.string(from: today)
        
        let amountValue = Double(amount) ?? 0
        
        let newTransaction = Transaction(
            name: "용돈",
            date: dateString,
            amount: amountValue,
            isDeposit: false
        )
        
        listener?.transferDidFinish(with: newTransaction)
    }
}
