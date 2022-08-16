//
//  TempChartView.swift
//  roaster
//
//  Created by Dmitry Rykov on 16.08.2022.
//

import SwiftUI
import Charts

struct TempChartView: UIViewRepresentable {
    
    let temps: [Temp]
    let firstCrackTime: Int?
    let secondCrackTime: Int?
    let developmentTime: Int

    func makeUIView(context: Context) -> LineChartView {
        LineChartView()
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        var tempEntries = [ChartDataEntry]()
        var rorEntries = [ChartDataEntry]()
        for i in 0..<temps.count {
            let time = Double(temps[i].time) / 60
            tempEntries.append(ChartDataEntry(x: time, y: Double(temps[i].temp)))
            let ror = i > 0 ? (temps[i].temp - temps[i - 1].temp) : 0
            rorEntries.append(ChartDataEntry(x: time, y: Double(50 + ror)))
        }
        let tempDataSet = createDataSet(entries: tempEntries, color: .brown)
        let rorDataSet = createDataSet(entries: rorEntries, color: .red)
        uiView.data = LineChartData(dataSets: [tempDataSet, rorDataSet])
        
        uiView.legend.enabled = false
        
        let xAxis = uiView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        xAxis.gridLineDashLengths = [8, 8]
        tryAddLine(axis: xAxis, value: firstCrackTime, color: .orange)
        tryAddLine(axis: xAxis, value: secondCrackTime, color: .magenta)
        tryAddLine(axis: xAxis, value: developmentTime, color: .blue)
        
        let leftAxis = uiView.leftAxis
        leftAxis.axisMinimum = 0
        leftAxis.axisMaximum = 250
        leftAxis.granularity = 50
        leftAxis.gridLineDashLengths = [8, 8]
        
        let rightAxis = uiView.rightAxis
        rightAxis.axisMinimum = -50
        rightAxis.axisMaximum = 200
        rightAxis.granularity = 50
        rightAxis.drawZeroLineEnabled = true
        rightAxis.zeroLineDashLengths = [8, 8]
        rightAxis.zeroLineColor = .red
        rightAxis.drawGridLinesEnabled = false
    }
    
    private func tryAddLine(axis: AxisBase, value: Int?, color: UIColor) {
        if let value = value {
            let line = ChartLimitLine(limit: Double(value) / 60)
            line.lineWidth = 2
            line.lineDashLengths = [8, 8]
            line.lineColor = color
            axis.addLimitLine(line)
        }
    }
    
    private func createDataSet(entries: [ChartDataEntry], color: UIColor) -> LineChartDataSet {
        let dataSet = LineChartDataSet(entries: entries)
        dataSet.colors = [color]
        dataSet.drawCircleHoleEnabled = false
        dataSet.circleColors = [color]
        dataSet.circleRadius = 4
        dataSet.lineWidth = 2
        dataSet.drawValuesEnabled = false
        return dataSet
    }
}

struct TempChart_Previews: PreviewProvider {
    
    static var previews: some View {
        TempChartView(temps: [
            Temp(time: 0, temp: 200),
            Temp(time: 55, temp: 150),
            Temp(time: 120, temp: 170),
            Temp(time: 300, temp: 180)
        ], firstCrackTime: 140, secondCrackTime: 210, developmentTime: 240)
        .frame(height: 300)
    }
}
