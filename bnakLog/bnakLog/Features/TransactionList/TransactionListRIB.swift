//
//  TransactionListRIB.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit
import RIBs

protocol TransactionListBuildable: Buildable {
    func build(withListener listener: TransactionListListener, transactions: [Transaction]) -> TransactionListRouting
}

protocol TransactionListRouting: ViewableRouting {
    
}

protocol TransactionListInteractable: Interactable {
    var router: TransactionListRouting? { get set }
    var listener: TransactionListListener? { get set }
}

/// 부모 RIB (Root)에게 전달할 이벤트가 있다면 여기에 정의
protocol TransactionListListener: AnyObject {
    func transactionListDidFinish()
}
