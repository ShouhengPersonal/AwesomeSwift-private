//
//  HighlightrDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/28.
//

import Foundation
import SwiftUI
import Highlightr

/// Highlightr Demo
@available(iOS 15, *)
struct HighlightrDemoView: View {
    
    @State
    var text: AttributedString = AttributedString("")
    
    var body: some View {
        ScrollView(content: {
            VStack {
                Text(text)
                    .padding(15)
                Spacer()
            }
        }).onAppear {
            let highlightr = Highlightr()
            highlightr?.setTheme(to: "paraiso-dark")
            let code = """
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
            // You can omit the second parameter to use automatic language detection.
            let highlightedCode = highlightr?.highlight(code, as: "swift")
            text = AttributedString(highlightedCode ?? NSAttributedString())
            print("Highlightr text: \(String(describing: text)) \(String(describing: highlightedCode))")
        }
    }
}

//struct HighlightrView: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> Highlightr {
//        let highlightr = Highlightr()
//        highlightr.setTheme(to: "paraiso-dark")
//        let code = "let a = 1"
//        // You can omit the second parameter to use automatic language detection.
//        let highlightedCode = highlightr.highlight(code, as: "swift")
//        return highlightr
//    }
//
//    func updateUIView(_ uiView: Highlightr, context: Context) {
//
//    }
//}

#Preview {
    if #available(iOS 15, *) {
        HighlightrDemoView()
    } else {
        Text("Unavilable on device below 15.0")
    }
}
