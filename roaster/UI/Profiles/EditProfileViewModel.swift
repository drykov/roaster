//
//  EditProfileViewModel.swift
//  roaster
//
//  Created by Dmitry Rykov on 11.08.2022.
//

import Foundation
import Combine

class EditProfileViewModel: ObservableObject {
    
    private let profilesService: ProfilesService
    
    private var cancellables = Set<AnyCancellable>()
    
    private let profile: Profile?
    
    let create: Bool
    
    @Published var name: String
    @Published var startTemperature: Int
    @Published var roastTime: Int
    @Published var startWeight: Int
    @Published var finish: Bool = false

    init(profile: Profile?, profilesService: ProfilesService = ProfilesServiceImpl.shared) {
        self.profilesService = profilesService
        self.profile = profile
        create = profile == nil
        name = profile?.name ?? ""
        startTemperature = profile?.startTemperature ?? 0
        roastTime = profile?.roastTime ?? 0
        startWeight = profile?.startWeight ?? 0
    }
    
    func saveProfile() {
        let profile = Profile(id: profile?.id, created: profile?.created, name: name, startTemperature: startTemperature, roastTime: roastTime, startWeight: startWeight)
        let publisher = create ? profilesService.createProfile(profile) : profilesService.updateProfile(profile)
        publisher
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Can't save profile \(error)")
                }
            }, receiveValue: { [weak self] in
                self?.finish.toggle()
            })
            .store(in: &cancellables)
    }
}
