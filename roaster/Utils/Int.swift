//
//  Int.swift
//  roaster
//
//  Created by Dmitry Rykov on 14.08.2022.
//

import Foundation

extension Int {
       
    func formatTime() -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad, .pad]
        return formatter.string(from: TimeInterval(self))
    }
}
