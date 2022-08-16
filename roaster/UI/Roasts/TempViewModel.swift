//
//  TempViewModel.swift
//  roaster
//
//  Created by Dmitry Rykov on 14.08.2022.
//

import Foundation
import Combine
import SwiftUI

class TempViewModel: ObservableObject {
    
    private let roastsService: RoastsService
    
    private var cancellables = Set<AnyCancellable>()
    
    private var roast: Roast?

    private var timer: Timer?
    @Published var started = false
    @Published var currentTime: Int = 0
    @Published var currentTemp: Int
    @Published var temps: [Temp] = .init()
    @Published var firstCrackTime: Int?
    @Published var secondCrackTime: Int?
    let developmentTime: Int
    @Published var endTime: Int?
    @Published var finish: Bool = false

    init(roast: Roast?, roastsService: RoastsService = RoastsServiceImpl.shared) {
        self.roastsService = roastsService
        self.roast = roast
        currentTemp = roast?.startTemperature ?? 0
        developmentTime = Int(Double(roast?.roastTime ?? 0) * 0.8)
    }

    func startRoast() {
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
        /*let roast = Roast(id: roast.id, created: roast.created, name: roast.name,
                          startTemperature: roast.startTemperature, roastTime: roast.roastTime, startWeight: roast.startWeight,
                          temps: temps, firstCrackTime: firstCrackTime, secondCrackTime: secondCrackTime, endTime: endTime, endWeight: nil)
        roastsService.updateRoast(roast)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Can't update roast \(error)")
                }
            }, receiveValue: { [weak self] in
                self?.finish.toggle()
            })
            .store(in: &cancellables)*/
    }
}
