//
//  Roast.swift
//  roaster
//
//  Created by Dmitry Rykov on 13.08.2022.
//

import Foundation

struct Roast: Identifiable {
    
    let id: String?
    let created: Date?
    
    let name: String
    let startTemperature: Int
    let roastTime: Int
    let startWeight: Int
    
    let temps: [Temp]
    let firstCrackTime: Int?
    let secondCrackTime: Int?
    let endTime: Int?
    let endWeight: Int?
}
