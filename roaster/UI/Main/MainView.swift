//
//  MainView.swift
//  roaster
//
//  Created by Dmitry Rykov on 10.08.2022.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ProfilesView()) {
                    Text("Profiles")
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
    }
}
