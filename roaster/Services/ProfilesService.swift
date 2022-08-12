//
//  ProfilesService.swift
//  roaster
//
//  Created by Dmitry Rykov on 11.08.2022.
//

import Foundation
import Combine

protocol ProfilesService {
    
    func getProfiles() -> AnyPublisher<[Profile], Error>
    func createProfile(_ profile: Profile) -> AnyPublisher<Void, Error>
    func updateProfile(_ profile: Profile) -> AnyPublisher<Void, Error>
    func deleteProfile(_ profile: Profile) -> AnyPublisher<Void, Error>
}
