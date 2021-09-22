//
//  CloudError.swift
//  CloudError
//
//  Created by Anton Novoselov on 22.09.2021.
//

import Foundation

struct CloudError: Identifiable, ExpressibleByStringInterpolation {
    var id: String { message }
    var message: String

    init(stringLiteral value: String) {
        self.message = value
    }
}
