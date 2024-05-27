//
//  HeatmapDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/27.
//

import Foundation
import SwiftUI

/// 热力图控件
struct HeatmapDemoView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                HeatmapSampleView()
                HeatmapSampleView2()
            }
        }
    }
}

struct HeatmapSampleView2: View {
    
    var values: [[HeatmapView.Value]] = []
    
    let row = 7
    let col = 15
    
    init() {
        for i in 0..<row {
            var rowValues: [HeatmapView.Value] = []
            for j in 0..<col {
                let alpha = arc4random() % 255
                let uiColor = UIColor(red: 0, green: 255, blue: 0, alpha: CGFloat(alpha))
                let color = Color(uiColor)
                let title = j % 7 == 0 ? "T" : ""
                let foot = j % 7 == 0 ? "1月" : ""
                rowValues.append(HeatmapView.Value(value: i*col+j,
                                                   text: "\(i*col+j)",
                                                   color: color,
                                                   title: title,
                                                   foot: foot))
            }
            values.append(rowValues)
        }
    }
    
    var body: some View {
        HeatmapView(size: 20,
                    corner: 4,
                    textSize: 8,
                    textColor: .gray,
                    edgeTextSize: 10,
                    edgeTextColor: .blue,
                    spacing: 3,
                    values: values,
                    onTap: { value in
            print("点击了 \(value.value)")
        })
    }
}

#Preview {
    HeatmapDemoView()
}
