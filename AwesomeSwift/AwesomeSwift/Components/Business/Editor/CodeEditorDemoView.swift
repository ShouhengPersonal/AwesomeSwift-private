//
//  CodeEditorDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/29.
//

import Foundation
import SwiftUI
import CodeEditor

/// CodeEditor 示例
struct CodeEditorDemoView: View {
    
    @State private var source = """
            private var content: AttributedString {
                let string = "Attributed String"
                let attributes: [NSAttributedString.Key : Any] = [
                    NSAttributedString.Key.foregroundColor: UIColor.systemPink,
                    NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 40),
                    NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
                ]
                // 1
                let nsAttributedString = NSAttributedString(string: string, attributes: attributes)

                // 2
                let attributedString = AttributedString(nsAttributedString)

                return attributedString
            }

            var body: some View {
                // 3
                Text(content)

            }
            """
    
    var body: some View {
        VStack {
            CodeEditor(source: $source, language: .swift, theme: .ocean)
        }
    }
}

#Preview {
    CodeEditorDemoView()
}
