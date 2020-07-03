//
// Copyright (c) 2019-Present Umobi - https://github.com/umobi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation
import SwiftUI

public protocol PrimitiveMenuFactory {
    var isEnabled: Bool { get }
    var title: String? { get }
    var tintColor: Color? { get }
    var image: Image? { get }
    var object: Any? { get }
}

public struct MenuFactory: PrimitiveMenuFactory {
    fileprivate let payload: PrimitiveMenuPayload

    public init(title: String) {
        self.init(PrimitiveMenuPayload().edit {
            $0.title = title
        })
    }

    private init(_ payload: PrimitiveMenuPayload) {
        self.payload = payload
    }

    private func edit(_ edit: @escaping (PrimitiveMenuPayload.Editable) -> Void) -> Self {
        return .init(payload.edit {
            edit($0)
        })
    }

    public func with(tintColor: Color) -> Self {
        return self.edit {
            $0.tintColor = tintColor
        }
    }

    public func with(image: Image?) -> Self {
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

    public var isValid: Bool {
        self.payload.validates.isValid
    }

    public var isEnabled: Bool {
        return self.isValid
    }

    public var title: String? {
        return self.payload.title
    }

    public var tintColor: Color? {
        return self.payload.tintColor
    }

    public var image: Image? {
        return self.payload.image
    }

    public var object: Any? {
        return self.payload.object
    }

    public func action<Action>(_ menuAction: Action) -> ComplexMenuFactory<Action> {
        return ComplexMenuFactory(
            self,
            action: menuAction
        )
    }
}

public struct ComplexMenuFactory<Action>: PrimitiveMenuFactory {
    let payload: ComplexMenuPayload<Action>

    fileprivate init(_ menuFactory: MenuFactory, action: Action) {
        self.payload = .init(
            menuFactory.payload,
            action: action
        )
    }

    public var isValid: Bool {
        self.payload.validates.isValid
    }

    public var isEnabled: Bool {
        return self.isValid
    }

    public var title: String? {
        return self.payload.title
    }

    public var tintColor: Color? {
        return self.payload.tintColor
    }

    public var image: Image? {
        return self.payload.image
    }

    public var object: Any? {
        return self.payload.object
    }

    public var action: Action {
        self.payload.action
    }
}
