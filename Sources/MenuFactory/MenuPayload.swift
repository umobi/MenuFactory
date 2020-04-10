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
import UIKit

struct MenuPayload {
    let action: Action
    
    let title: String?
    let image: UIImage?
    let tintColor: UIColor?
    
    let validates: [Validate]
    
    let accessory: (type: UITableViewCell.AccessoryType, validate: Validate)
    
    let object: Any?
    
    init() {
        self.action = .never
        self.title = nil
        self.image = nil
        self.tintColor = nil
        self.validates = []
        self.accessory = (.none, .true)
        self.object = nil
    }

    private init(_ original: MenuPayload, editable: Editable) {
        self.action = editable.action
        self.title = editable.title
        self.image = editable.image
        self.tintColor = editable.tintColor
        self.validates = editable.validates
        self.accessory = editable.accessory
        self.object = editable.object
    }

    func edit(_ edit: @escaping (Editable) -> Void) -> Self {
        let editable = Editable(self)
        edit(editable)
        return .init(self, editable: editable)
    }

    class Editable {
        var action: Action

        var title: String?
        var image: UIImage?
        var tintColor: UIColor?

        var validates: [Validate]

        var accessory: (type: UITableViewCell.AccessoryType, validate: Validate)

        var object: Any?

        fileprivate init(_ payload: MenuPayload) {
            self.action = payload.action
            self.title = payload.title
            self.image = payload.image
            self.tintColor = payload.tintColor
            self.validates = payload.validates
            self.accessory = payload.accessory
            self.object = payload.object
        }
    }

}
