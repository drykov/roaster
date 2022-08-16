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
    
    @Published var create = true
    @Published var finish = false
    
    // create
    @Published var name: String = ""
    @Published var startTemperature: Int = 0
    @Published var roastTime: Int = 0
    @Published var startWeight: Int = 0
    
    // roast
    private var timer: Timer?
    @Published var started = false
    @Published var currentTime: Int = 0
    @Published var currentTemp: Int = 0
    @Published var temps: [Temp] = .init()
    @Published var firstCrackTime: Int?
    @Published var secondCrackTime: Int?
    @Published var developmentTime: Int?
    @Published var endTime: Int?
    
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
    
    func startRoast() {
        currentTemp = startTemperature
        developmentTime = Int(Double(roastTime) * 0.8)
        create = false
    }
    
    func startTimer() {
        addTemp()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            self?.currentTime += 1
        }
        started = true
    }
    
    func addTemp() {
        temps.append(Temp(time: currentTime, temp: currentTemp))
    }
    
    func setFirstCrackTime() {
        firstCrackTime = currentTime
    }
    
    func setSecondCrack() {
        secondCrackTime = currentTime
    }
    
    func setEndTime() {
        timer?.invalidate()
        endTime = currentTime
        started = false
        
        let roast = Roast(id: nil, created: nil, name: name, startTemperature: startTemperature, roastTime: roastTime, startWeight: startWeight,
                          temps: temps, firstCrackTime: firstCrackTime, secondCrackTime: secondCrackTime, endTime: endTime, endWeight: nil)
        roastsService.createRoast(roast)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Can't create roast \(error)")
                }
            }, receiveValue: { [weak self] in
                self?.finish.toggle()
            })
            .store(in: &cancellables)
    }
}
