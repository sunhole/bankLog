//
//  Transaction.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import Foundation

struct Transaction: Identifiable {
    let id: UUID = UUID()
    let name: String
    let date: String
    let amount: Double
    let isDeposit: Bool
    
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        let number = NSNumber(value: amount)
        let formattedValue = formatter.string(from: number) ?? ""
        return isDeposit ? "+\(formattedValue)" : "-\(formattedValue)"
    }
}
