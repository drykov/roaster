//
//  RoastsService.swift
//  roaster
//
//  Created by Dmitry Rykov on 13.08.2022.
//

import Foundation
import Combine

protocol RoastsService {
    
    func getRoasts() -> AnyPublisher<[Roast], Error>
    func createRoast(_ roast: Roast) -> AnyPublisher<Void, Error>
    func updateRoast(_ roast: Roast) -> AnyPublisher<Void, Error>
    func deleteRoast(_ roast: Roast) -> AnyPublisher<Void, Error>
}
