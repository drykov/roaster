//
//  ExtractionViewModel.swift
//  roaster
//
//  Created by Dmitry Rykov on 17.08.2022.
//

import Foundation

class ExtractionViewModel: ObservableObject {
    
    @Published var brix: Double = 0 {
        didSet {
            calculateExtraction()
        }
    }

    @Published private(set) var tds: Double = 0

    @Published var groundWeight: Double = 0 {
        didSet {
            calculateExtraction()
        }
    }

    @Published var brewedWeight: Double = 0 {
        didSet {
            calculateExtraction()
        }
    }

    @Published private(set) var extraction: Double?

    private func calculateExtraction() {
        tds = 0.85 * brix
        extraction = groundWeight != 0 ? tds * brewedWeight / groundWeight : nil
    }
}
