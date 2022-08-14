//
//  CreateRoastView.swift
//  roaster
//
//  Created by Dmitry Rykov on 13.08.2022.
//

import SwiftUI

struct CreateRoastView: View {
    
    @Binding var reload: Bool
    
    @StateObject private var viewModel = CreateRoastViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
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
                    Text("Start")
                }
            }
            //NavigationLink(destination: TempView(viewModel: TempViewModel(roast: viewModel.roast)), isActive: $viewModel.finish) { EmptyView() }
        }
        .onReceive(viewModel.$finish) { _ in
            reload.toggle()
            dismiss()
        }
        .navigationTitle("Create roast")
    }
}

struct CreateRoastView_Previews: PreviewProvider {
    
    static var previews: some View {
        CreateRoastView(reload: .constant(false))
    }
}
