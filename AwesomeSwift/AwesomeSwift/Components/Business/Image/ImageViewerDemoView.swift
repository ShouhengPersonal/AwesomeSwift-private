//
//  ImageViewerDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/29.
//

import Foundation
import SwiftUI
import ImageViewer_swift

/// 图片业务 demo
/// 缺点：基于 uikit 开发，对 swiftui 支持不好
struct ImageViewerDemoView: View {
    var body: some View {
        ImageViewerSwiftUIView()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .border(.black)
    }
}

struct ImageViewerSwiftUIView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.setupImageViewer(urls: image_urls)
        imageView.image = R.image.christmas_star()!
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        
    }
}

let image_urls = [
    URL(string: "https://plus.unsplash.com/premium_photo-1676517030094-3a49a6d598e6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8")!,
    URL(string: "https://images.unsplash.com/photo-1714139797690-969497e4a65e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwyfHx8ZW58MHx8fHx8")!,
    URL(string: "https://images.unsplash.com/photo-1716393763723-64e389f248fc?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0fHx8ZW58MHx8fHx8")!,
    URL(string: "https://images.unsplash.com/photo-1716224835882-ba9133a9d407?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8")!,
    URL(string: "https://images.unsplash.com/photo-1716872491340-4626a22c582d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHx8")!,
    URL(string: "https://plus.unsplash.com/premium_photo-1681488007344-c75b0cf8b0cd?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHx8")!,
    URL(string: "https://images.unsplash.com/photo-1716903778207-445ce0f12820?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3fHx8ZW58MHx8fHx8")!,
    URL(string: "https://plus.unsplash.com/premium_photo-1675230484346-9d58ce1f43a1?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw5fHx8ZW58MHx8fHx8")!,
    URL(string: "https://images.unsplash.com/photo-1716872491897-078d9b89be49?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxMnx8fGVufDB8fHx8fA%3D%3D")!,
    URL(string: "https://plus.unsplash.com/premium_photo-1715876268512-39d694143a8e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxM3x8fGVufDB8fHx8fA%3D%3D")!,
    URL(string: "https://images.unsplash.com/photo-1716835457716-0e879b88c774?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNHx8fGVufDB8fHx8fA%3D%3D")!,
    URL(string: "https://images.unsplash.com/photo-1716668595976-604426108db1?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxNnx8fGVufDB8fHx8fA%3D%3D")!
]

#Preview {
    ImageViewerDemoView()
}
