//
//  TempView.swift
//  roaster
//
//  Created by Dmitry Rykov on 14.08.2022.
//

import SwiftUI

struct TempView: View {
    
    @ObservedObject var viewModel: CreateRoastViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.currentTime.formatTime() ?? "--:--")
                    .frame(maxWidth: .infinity)
                Button {
                    if viewModel.started {
                        viewModel.setEndTime()
                    } else {
                        viewModel.startTimer()
                    }
                } label: {
                    Image(systemName: viewModel.started ? "stop.fill" : "play.fill")
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            HStack {
                Button {
                    viewModel.setFirstCrackTime()
                } label: {
                    Text("First crack \(viewModel.firstCrackTime?.formatTime() ?? "")")
                }
                .frame(maxWidth: .infinity)
                Button {
                    viewModel.setSecondCrack()
                } label: {
                    Text("Second crack \(viewModel.secondCrackTime?.formatTime() ?? "")")
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            TempChartView(temps: viewModel.temps,
                          firstCrackTime: viewModel.firstCrackTime,
                          secondCrackTime: viewModel.secondCrackTime,
                          developmentTime: viewModel.developmentTime)
            .padding()
            VStack {
                HStack(spacing: 16) {
                    Button {
                        viewModel.currentTemp -= 1
                    } label: {
                        Image(systemName: "minus")
                    }
                    Slider(value: IntDoubleBinding($viewModel.currentTemp).doubleValue, in: 100...300)
                        .frame(maxWidth: .infinity)
                    Button {
                        viewModel.currentTemp += 1
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                Button {
                    viewModel.addTemp()
                } label: {
                    Text("Set \(viewModel.currentTemp)??C")
                }
                .padding()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct TempView_Previews: PreviewProvider {
    
    static var previews: some View {
        TempView(viewModel: CreateRoastViewModel())
    }
}
