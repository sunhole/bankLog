//
//  RootViewController.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

final class RootViewController: UIViewController, Viewable {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func present(viewControllable: UIViewController) {
        addChild(viewControllable)
        view.addSubview(viewControllable.view)
        viewControllable.view.frame = view.bounds
        viewControllable.didMove(toParent: self)
    }
}
