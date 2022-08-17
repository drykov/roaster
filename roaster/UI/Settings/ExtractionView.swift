//
//  ExtractionView.swift
//  roaster
//
//  Created by Dmitry Rykov on 17.08.2022.
//

import SwiftUI

struct ExtractionView: View {
    
    @StateObject var viewModel = ExtractionViewModel()
    
    var body: some View {
        Form {
            Section("BRIX, %") {
                TextField("BRIX", value: $viewModel.brix, format: .number)
                    .keyboardType(.decimalPad)
            }
            Section("TDS, %") {
                Text(viewModel.tds.formatFraction() ?? "--")
                    .foregroundColor(.gray)
            }
            Section("Ground coffee weight, g") {
                TextField("Coffee weight", value: $viewModel.groundWeight, format: .number)
                    .keyboardType(.decimalPad)
            }
            Section("Brewed weight, g") {
                TextField("Brewed weight", value: $viewModel.brewedWeight, format: .number)
                    .keyboardType(.decimalPad)
            }
            Section("Extraction, %") {
                Text(viewModel.extraction?.formatFraction() ?? "--")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Extraction")
    }

}

struct ExtractionView_Previews: PreviewProvider {
    
    static var previews: some View {
        ExtractionView()
    }
}
