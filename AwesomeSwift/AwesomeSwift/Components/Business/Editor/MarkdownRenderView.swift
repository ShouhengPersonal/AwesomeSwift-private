//
//  MarkdownRenderView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/28.
//

import Foundation
import SwiftUI
import WebKit
import Ink

/// MD 渲染器
struct MarkdownRenderView: UIViewRepresentable {
    
    let md: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webview = WKWebView()
//        let delegate: Delegate = Delegate(webView: webview)
//        webview.navigationDelegate = delegate
//        webview.configuration.userContentController.add(delegate, name: "javascriptLoaded")
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let html = MarkdownParser().parse(md).html
        print("解析的 html：\n\(html)")
        uiView.loadHTMLString(html, baseURL: nil)
    }
}

#Preview(body: {
    MarkdownRenderView(md: MD_SAMPLE_TEXT)
})
