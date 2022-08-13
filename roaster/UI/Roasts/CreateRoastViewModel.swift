//
//  CreateRoastViewModel.swift
//  roaster
//
//  Created by Dmitry Rykov on 13.08.2022.
//

import Foundation
import Combine

class CreateRoastViewModel: ObservableObject {
    
    private let profilesService: ProfilesService
    private let roastsService: RoastsService

    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var profiles: [Profile] = .init()
    
    @Published var selectedProfileId: String? {
        didSet {
            if let selectedProfileId = selectedProfileId {
                selectProfile(id: selectedProfileId)
            }
        }
    }

    @Published var name: String = ""
    @Published var startTemperature: Int = 0
    @Published var roastTime: Int = 0
    @Published var startWeight: Int = 0

    init(profilesService: ProfilesService = ProfilesServiceImpl.shared, roastsService: RoastsService = RoastsServiceImpl.shared) {
        self.profilesService = profilesService
        self.roastsService = roastsService

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
    
    private func selectProfile(id: String) {
        if let profile = profiles.first(where: { profile in profile.id == id }) {
            name = profile.name
            startTemperature = profile.startTemperature
            roastTime = profile.roastTime
            startWeight = profile.startWeight
        }
    }

    func createRoast() {
        let roast = Roast(id: nil, created: nil, name: name, startTemperature: startTemperature, roastTime: roastTime, startWeight: startWeight,
                          temps: [], firstCrackTime: nil, secondCrackTime: nil, endTime: nil, endWeight: nil)
        roastsService.createRoast(roast)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Can't create roast \(error)")
                }
            }, receiveValue: { [weak self] in
                //self?.finish.toggle()
            })
            .store(in: &cancellables)
    }
}
