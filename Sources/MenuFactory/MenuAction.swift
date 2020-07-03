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

protocol ViewAction {
    func body(content: AnyView) -> AnyView
}

public struct MenuModifier: ViewModifier {
    let action: ViewAction

    init(_ action: ViewAction) {
        self.action = action
    }

    public func body(content: Content) -> some View {
        action.body(content: AnyView(content))
    }
}

struct Push: ViewAction {
    let content: () -> AnyView

    init(_ content: @escaping () -> AnyView) {
        self.content = content
    }

    func body(content: AnyView) -> AnyView {
        AnyView(NavigationLink(destination: self.content()) {
            content
        })
    }
}

@available(tvOS, unavailable)
struct SheetPresent: ViewAction {
    let content: (Binding<Bool>) -> AnyView

    init(_ content: @escaping (Binding<Bool>) -> AnyView) {
        self.content = content
    }

    func body(content: AnyView) -> AnyView {
        let isPresented: State<Bool> = .init(wrappedValue: false)

        return AnyView(content.onTapGesture {
            isPresented.wrappedValue = true
        }
        .sheet(isPresented: isPresented.projectedValue) {
            self.content(isPresented.projectedValue)
        })
    }
}

@available(tvOS, unavailable)
struct ActionCallback: ViewAction {
    let action: () -> Void

    init(_ action: @escaping () -> Void) {
        self.action = action
    }

    func body(content: AnyView) -> AnyView {
        AnyView(content.onTapGesture {
            action()
        })
    }
}

#if os(iOS) || os(tvOS)
import UIKit

protocol ViewControllerAction {
    func perform(on viewController: UIViewController)
}

struct PushView: ViewControllerAction {
    let content: () -> UIViewController

    init(_ content: @escaping () -> UIViewController) {
        self.content = content
    }

    func perform(on viewController: UIViewController) {
        viewController.navigationController?.pushViewController(content(), animated: true)
    }
}

struct PresentView: ViewControllerAction {
    let content: () -> UIViewController

    init(_ content: @escaping () -> UIViewController) {
        self.content = content
    }

    func perform(on viewController: UIViewController) {
        viewController.present(viewController, animated: true, completion: nil)
    }
}

struct ActionCallbackUI: ViewControllerAction {
    let action: (UIViewController) -> Void

    init(_ action: @escaping (UIViewController) -> Void) {
        self.action = action
    }

    func perform(on viewController: UIViewController) {
        self.action(viewController)
    }
}
#endif
