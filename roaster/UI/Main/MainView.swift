//
//  MainView.swift
//  roaster
//
//  Created by Dmitry Rykov on 10.08.2022.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        Text("What would like to\nroast today?")
            .font(.largeTitle)
    }
}

struct MainView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainView()
    }
}
