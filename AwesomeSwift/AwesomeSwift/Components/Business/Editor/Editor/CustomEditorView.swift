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
        ctv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        ctv.contentMode = .scaleToFill

        ctv.isScrollEnabled = false   // causes expanding height

        // Auto Layout
        ctv.translatesAutoresizingMaskIntoConstraints = false
        ctv.font = UIFont(name: "HelveticaNeue", size: 18)
        
        ctv.autocorrectionType = UserDefaultsManagement.editorAutocorrection ? .yes : .no
        ctv.spellCheckingType = UserDefaultsManagement.editorSpellChecking ? .yes : .no
        
        initLinksColor(ctv: ctv)
        
        // 键盘
        if ctv.traitCollection.userInterfaceStyle == .dark {
            ctv.keyboardAppearance = .dark
        } else {
            ctv.keyboardAppearance = .default
        }
        
        ctv.indicatorStyle = (ctv.traitCollection.userInterfaceStyle == .dark) ? .white : .black
        ctv.flashScrollIndicators()
        
        return ctv
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
}
