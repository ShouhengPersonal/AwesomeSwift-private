//
//  UITextView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation
import UIKit

extension UITextView {
    
    /// 这段代码用于计算 UITextView 中光标位置的偏移量（即光标距离文档开头的字符数）。具体来说，它做了以下几件事情：
    /// 1. 首先，它检查是否已经选择了文本范围（selectedTextRange）。
    /// 2. 如果没有选择文本范围，则返回 nil。
    /// 3. 如果已经选择了文本范围，则计算文档开头到光标起始位置的偏移量，并返回该值。
    /// 这段代码中的 selectedTextRange 是 UITextView 的属性，表示当前选中的文本范围。offset(from:to:) 是 UITextView 的方法，用于计算两个文本位置之间的字符偏移量。在这里，它用于计算光标起始位置相对于文档开头的偏移量。
    /// 因此，cursorOffset 属性将返回一个可选的整数值，表示光标的偏移量。如果没有选择文本范围，则返回 nil。
    var cursorOffset: Int? {
        guard let range = selectedTextRange else { return nil }
        return offset(from: beginningOfDocument, to: range.start)
    }

    /// 这段代码的作用是获取 UITextView 中光标当前所在位置对应的 String.Index，即光标所在的文本位置。
    /// 具体来说，它做了以下几件事情：
    /// 1. 首先，它检查是否已经计算了光标的偏移量（cursorOffset）。
    /// 2. 如果没有计算光标的偏移量，则返回 `nil`。
    /// 3. 接着，它计算了文本长度与光标偏移量之间的差值，表示从光标位置到文本末尾的长度。
    /// 4. 然后，它尝试通过光标位置和长度来创建一个 NSRange 对象。
    /// 5. 最后，它使用 `Range(_:in:)` 方法将 NSRange 转换为 String.Index，表示光标位置在文本中的具体位置。
    /// 总的来说，`cursorIndex` 属性返回一个可选的 String.Index，表示 UITextView 中光标当前所在位置对应的文本位置。如果无法计算光标位置，则返回 `nil`。
    var cursorIndex: String.Index? {
        guard
            let location = cursorOffset,
            case let length = text.utf16.count - location
        else { return nil }
        return Range(.init(location: location, length: length), in: text)?.lowerBound
    }

    /// 这段代码的作用是计算 UITextView 中光标距离文本开头的字符距离。
    /// 具体来说，它做了以下几件事情：
    /// 1. 首先，它检查是否已经计算了光标的 String.Index（即 cursorIndex）。
    /// 2. 如果没有计算光标的 String.Index，则返回 `nil`。
    /// 3. 接着，它使用 `text.distance(from:to:)` 方法计算文本开头（text.startIndex）到光标位置（cursorIndex）的字符距离。
    /// 最终，`cursorDistance` 属性返回一个可选的整数值，表示 UITextView 中光标距离文本开头的字符数。如果无法计算光标位置，则返回 `nil`。
    var cursorDistance: Int? {
        guard let cursorIndex = cursorIndex else { return nil }
        return text.distance(from: text.startIndex, to: cursorIndex)
    }
    
    /// 这段代码的作用是获取 UITextView 中当前选择的文本范围，返回一个 `UITextRange` 对象。
    /// 具体来说，它做了以下几件事情：
    /// 1. 首先，它使用 `position(from:offset:)` 方法从文档的开头（`beginningOfDocument`）计算出选中文本的起始位置。如果成功计算出起始位置，则将其赋给 `start` 变量。
    /// 2. 接着，它使用 `position(from:offset:)` 方法从起始位置（`start`）计算出选中文本的结束位置，其偏移量为选中文本的长度。如果成功计算出结束位置，则将其赋给 `end` 变量。
    /// 3. 然后，它使用 `textRange(from:to:)` 方法根据起始位置和结束位置创建一个 `UITextRange` 对象，表示选中的文本范围。
    /// 4. 最后，如果成功创建了 `UITextRange` 对象，则返回该对象；否则返回 `nil`。
    /// 总的来说，`getTextRange()` 方法返回一个 `UITextRange` 对象，表示 UITextView 中当前选择的文本范围。如果无法计算选中文本范围，则返回 `nil`。
    public func getTextRange() -> UITextRange? {
        if let start = position(from: self.beginningOfDocument, offset: self.selectedRange.location),
        let end = position(from: start, offset: self.selectedRange.length),
        let selectedRange = textRange(from: start, to: end) {
            return selectedRange
        }
        return nil
    }
}
