//
//  MenuAction.swift
//  mercadoon
//
//  Created by brennobemoura on 13/09/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import Foundation
import UIKit

public protocol MenuActionType {
    func perform(on viewController: UIViewController!)
}

public enum Action {
    case viewController(ViewController)
    case callback(Callback)
    case never

    public func perform(on viewController: UIViewController!) {
        switch self {
        case .viewController(let manager):
            manager.perform(on: viewController)
        case .callback(let manager):
            manager.perform(on: viewController)
        case .never:
            return
        }
    }
}

public extension Action {
    struct Callback: MenuActionType {
        private let handler: (UIViewController) -> Void

        public init(_ handler: @escaping (UIViewController) -> Void) {
            self.handler = handler
        }

        public func perform(on viewController: UIViewController!) {
            self.handler(viewController)
        }
    }
}

public extension Action {
    struct ViewController: MenuActionType {
        let dynamic: () -> UIViewController
        let onPresentation: ((UIViewController) -> UIViewController)?
        public let transition: TransitionHandler

        public init(dynamic: @escaping () -> UIViewController, onPresentation: ((UIViewController) -> UIViewController)? = nil) {
            self.dynamic = dynamic
            self.onPresentation = onPresentation
            self.transition = .modal
        }

        private init(_ original: ViewController, handler: TransitionHandler) {
            self.dynamic = original.dynamic
            self.onPresentation = original.onPresentation
            self.transition = handler
        }

        public func with(handler: TransitionHandler) -> ViewController {
            return ViewController(self, handler: handler)
        }

        private func viewController() -> UIViewController {
            let vc = self.dynamic()
            if let onPresentation = self.onPresentation {
                return onPresentation(vc)
            }

            return vc
        }

        public func perform(on viewController: UIViewController!) {
            let child = self.viewController()
            self.transition.perform(on: viewController, transition: child)
        }
    }
}

public extension Action.ViewController {
    struct TransitionHandler: TransitionType {
        public typealias Parent = UIViewController
        public typealias Child = UIViewController

        public let rawValue: String
        public let handler: (UIViewController, UIViewController) -> Void

        public init(_ rawValue: String, _ handler: @escaping (UIViewController, UIViewController) -> Void) {
            self.rawValue = rawValue
            self.handler = handler
        }
    }
}

public extension Action.ViewController.TransitionHandler {
    static var modal: Action.ViewController.TransitionHandler {
        return .init("modal", { parent, child in
            parent.present(child, animated: true, completion: nil)
        })
    }

    static var push: Action.ViewController.TransitionHandler {
        return .init("push", { parent, child in
            parent.navigationController?.pushViewController(child, animated: true)
        })
    }
}
