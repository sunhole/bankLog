//
//  RootViewController.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

final class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func attachChild(viewControllable: Viewable) {
        let childViewController = viewControllable.uiviewController
        
        addChild(childViewController)
        view.addSubview(childViewController.view)
        
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            childViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        childViewController.didMove(toParent: self)
    }
}
