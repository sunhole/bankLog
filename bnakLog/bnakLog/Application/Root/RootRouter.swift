//
//  RootRouter.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

final class RootRouter: Router<RootInteractable>, RootRouting {
    private let viewController: RootViewController
    
    init(interactor: RootInteractor, viewController: RootViewController) {
        self.viewController = viewController
        super.init(interactor: interactor)
    }
    
    var viewControllable: UIViewController {
        return viewController
    }
    
    override func load() {
        super.load()
    }
}
