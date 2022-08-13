//
//  CreateRoastView.swift
//  roaster
//
//  Created by Dmitry Rykov on 13.08.2022.
//

import SwiftUI

struct CreateRoastView: View {
    
    @StateObject private var viewModel = CreateRoastViewModel()

    var body: some View {
        Form {
            Picker(selection: $viewModel.selectedProfileId, label: Text("Load profile")) {
                ForEach(viewModel.profiles) { profile in
                    Text(profile.name)
                }
            }
            Section("Name") {
                TextField("Name", text: $viewModel.name)
            }
            Section("Start temperature, °C") {
                TextField("Temperature", value: $viewModel.startTemperature, formatter: NumberFormatter())
            }
            Section("Roast time, s") {
                TextField("Time", value: $viewModel.roastTime, formatter: NumberFormatter())
            }
            Section("Start weight, g") {
                TextField("Weight", value: $viewModel.startWeight, formatter: NumberFormatter())
            }
            Button {
                viewModel.createRoast()
            } label: {
                Text("Create")
            }
        }
        .navigationTitle("Create roast")
    }
}

struct CreateRoastView_Previews: PreviewProvider {
    
    static var previews: some View {
        CreateRoastView()
    }
}
