//
//  IntDoubleBinding.swift
//  roaster
//
//  Created by Dmitry Rykov on 15.08.2022.
//

import Foundation
import SwiftUI

struct IntDoubleBinding {
    
    let intValue : Binding<Int>
    
    let doubleValue : Binding<Double>
    
    init(_ intValue : Binding<Int>) {
        self.intValue = intValue
        self.doubleValue = Binding<Double>(get: {
            return Double(intValue.wrappedValue)
        }, set: {
            intValue.wrappedValue = Int($0)
        })
    }
}
