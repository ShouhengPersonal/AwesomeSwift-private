//
//  EditorDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/28.
//

import Foundation
import SwiftUI

/// 编辑器示例
struct EditorDemoView: View {
    var body: some View {
        VStack(spacing: 15) {
            NavigationLink("基于 RichEditorView 的编辑器", destination: {
                RichEditorDemoView()
            })
            NavigationLink("基于 MarkdownTextView 的编辑器") {
                MarkdownTextViewDemo()
            }
            NavigationLink("基于 Ink 的渲染") {
                MarkdownRenderView(md: MD_SAMPLE_TEXT)
            }
            NavigationLink("Highlightr 示例") {
                if #available(iOS 15, *) {
                    HighlightrDemoView()
                } else {
                    Text("Unavilable on device below 15.0")
                }
            }
            NavigationLink("CodeEditor 示例") {
                CodeEditorDemoView()
            }
        }
    }
}

#Preview {
    EditorDemoView()
}
