//
//  RoastView.swift
//  roaster
//
//  Created by Dmitry Rykov on 13.08.2022.
//

import SwiftUI

struct RoastView: View {
    
    @Binding var roast: Roast?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let roast = roast {
                    Group {
                        Text("Name:")
                            .foregroundColor(.gray)
                        Text(roast.name)
                        
                        Text("Date:")
                            .foregroundColor(.gray)
                            .padding(.top)
                        Text(roast.created?.formatFull() ?? "--")
                    }
                    
                    TempChartView(temps: roast.temps,
                                  firstCrackTime: roast.firstCrackTime,
                                  secondCrackTime: roast.secondCrackTime,
                                  developmentTime: nil)
                    .frame(height: 300)
                    .padding(.top)
                    
                    Group {
                        if let firstCrackTime = roast.firstCrackTime, firstCrackTime > 0 {
                            Text("First crack:")
                                .foregroundColor(.gray)
                                .padding(.top)
                            Text(firstCrackTime.formatTime() ?? "--:--")
                        }
                        
                        if let secondCrackTime = roast.secondCrackTime, secondCrackTime > 0 {
                            Text("Second crack:")
                                .foregroundColor(.gray)
                                .padding(.top)
                            Text(secondCrackTime.formatTime() ?? "--:--")
                        }
                        
                        if let endTime = roast.endTime, endTime > 0 {
                            Text("End time:")
                                .foregroundColor(.gray)
                                .padding(.top)
                            Text(endTime.formatTime() ?? "--:--")
                        }
                        
                        Text("Start weight:")
                            .foregroundColor(.gray)
                            .padding(.top)
                        Text(roast.startWeight.stringValue)
                        
                        if let endWeight = roast.endWeight, endWeight > 0 {
                            Text("End weight:")
                                .foregroundColor(.gray)
                                .padding(.top)
                            Text(endWeight.stringValue)
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct RoastView_Previews: PreviewProvider {
    
    static var previews: some View {
        RoastView(roast: .constant(Roast(id: nil, created: Date(), name: "test", startTemperature: 0, roastTime: 0, startWeight: 0, temps: [], firstCrackTime: nil, secondCrackTime: nil, endTime: 0, endWeight: nil)))
    }
}
