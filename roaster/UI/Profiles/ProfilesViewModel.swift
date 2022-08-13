//
//  ProfilesViewModel.swift
//  roaster
//
//  Created by Dmitry Rykov on 11.08.2022.
//

import Foundation
import Combine

class ProfilesViewModel: ObservableObject {
    
    private let profilesService: ProfilesService
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var profiles: [Profile] = .init()

    init(profilesService: ProfilesService = ProfilesServiceImpl.shared) {
        self.profilesService = profilesService
        getProfiles()
    }
    
    func getProfiles() {
        profilesService.getProfiles()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Can't get profiles \(error)")
                }
            }, receiveValue: { [weak self] profiles in
                self?.profiles = profiles
            })
            .store(in: &cancellables)
    }

    func deleteProfile(_ profile: Profile) {
        profilesService.deleteProfile(profile)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Can't delete profile \(error)")
                }
            }, receiveValue: { [weak self] in
                self?.getProfiles()
            })
            .store(in: &cancellables)
    }
}
