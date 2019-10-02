//
//  MenuItemPresentStyle.swift
//  mercadoon
//
//  Created by brennobemoura on 13/09/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import Foundation

public protocol TransitionType {
    associatedtype Parent
    associatedtype Child
    
    var rawValue: String { get }
    var handler: (Parent, Child) -> Void { get }
    
    init(_ rawValue: String, _ handler: @escaping (Parent, Child) -> Void)
    
    func perform(on parent: Parent, transition child: Child)
}

public func ==<T: TransitionType>(left: T, right: T) -> Bool {
    return left.rawValue == right.rawValue
}

public extension TransitionType {
    func perform(on parent: Parent, transition child: Child) {
        self.handler(parent, child)
    }
}
