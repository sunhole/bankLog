//
//  TransactionListViewController.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit
import SwiftUI
import Combine

// MARK: - SwiftUI View (UI 개선)

struct TransactionListView: View {
    // TransactionListViewModel 구독
    @ObservedObject var viewModel: TransactionListViewModel
    
    var body: some View {
        ScrollView {
            // LazyVStack은 화면에 보이는 행만 렌더링하여 성능을 최적화합니다.
            LazyVStack(spacing: 0) {
                ForEach(viewModel.transactions) { transaction in
                    VStack(spacing: 0) {
                        HStack(spacing: 16) {
                            // 입출금 타입에 따라 아이콘을 표시합니다.
                            Image(systemName: transaction.isDeposit ? "arrow.down.left.circle.fill" : "arrow.up.right.circle.fill")
                                .font(.title2)
                                .foregroundColor(transaction.isDeposit ? Color.cyan : Color.white.opacity(0.8))
                                .frame(width: 30)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(transaction.name)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                Text(transaction.date)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            Text(transaction.formattedAmount)
                                .font(.system(.body, design: .monospaced))
                                .fontWeight(.semibold)
                                .foregroundColor(transaction.isDeposit ? .cyan : .white)
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 20)
                        
                        // 행 사이에 커스텀 구분선을 추가합니다.
                        Divider()
                            .background(Color.gray.opacity(0.2))
                            .padding(.leading, 66)
                    }
                }
            }
        }
        .background(Color(red: 0.05, green: 0.05, blue: 0.05).edgesIgnoringSafeArea(.all))
    }
}

// MARK: - ViewModel & Protocols

// SwiftUI View를 위한 상태 관리 객체
class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
}

// ViewController가 Interactor에게 보낼 신호를 정의하는 프로토콜
protocol TransactionListPresentableListener: AnyObject {
    func didFinish()
}


// MARK: - ViewController

// SwiftUI View를 호스팅하는 호스팅 뷰
final class TransactionListViewController: UIViewController, TransactionListPresentable {
    private let viewModel = TransactionListViewModel()
    weak var listener: TransactionListPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "거래내역"
        
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
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupNavigationBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParent {
            listener?.didFinish()
        }
    }
    
    func update(with transactions: [Transaction]) {
        viewModel.transactions = transactions
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.12, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        navigationItem.largeTitleDisplayMode = .never
    }
}

