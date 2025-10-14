//
//  TransactionListViewController.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit
import SwiftUI
import Combine

struct TransactionListView: View {
    //TransactionListViewModel 구독
    @ObservedObject var viewModel: TransactionListViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.transactions) { transaction in
                VStack(alignment: .leading, spacing: 4) {
                    Text(transaction.name)
                        .font(.headline)
                    Text(transaction.date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text(transaction.formattedAmount)
                    .font(.headline)
                    .foregroundColor(transaction.isDeposit ? .blue : .red)
            }
            .padding(.vertical, 8)
        }
        .navigationTitle("거래 내역")
    }
}

// SwiftUI View를 위한 상태 관리 객체
class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
}

// SwiftUI View를 호스팅하는 호스팅 뷰
final class TransactionListViewController: UIViewController, TransactionListPresentable {
    private let viewModel = TransactionListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hostingController = UIHostingController(rootView: TransactionListView(viewModel: viewModel))
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    func update(with transactions: [Transaction]) {
        viewModel.transactions = transactions
    }
}

