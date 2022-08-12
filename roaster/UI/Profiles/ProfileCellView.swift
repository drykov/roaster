//
//  ProfileCellView.swift
//  roaster
//
//  Created by Dmitry Rykov on 13.08.2022.
//

import SwiftUI

struct ProfileCellView: View {
    
    let profile: Profile
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(profile.name)
                Text(profile.created?.formatFull() ?? "-")
                    .foregroundColor(.gray)
            }
            .padding()
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color(.tertiaryLabel))
        }
    }
}

struct ProfileCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileCellView(profile: Profile(id: nil, created: Date(), name: "Test", startTemperature: 0, roastTime: 0, weight: 0))
    }
}
