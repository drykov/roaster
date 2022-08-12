//
//  EditProfileView.swift
//  roaster
//
//  Created by Dmitry Rykov on 11.08.2022.
//

import SwiftUI

struct EditProfileView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var viewModel: EditProfileViewModel
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $viewModel.name)
            }
            Button {
                viewModel.saveProfile()
            } label: {
                Text("Save")
            }
        }
        .onReceive(viewModel.$finish) { _ in
            presentationMode.wrappedValue.dismiss()
        }
        .navigationTitle(viewModel.create ? "Create profile" : "Edit profile")
    }
}

struct EditProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        EditProfileView(viewModel: .constant(EditProfileViewModel(profile: nil)))
    }
}
