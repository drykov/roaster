//
//  ProfilesView.swift
//  roaster
//
//  Created by Dmitry Rykov on 11.08.2022.
//

import SwiftUI

struct ProfilesView: View {
    
    @StateObject private var viewModel = ProfilesViewModel()
    
    @State private var editProfile = false
    @State private var editViewModel = EditProfileViewModel(profile: nil)
    
    var body: some View {
        List(viewModel.profiles) { profile in
            NavigationLink(destination: EditProfileView(viewModel: $editViewModel), isActive: $editProfile) {
                ProfileCellView(profile: profile)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                editViewModel = EditProfileViewModel(profile: profile)
                editProfile.toggle()
            }
            .swipeActions(allowsFullSwipe: false) {
                Button(role: .destructive) {
                    viewModel.deleteProfile(profile)
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .refreshable {
            viewModel.getProfiles()
        }
        .onReceive(editViewModel.$finish) { _ in
            viewModel.getProfiles()
        }
        .toolbar {
            Button {
                editViewModel = EditProfileViewModel(profile: nil)
                editProfile.toggle()
            } label: {
                Image(systemName: "plus")
            }
        }
        .navigationBarTitle("Profiles")
    }
}

struct ProfilesView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfilesView()
    }
}
