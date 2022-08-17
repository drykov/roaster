//
//  WeightLossViewModel.swift
//  roaster
//
//  Created by Dmitry Rykov on 17.08.2022.
//

import Foundation

class WeightLossViewModel: ObservableObject {
    
    @Published var greenWeight: Double = 0 {
        didSet {
            calculateLoss()
        }
    }
    
    @Published var roastedWeight: Double = 0 {
        didSet {
            calculateLoss()
        }
    }
    
    @Published private(set) var weightLoss: Double?
    
    private func calculateLoss() {
        weightLoss = greenWeight != 0 ? 100 * (greenWeight - roastedWeight) / greenWeight : nil
    }
}
