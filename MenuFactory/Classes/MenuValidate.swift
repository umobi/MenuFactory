//
//  MenuValidate.swift
//  mercadoon
//
//  Created by brennobemoura on 13/09/19.
//  Copyright © 2019 brennobemoura. All rights reserved.
//

import Foundation

public struct Validate {
    private let function: () -> Bool

    public init(_ function: @escaping () -> Bool) {
        self.function = function
    }

    public var isValid: Bool {
        return self.function()
    }
}

public extension Validate {
    static var `true`: Validate {
        return .init({ true })
    }
}
