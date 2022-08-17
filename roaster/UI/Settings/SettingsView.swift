//
//  SettingsView.swift
//  roaster
//
//  Created by Dmitry Rykov on 10.08.2022.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationView {
            Form {
                NavigationLink(destination: ProfilesView()) {
                    Text("Profiles")
                }
                Section {
                    NavigationLink(destination: WeightLossView()) {
                        Text("Weight loss calculator")
                    }
                    NavigationLink(destination: ExtractionView()) {
                        Text("Extraction calculator")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    
    static var previews: some View {
        SettingsView()
    }
}
