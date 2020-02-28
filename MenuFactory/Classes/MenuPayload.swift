//
//  MenuPayload.swift
//  mercadoon
//
//  Created by brennobemoura on 13/09/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
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
