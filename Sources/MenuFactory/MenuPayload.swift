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

struct PrimitiveMenuPayload {
    let title: String?
    let image: Image?
    let tintColor: Color?
    
    let validates: [Validate]
    
    let object: Any?
    
    init() {
        self.title = nil
        self.image = nil
        self.tintColor = nil
        self.validates = []
        self.object = nil
    }

    private init(_ original: PrimitiveMenuPayload, editable: Editable) {
        self.title = editable.title
        self.image = editable.image
        self.tintColor = editable.tintColor
        self.validates = editable.validates
        self.object = editable.object
    }

    func edit(_ edit: @escaping (Editable) -> Void) -> Self {
        let editable = Editable(self)
        edit(editable)
        return .init(self, editable: editable)
    }

    class Editable {
        var title: String?
        var image: Image?
        var tintColor: Color?

        var validates: [Validate]

        var object: Any?

        fileprivate init(_ payload: PrimitiveMenuPayload) {
            self.title = payload.title
            self.image = payload.image
            self.tintColor = payload.tintColor
            self.validates = payload.validates
            self.object = payload.object
        }
    }
}

struct ComplexMenuPayload<Action> {
    let title: String?
    let image: Image?
    let tintColor: Color?
    let validates: [Validate]
    let object: Any?

    let action: Action

    init(_ payload: PrimitiveMenuPayload, action: Action) {
        self.title = payload.title
        self.image = payload.image
        self.tintColor = payload.tintColor
        self.validates = payload.validates
        self.object = payload.object
        self.action = action
    }
}
