//
//  RoastsViewModel.swift
//  roaster
//
//  Created by Dmitry Rykov on 13.08.2022.
//

import Foundation
import Combine

class RoastsViewModel: ObservableObject {
    
    private let roastsService: RoastsService
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var roasts: [Roast] = .init()

    init(roastsService: RoastsService = RoastsServiceImpl.shared) {
        self.roastsService = roastsService
        getRoasts()
    }
    
    func getRoasts() {
        roastsService.getRoasts()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Can't get roasts \(error)")
                }
            }, receiveValue: { [weak self] roasts in
                self?.roasts = roasts
            })
            .store(in: &cancellables)
    }

    func deleteRoast(_ roast: Roast) {
        roastsService.deleteRoast(roast)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Can't delete roast \(error)")
                }
            }, receiveValue: { [weak self] in
                self?.getRoasts()
            })
            .store(in: &cancellables)
    }
}
