//
//  Binding.swift
//  address-lookup
//
//  Created by Stan Trujillo on 22/05/2025.
//

import SwiftUI

extension Binding {
    @MainActor
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
