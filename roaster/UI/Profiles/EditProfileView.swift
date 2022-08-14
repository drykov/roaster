//
//  EditProfileView.swift
//  roaster
//
//  Created by Dmitry Rykov on 11.08.2022.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var viewModel: EditProfileViewModel
    
    var body: some View {
        Form {
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
                viewModel.saveProfile()
            } label: {
                Text("Save")
            }
        }
        .onReceive(viewModel.$finish) { _ in
            dismiss()
        }
        .navigationTitle(viewModel.create ? "Create profile" : "Edit profile")
    }
}

struct EditProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        EditProfileView(viewModel: .constant(EditProfileViewModel(profile: nil)))
    }
}
