//
//  MenuItem.swift
//  TokBeauty
//
//  Created by Ramon Vicente on 24/03/17.
//  Copyright © 2017 TokBeauty. All rights reserved.
//

import Foundation
import UIKit

public class MenuFactory {
    private let payload = MenuPayload()
    
    public init(title: String) {
        self.payload.title = title
    }
    
    public func with(tintColor: UIColor) -> Self {
        self.payload.tintColor = tintColor
        return self
    }
    
    public func with(image: UIImage?) -> Self {
        self.payload.image = image
        return self
    }
    
    public func with<Object>(object: Object) -> Self {
        self.payload.object = object
        return self
    }
    
    public func validate(_ validate: Validate...) -> Self {
        validate.forEach {
            self.payload.validates.append($0)
        }
        return self
    }
    
    public func accessory(type: UITableViewCell.AccessoryType, with validate: Validate = .true) -> Self {
        self.payload.accessory = (type, validate)
        return self
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
        self.payload.action = menuAction
        return self
    }
    
    public var action: Action {
        return self.payload.action
    }
//    func perform(on viewController: UIViewController!) {
//        self.payload.action.perform(on: viewController)
//    }
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
