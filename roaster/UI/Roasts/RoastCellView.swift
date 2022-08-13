//
//  RoastCellView.swift
//  roaster
//
//  Created by Dmitry Rykov on 13.08.2022.
//

import SwiftUI

struct RoastCellView: View {

    let roast: Roast
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(roast.name)
                Text(roast.created?.formatFull() ?? "-")
                    .foregroundColor(.gray)
            }
            .padding()
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(Color(.tertiaryLabel))
        }
    }
}

struct RoastCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        RoastCellView(roast: Roast(id: nil, created: nil, name: "", startTemperature: 0, roastTime: 0, startWeight: 0, temps: [], firstCrackTime: nil, secondCrackTime: nil, endTime: nil, endWeight: nil))
    }
}
