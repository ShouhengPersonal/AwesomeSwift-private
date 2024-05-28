//
//  RichEditorDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/28.
//

import Foundation
import SwiftUI
import RichEditorView

/// RichEditorView 示例
struct RichEditorDemoView: View {
    
    @State var bold: Bool = false
    
    @State var italic: Bool = false

    @State var alignCenter: Bool = false

    @State var alignLeft: Bool = false

    @State var alignRight: Bool = false

    @State var blockquote: Bool = false
    
    @State var header3: Bool = false
    
    var body: some View {
        ScrollView(content: {
            VStack {
                HStack {
                    Button("bold") {
                        self.bold.toggle()
                    }
                    Button("italic") {
                        self.italic.toggle()
                    }
                    Button("alignCenter") {
                        self.alignCenter.toggle()
                    }
                    Button("alignLeft") {
                        self.alignLeft.toggle()
                    }
                    Button("alignRight") {
                        self.alignRight.toggle()
                    }
                    Button("blockquote") {
                        self.blockquote.toggle()
                    }
                    Button("header3") {
                        self.header3.toggle()
                    }
                }.frame(height: 50)
                SwiftRichEditorView(bold: $bold,
                                    italic: $italic,
                                    alignCenter: $alignCenter,
                                    alignLeft: $alignLeft,
                                    alignRight: $alignRight,
                                    blockquote: $blockquote,
                                    header3: $header3)
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height/2)
                    .background(Rectangle().fill(.gray))
            }
        })//.ignoresSafeArea(.all)
    }
    
}

struct SwiftRichEditorView: UIViewRepresentable {
    
    @Binding var bold: Bool
    
    @Binding var italic: Bool

    @Binding var alignCenter: Bool

    @Binding var alignLeft: Bool

    @Binding var alignRight: Bool

    @Binding var blockquote: Bool
    
    @Binding var header3: Bool

    func updateUIView(_ uiView: RichEditorView, context: Context) {
        if bold {
            uiView.bold()
        }
        if italic {
            uiView.italic()
        }
        if alignCenter {
            uiView.alignCenter()
        }
        if alignLeft {
            uiView.alignLeft()
        }
        if alignRight {
            uiView.alignRight()
        }
        if blockquote {
            uiView.blockquote()
        }
        if header3 {
            uiView.header(3)
        }
    }
    
    func makeUIView(context: Context) -> RichEditorView {
        let view = RichEditorView()
        return view
    }
}

#Preview {
    RichEditorDemoView()
}
