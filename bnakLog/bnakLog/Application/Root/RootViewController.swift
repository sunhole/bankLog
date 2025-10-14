//
//  RootViewController.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

// 이 프로토콜은 Router가 ViewController를 제어하기 위해 사용됩니다.
protocol RootViewControllable: Viewable {
    func setRoot(viewControllable: Viewable)
}

final class RootViewController: UIViewController, RootViewControllable {
    
    private var managedNavigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    /// 내비게이션 컨트롤러의 첫 화면을 설정합니다.
    func setRoot(viewControllable: Viewable) {
        let rootViewController = viewControllable.uiviewController
        
        // 기존에 navigationController가 있다면 제거합니다.
        if let existingNav = self.managedNavigationController {
            existingNav.willMove(toParent: nil)
            existingNav.view.removeFromSuperview()
            existingNav.removeFromParent()
        }
        
        // 새로운 navigationController를 만들고 화면에 추가합니다.
        let navigationController = UINavigationController(rootViewController: rootViewController)
        self.managedNavigationController = navigationController
        
        addChild(navigationController)
        view.addSubview(navigationController.view)
        navigationController.didMove(toParent: self)
        
        // AutoLayout 설정
        navigationController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationController.view.topAnchor.constraint(equalTo: view.topAnchor),
            navigationController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
