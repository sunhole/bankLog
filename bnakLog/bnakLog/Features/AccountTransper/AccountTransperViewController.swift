//
//  AccountTransperViewController.swift
//  bnakLog
//
//  Created by vision on 10/16/25.
//

import UIKit
import SwiftUI
import Combine

// ViewController -> Interactor
protocol AccountTransperPresentableListener: AnyObject {
    func didFinish()
}
 
private struct TransperView: View {
    var onSendTapped: (String, String) -> Void
    var onCloseTapped: () -> Void
    
    @State private var accountNumber: String = ""
    @State private var amount: String = ""
    
    private var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    private var isSendButtonDisabled: Bool {
        accountNumber.isEmpty || (Double(amount) ?? 0) <= 0
    }
    
    init(onSendTapped: @escaping (String, String) -> Void, onCloseTapped: @escaping () -> Void) {
        self.onSendTapped = onSendTapped
        self.onCloseTapped = onCloseTapped
    }
    
    private let quickAmounts = [10000, 50000, 100000, 1000000]
    
    var body: some View {
        ZStack {
            // 배경색
            Color(red: 0.05, green: 0.05, blue: 0.05).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 0) {
                // 헤더 텍스트
                Text("어디로 보낼까요?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                
                // 계좌번호 입력 필드
                TextField("계좌번호 입력", text: $accountNumber)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                
                // 보낼 금액 입력 필드
                TextField("보낼 금액 (원)", text: $amount)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.top, 16)
                    .padding(.horizontal, 20)
                
                // 빠른 금액 추가 버튼
                HStack {
                    ForEach(quickAmounts, id: \.self) { quickAmount in
                        Button(action: {
                            let currentAmount = Double(self.amount) ?? 0
                            self.amount = "\(Int(currentAmount) + quickAmount)"
                        }) {
                            Text("+\(quickAmount / 10000)만")
                                .font(.footnote)
                                .foregroundColor(.cyan)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.cyan.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.top, 12)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // 보내기 버튼
                Button(action: {
                    onSendTapped(accountNumber, amount)
                }) {
                    Text("보내기")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(isSendButtonDisabled ? .gray : .black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isSendButtonDisabled ? Color.gray.opacity(0.5) : Color.cyan)
                        .cornerRadius(12)
                }
                .disabled(isSendButtonDisabled)
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
    }
}


// MARK: - ViewController
final class AccountTransperViewController: UIViewController {

    weak var listener: AccountTransperPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "이체하기"
        setupNavigationBar()
        
        let transperView = TransperView(
            onSendTapped: { [weak self] accountNumber, amount in
                self?.listener?.didFinish()
            },
            onCloseTapped: { [weak self] in
                self?.listener?.didFinish()
            }
        )
        
        let hostingController = UIHostingController(rootView: transperView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupNavigationBar()
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if isMovingFromParent {
            listener?.didFinish()
        }
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
