//
//  WeightLossView.swift
//  roaster
//
//  Created by Dmitry Rykov on 17.08.2022.
//

import SwiftUI

struct WeightLossView: View {
    
    @StateObject var viewModel = WeightLossViewModel()
    
    var body: some View {
        Form {
            Section("Green coffee weight, g") {
                TextField("Green weight", value: $viewModel.greenWeight, format: .number)
                    .keyboardType(.decimalPad)
            }
            Section("Roasted coffee weight, g") {
                TextField("Roasted weight", value: $viewModel.roastedWeight, format: .number)
                    .keyboardType(.decimalPad)
            }
            Section("Weight loss, %") {
                Text(viewModel.weightLoss?.formatFraction() ?? "--")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Weight loss")
    }
}

struct WeightLossView_Previews: PreviewProvider {
    
    static var previews: some View {
        WeightLossView()
    }
}
