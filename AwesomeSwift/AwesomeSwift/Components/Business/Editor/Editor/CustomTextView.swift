//
//  CustomTextView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation
import UIKit

class CustomTextView: UITextView, UITextViewDelegate {

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
    
    // 询问委托是否替换文本视图中的指定文本。
    //    参数
    //    textView
    //    包含更改的文本视图。
    //
    //    range
    //    当前选择范围。如果范围长度为0，则范围反映当前插入点。如果用户按下Delete键，则该范围的长度为1，并用一个空字符串对象替换该单个字符。
    //
    //    text
    //    要插入的文本。
    //
    //    返回值
    //    如果旧文本应该被新文本取代，则为True;如果替换操作应该中止，则为False。
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("on textView:\nshouldChangeTextIn: \(range)\ntext:\(text)")
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
