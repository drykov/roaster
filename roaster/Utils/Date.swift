//
//  Date.swift
//  roaster
//
//  Created by Dmitry Rykov on 13.08.2022.
//

import Foundation

extension Date {
       
    func formatFull() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm"
        return formatter.string(from: self)
    }
}
