//
//  CustomEditorView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation
import SwiftUI
import UIKit

struct CustomEditorView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> CustomTextView {
        let ctv: CustomTextView = CustomTextView()
        initEditorStyles(ctv: ctv)
        initEditorProperties(context: context, ctv: ctv)
        return ctv
    }
    
    private func initEditorStyles(ctv: CustomTextView) {
        // 一个整数位掩码，它决定了当父视图的边界改变时接收器如何调整自身大小。
        ctv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // 一个标志，用于确定视图在其边界改变时如何布局其内容。
        ctv.contentMode = .scaleToFill

        ctv.isScrollEnabled = true   // causes expanding height

        // 文本容器内最后一行的行为。
        ctv.textContainer.lineBreakMode = .byWordWrapping
        
        // Auto Layout
        // 一个布尔值，用于确定视图的自动调整大小掩码是否转换为自动布局约束。
        ctv.translatesAutoresizingMaskIntoConstraints = false
        // 文本的字体。
        ctv.font = UIFont(name: "HelveticaNeue", size: 18)
        
        // 基于文本的视图的自动更正行为。
        ctv.autocorrectionType = UserDefaultsManagement.editorAutocorrection ? .yes : .no
        // 文本对象的拼写检查样式。
        ctv.spellCheckingType = UserDefaultsManagement.editorSpellChecking ? .yes : .no
        
        initLinksColor(ctv: ctv)
        
        // 键盘
        if ctv.traitCollection.userInterfaceStyle == .dark {
            ctv.keyboardAppearance = .dark
        } else {
            ctv.keyboardAppearance = .default
        }
        
        ctv.indicatorStyle = (ctv.traitCollection.userInterfaceStyle == .dark) ? .white : .black
        // 暂时显示滚动指示器。当你把滚动视图放到前面时，你应该调用这个方法。
        ctv.flashScrollIndicators()
    }
    
    private func initEditorProperties(context: Context, ctv: CustomTextView) {
//        let processor = CustomTextStorageProcessor()
        ctv.textStorage.delegate = context.coordinator

        ctv.delegate = ctv
    }
    
    func initLinksColor(ctv: CustomTextView) {

        var linkAttributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.linksColor
        ]

        linkAttributes[.underlineColor] = UIColor.lightGray
        linkAttributes[.underlineStyle] = 0
        
        ctv.linkTextAttributes = linkAttributes
    }
    
    func updateUIView(_ uiView: CustomTextView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, NSTextStorageDelegate {
        
        func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
            print("on textStorage:\n textStorage: \(textStorage)\nrange: \(editedRange)\nchangeInLength:\(delta)")
            
            guard editedMask != .editedAttributes else { return }
            NotesTextProcessor.highlightMarkdown(attributedString: textStorage)
            NotesTextProcessor.highlightFencedAndIndentCodeBlocks(attributedString: textStorage)
        }
    }
}
