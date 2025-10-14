//
//  RootRouter.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

final class RootRouter: Router<RootInteractable>, RootRouting {
    
    private let viewController: RootViewController
    private let homeBuilder: HomeBuildable
    
    private var homeRouter: Routing?

    init(
        interactor: RootInteractable,
        viewController: RootViewController,
        homeBuilder: HomeBuildable
    ) {
        self.viewController = viewController
        self.homeBuilder = homeBuilder
        // 부모 클래스의 생성자를 호출합니다.
        super.init(interactor: interactor)
    }
    
    var viewControllable: Viewable {
        return viewController
    }

    func routeToHome() {
        guard homeRouter == nil else { return }
        
        let router = homeBuilder.build(withListener: interactor)
        self.homeRouter = router
        attach(child: router)
        
        viewController.setRoot(viewControllable: router.viewControllable)
    }
}
