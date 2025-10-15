//
//  HomeViewController.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit
import SwiftUI

// MARK: - SwiftUI View for Home Screen

// Interactor에게 액션을 알리기 위한 프로토콜
protocol HomePresentableListener: AnyObject {
    func didTapTransactionHistory()
    func didTapTransfer()
}

struct HomeView: View {
    
    var onTransactionHistoryTapped: () -> Void
    var onTransferTapped:() -> Void
    
    private var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    init(onTransactionHistoryTapped: @escaping () -> Void, onTransferTapped: @escaping () -> Void) {
        self.onTransactionHistoryTapped = onTransactionHistoryTapped
        self.onTransferTapped = onTransferTapped
    }
    
    private let balance: Double = 1234567
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 0.05, green: 0.05, blue: 0.05).edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("내 카카오뱅크 계좌")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    Text("\(currencyFormatter.string(from: NSNumber(value: balance)) ?? "0")원")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(24)

                Spacer()

                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.black.opacity(0.5))

                HStack(spacing: 0) {
                    Button(action: {
                        self.onTransactionHistoryTapped()
                    }) {
                        Text("거래내역")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .foregroundColor(.white)
                    }

                    Rectangle()
                        .frame(width: 1, height: 60)
                        .foregroundColor(Color.black.opacity(0.5))

                    Button(action: {
                        self.onTransferTapped()
                    }) {
                        Text("이체")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .foregroundColor(.white)
                    }
                }
            }
            .background(Color(red: 0.1, green: 0.1, blue: 0.12))
            .cornerRadius(20)
            .frame(height: 200)
            .padding(.horizontal, 16)
            .shadow(color: .black.opacity(0.4), radius: 10, y: 5)
        }
    }
}

// MARK: - Home ViewController

final class HomeViewController: UIViewController, HomePresentable, HomeViewControllable {
    weak var listener: HomePresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeView = HomeView(
            onTransactionHistoryTapped: { [weak self] in
                self?.listener?.didTapTransactionHistory()
            },
            onTransferTapped: { [weak self] in
                self?.listener?.didTapTransfer()
            }
        )
        
        let hostingController = UIHostingController(rootView: homeView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func push(viewControllable: Viewable) {
        self.navigationController?.pushViewController(viewControllable.uiviewController, animated: true)
    }
}

