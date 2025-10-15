//
//  RIBs.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit

// MARK: - Routing

public protocol Routing: AnyObject {
    func interact()
    func stopInteract()
}

public protocol ViewableRouting: Routing {
    var viewControllable: Viewable { get }
}

// MARK: - Viewable

public protocol Viewable: AnyObject {
    var uiviewController: UIViewController { get }
}

extension UIViewController: Viewable {
    public var uiviewController: UIViewController {
        return self
    }
}

// MARK: - Interactable

public protocol Interactable: AnyObject {
    var isActive: Bool { get }
    func activate()
    func deactivate()
}

// MARK: - Interactor

open class Interactor: Interactable {
    public var isActive: Bool = false
    
    public init() {}
    
    public func activate() {
        guard !isActive else { return }
        isActive = true
        didBecomeActive()
    }
    
    public func deactivate() {
        guard isActive else { return }
        isActive = false
        willResignActive()
    }
    
    open func didBecomeActive() {}
    
    open func willResignActive() {}
}

// MARK: - Router

open class Router<InteractorType>: NSObject, Routing {
    public let interactor: InteractorType
    private(set) var children: [Routing] = []
    
    public init(interactor: InteractorType) {
        self.interactor = interactor
    }
    
    public func interact() {
        (interactor as? Interactable)?.activate()
    }
    
    public func stopInteract() {
        (interactor as? Interactable)?.deactivate()
    }
    
    public func attach(child: Routing) {
        guard !children.contains(where: { $0 === child }) else { return }
        children.append(child)
        child.interact()
    }
    
    public func detach(child: Routing) {
        guard let index = children.firstIndex(where: { $0 === child }) else { return }
        children.remove(at: index)
        child.stopInteract()
    }
}

// MARK: - ViewableRouting Launch Extension

public extension ViewableRouting {
    /// RIB을 window에 연결하고 앱을 시작합니다.
    func launch(from window: UIWindow) {
        window.rootViewController = viewControllable.uiviewController
        window.makeKeyAndVisible()
        
        interact()
    }
}
