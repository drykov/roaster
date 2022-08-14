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
            //MainView()
            TempView(viewModel: TempViewModel(roast: Roast(id: nil, created: nil, name: "", startTemperature: 200, roastTime: 600, startWeight: 200,
                                                           temps: [], firstCrackTime: nil, secondCrackTime: nil, endTime: nil, endWeight: nil)))
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
