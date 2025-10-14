//
//  RIBs.swift
//  bnakLog
//
//  Created by vision on 10/15/25.
//

import UIKit
import RxSwift

// MARK: - Core RIBs Protocols

/// 모든 RIB의 ViewController가 채택해야 하는 기본 프로토콜
protocol Viewable: AnyObject {}

/// 비즈니스 로직을 담당하는 Interactor가 채택하는 프로토콜
protocol Interactable: AnyObject {
    /// Interactor의 활성화 상태
    var isActive: Bool { get }
    /// Interactor의 활성화 상태를 관찰할 수 있는 스트림
    var isActiveStream: Observable<Bool> { get }

    /// Interactor 활성화
    func activate()
    /// Interactor 비활성화
    func deactivate()
}

/// 다른 RIB으로의 라우팅을 담당하는 Router가 채택하는 프로토콜
protocol Routing: AnyObject {
    /// Router가 로드될 때 호출
    func load()
    
    /// 자식 RIB을 붙임
    func attachChild(_ child: Routing)
    /// 자식 RIB을 뗌
    func detachChild(_ child: Routing)
}

/// RIB의 구성요소(Interactor, Router, View)를 생성하는 Builder가 채택하는 프로토콜
protocol Buildable: AnyObject {}


// MARK: - Base Classes

/// Interactable 프로토콜의 기본 구현체
class Interactor: Interactable {
    private let isActiveSubject = BehaviorSubject<Bool>(value: false)
    
    var isActive: Bool {
        (try? isActiveSubject.value()) ?? false
    }
    
    var isActiveStream: Observable<Bool> {
        isActiveSubject.asObservable()
    }
    
    func activate() {
        guard isActive else { return }
        isActiveSubject.onNext(true)
        didBecomeActive()
    }
    
    func deactivate() {
        guard isActive else { return }
        willResignActive()
        isActiveSubject.onNext(false)
    }
    
    func didBecomeActive() {
        //
    }
         
    func willResignActive() {
        //
    }
}

/// Routing 프로토콜의 기본 구현체
class Router<InteractorType>: Routing {
    let interactor: InteractorType
    private(set) var children: [Routing] = []
    
    init(interactor: InteractorType) {
        self.interactor = interactor
    }
    
    func load() {
        // 하위 클래스에서 구현
    }
    
    func attachChild(_ child: Routing) {
        children.append(child)
        child.load()
    }
    
    func detachChild(_ child: Routing) {
        children.removeAll { $0 === child }
    }
}

/// View를 가지는 Router를 위한 프로토콜
protocol ViewableRouting: Routing {
    var viewControllable: UIViewController { get }
}

