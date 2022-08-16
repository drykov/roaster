//
//  ContentView.swift
//  roaster
//
//  Created by Dmitry Rykov on 10.08.2022.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView() {
            MainView()
                .tabItem {
                    Label("Main", systemImage: "play")
                }
            RoastsView()
                .tabItem {
                    Label("Roasts", systemImage: "list.bullet")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
