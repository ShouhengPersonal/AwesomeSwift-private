//
//  CustomTextView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation
import UIKit

class CustomTextView: UITextView, UITextViewDelegate {
    
    let note = Note()
    
    func undo() -> Bool {
        self.undoManager?.undo()
        return self.undoManager?.canUndo == true
    }
    
    func redo() -> Bool {
        self.undoManager?.redo()
        return self.undoManager?.canRedo == true
    }
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        print("selectionRects")
        return super.selectionRects(for: range)
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        print("caretRect")
        return super.caretRect(for: position)
    }
    
    override func scrollRectToVisible(_ rect: CGRect, animated: Bool) {
        print("scrollRectToVisible")
        return super.scrollRectToVisible(rect, animated: animated)
    }
    
    override func cut(_ sender: Any?) {
        print("cut")
    }
    
    override func paste(_ sender: Any?) {
        print("paste")
    }
    
    override func copy(_ sender: Any?) {
        print("copy")
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        print("canPerformAction")
        return super.canPerformAction(action, withSender: sender)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("textView")
        
        // New line
//        if text == "\n" {
//            let formatter = TextFormatter(textView: textView, note: note)
//            formatter.newLine()
//
//            return false
//        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        print("textViewDidChangeSelection")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("textViewDidChange")
    }
}
