//
//  HeatmapView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/27.
//

import Foundation
import SwiftUI

/// 一个单元格
struct HeatmapCell: View {

    /// 单元格的大小
    var size: CGFloat = 16
    
    /// 单元格的边角
    var corner: CGFloat = 4
    
    /// 单元格文字大小
    var textSize: CGFloat = 8
    
    ///单元格文字颜色
    var textColor: Color = .black
    
    let value: HeatmapView.Value

    let onTap: (_ value: HeatmapView.Value) -> Void
    
//    @State private var isPressed = false

    var body: some View {
        ZStack {
            Rectangle()
                .fill(value.color)
                .onTapGesture {
                    onTap(value)
                }
                .cornerRadius(corner)
            Text("\(value.value)")
                .font(.system(size: textSize))
                .foregroundColor(textColor)
        }.frame(width: size, height: size)
//            .scaleEffect(isPressed ? 0.95 : 1.0)
//            .simultaneousGesture(
//                DragGesture(minimumDistance: 0)
//                    .onChanged { _ in
//                        self.isPressed = true
//                    }
//                    .onEnded { _ in
//                        self.isPressed = false
//                    }
//            )
    }
}

/// 热力图控件
struct HeatmapView: View {

    /// 单元格的大小
    var size: CGFloat = 16
    
    /// 单元格的边角
    var corner: CGFloat = 4
    
    /// 单元格文字大小
    var textSize: CGFloat = 8

    ///单元格文字颜色
    var textColor: Color = .black

    /// 边界文字大小
    var edgeTextSize: CGFloat = 8
    
    /// 边界文字颜色
    var edgeTextColor: Color = .black
    
    /// 单元格之间的间距
    var spacing: CGFloat = 10

    /// 热力图数据
    let values: [[HeatmapView.Value]]

    /// 热力图单元格点击事件
    let onTap: (_ value: HeatmapView.Value) -> Void
    
    var body: some View {
        VStack(spacing: spacing) {
            if values.count > 0 {
                HStack(spacing: spacing) {
                    ForEach(0..<values[0].count, id: \.self) { column in
                        Text(values[0][column].title)
                            .frame(width: size)
                            .font(.system(size: edgeTextSize))
                            .foregroundColor(edgeTextColor)
                    }
                }
            }
            ForEach(0..<values.count, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(0..<values[row].count, id: \.self) { column in
                        HeatmapCell(size: size, 
                                    corner: corner,
                                    textSize: textSize,
                                    textColor: textColor,
                                    value: values[row][column],
                                    onTap: onTap)
                    }
                }
            }
            if values.count > 0 {
                HStack(spacing: spacing) {
                    ForEach(0..<values[values.count - 1].count, id: \.self) { column in
                        Text(values[values.count - 1][column].foot)
                            .frame(width: size)
                            .font(.system(size: edgeTextSize))
                            .foregroundColor(edgeTextColor)
                    }
                }
            }
        }
    }
    
    /// 值
    struct Value {
        /// 数值
        let value: Int
        /// 文字
        let text: String
        /// 颜色
        let color: Color
        /// 标题
        let title: String
        /// 底部标题
        let foot: String
    }
}

struct HeatmapSampleView: View {
    
    var values: [[HeatmapView.Value]] = []
    
    let row = 7
    let col = 100
    
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
        ScrollView(.horizontal) {
            HeatmapView(size: 20, 
                        corner: 4,
                        textSize: 8,
                        textColor: .gray,
                        edgeTextSize: 10,
                        edgeTextColor: .blue,
                        spacing: 2,
                        values: values,
                        onTap: { value in
                print("点击了 \(value.value)")
            })
        }
    }
}

struct HeatmapSampleView_Previews: PreviewProvider {
    static var previews: some View {
        HeatmapSampleView()
    }
}
