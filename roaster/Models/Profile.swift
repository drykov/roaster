//
//  Profile.swift
//  roaster
//
//  Created by Dmitry Rykov on 11.08.2022.
//

import Foundation

struct Profile: Identifiable {
    
    let id: String?
    let created: Date?
    
    let name: String
    let startTemperature: Int
    let roastTime: Int
    let startWeight: Int
}
