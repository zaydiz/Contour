//
//  Binding-OnChange.swift
//  Shiny
//
//  Created by Anton Novoselov on 09.02.2021.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in self.wrappedValue = newValue
                handler()
            }
        )
    }
}
