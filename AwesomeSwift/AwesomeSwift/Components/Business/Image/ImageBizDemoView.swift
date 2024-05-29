//
//  ImageBizDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/29.
//

import Foundation
import SwiftUI

/// 图片业务 demo
struct ImageBizDemoView: View {
    var body: some View {
        VStack(spacing: 15) {
            NavigationLink("基于 ImageViewer 的图片展示", destination: {
                ImageViewerDemoView()
            })
        }
    }
}

#Preview {
    ImageBizDemoView()
}
