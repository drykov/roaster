//
//  Double.swift
//  roaster
//
//  Created by Dmitry Rykov on 17.08.2022.
//

import Foundation

extension Double {
    
    func formatFraction() -> String? {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: self))
    }
}
