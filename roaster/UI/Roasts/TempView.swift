//
//  TempView.swift
//  roaster
//
//  Created by Dmitry Rykov on 14.08.2022.
//

import SwiftUI

struct TempView: View {
    
    @StateObject var viewModel: TempViewModel

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text(viewModel.currentTime.formatTime() ?? "--:--")
                        .frame(maxWidth: .infinity)
                    Button {
                        if viewModel.started {
                            viewModel.setEndTime()
                        } else {
                            viewModel.startRoast()
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
                        Text("First crack")
                    }
                    .frame(maxWidth: .infinity)
                    Button {
                        viewModel.setSecondCrack()
                    } label: {
                        Text("Second crack")
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                
                Text(viewModel.firstCrackTime?.formatTime() ?? "--:--")
                Text(viewModel.secondCrackTime?.formatTime() ?? "--:--")
                Text(viewModel.endTime?.formatTime() ?? "--:--")
                ForEach(viewModel.temps, id: \.self) { temp in
                    Text("\(temp.time.formatTime() ?? "--:--"), \(temp.temp)")
                }
            }
            Spacer()
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
                    Text("Set \(viewModel.currentTemp)°C")
                }
            }
            .padding()
        }
        .onReceive(viewModel.$finish) { _ in
            dismiss()
        }
    }
}

struct TempView_Previews: PreviewProvider {
    
    static var previews: some View {
        TempView(viewModel: TempViewModel(roast: Roast(id: nil, created: nil, name: "", startTemperature: 200, roastTime: 600, startWeight: 200,
                                                       temps: [], firstCrackTime: nil, secondCrackTime: nil, endTime: nil, endWeight: nil)))
    }
}
