//
//  MenuItem.swift
//  TokBeauty
//
//  Created by Ramon Vicente on 24/03/17.
//  Copyright © 2017 TokBeauty. All rights reserved.
//

import Foundation
import UIKit

public struct MenuFactory {
    private let payload: MenuPayload

    public init(title: String) {
        self.init(MenuPayload().edit {
            $0.title = title
        })
    }

    private init(_ payload: MenuPayload) {
        self.payload = payload
    }

    private func edit(_ edit: @escaping (MenuPayload.Editable) -> Void) -> Self {
        return .init(payload.edit {
            edit($0)
        })
    }

    public func with(tintColor: UIColor) -> Self {
        return self.edit {
            $0.tintColor = tintColor
        }
    }

    public func with(image: UIImage?) -> Self {
        return self.edit {
            $0.image = image
        }
    }

    public func with<Object>(object: Object) -> Self {
        return self.edit {
            $0.object = object
        }
    }

    public func validate(_ validate: Validate...) -> Self {
        return self.edit {
            $0.validates = $0.validates + validate
        }
    }

    public func accessory(type: UITableViewCell.AccessoryType, with validate: Validate = .true) -> Self {
        return self.edit {
            $0.accessory = (type, validate)
        }
    }

    public var isValid: Bool {
        if self.payload.validates.count == 0 {
            return true
        }

        return self.payload.validates.allSatisfy { return $0.isValid }
    }

    public var isEnabled: Bool {
        return self.isValid
    }

    public var title: String? {
        return self.payload.title
    }

    public var tintColor: UIColor? {
        return self.payload.tintColor
    }

    public var image: UIImage? {
        return self.payload.image
    }

    public var accessoryType: UITableViewCell.AccessoryType? {
        return self.payload.accessory.validate.isValid ? self.payload.accessory.type : nil
    }

    public var object: Any? {
        return self.payload.object
    }

    public func action(menuAction: Action) -> Self {
        return self.edit {
            $0.action = menuAction
        }
    }

    public var action: Action {
        return self.payload.action
    }
}

public extension MenuFactory {
    func pushViewController(_ dynamic: @escaping () -> UIViewController) -> Self {
        return self.action(menuAction: .viewController(Action.ViewController(
            dynamic: dynamic
        ).with(handler: .push)))
    }

    func callback(_ handler: @escaping (UIViewController) -> Void) -> Self {
        return self.action(menuAction: .callback(.init(handler)))
    }
}
