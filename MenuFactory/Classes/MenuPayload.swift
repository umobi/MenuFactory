//
//  MenuPayload.swift
//  mercadoon
//
//  Created by brennobemoura on 13/09/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import Foundation
import UIKit

final class MenuPayload {
    var action: Action = .never
    
    var title: String?
    var image: UIImage?
    var tintColor: UIColor?
    
    var validates: [Validate] = []
    
    var accessory: (type: UITableViewCell.AccessoryType, validate: Validate) = (.none, .true)
    
    var object: Any?
    
    init() {}
}
