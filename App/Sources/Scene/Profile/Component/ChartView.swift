//
//  ChartView.swift
//  MZ-APP
//
//  Created by 강인혜 on 6/12/24.
//  Copyright © 2024 com.mz. All rights reserved.
//

import SwiftUI
import Charts

struct ChartView: View {
    @State var userName = ""
    @State var stats: [ChartData] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(userName)님의 분야별 정답률")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
            
            Chart {
                ForEach(stats, id: \.self) { stat in
                    BarMark(
                        x: .value("Category", stat.category),
                        y: .value("Percentage", stat.percentage)
                    )
                    .annotation(position: .top, alignment: .center) {
                        Text("\(stat.percentage)")
                            .font(.system(size: 12))
                            .foregroundStyle(Color(uiColor: UIColor.gray700))
                    }
                    .foregroundStyle(.pink)
                }
            }
            .chartYAxis {
                AxisMarks(
                    format: Decimal.FormatStyle.Percent.percent.scale(1),
                    values: [0, 50, 100]
                )
            }
            .chartYAxis(.hidden)
            .background(Color.white)
        }
        .padding(20)
        .background(Color.white)
        .frame(height: 240)
    }
}
