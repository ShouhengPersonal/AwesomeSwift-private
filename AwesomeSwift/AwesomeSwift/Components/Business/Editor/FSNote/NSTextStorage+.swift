//
//  CustomTextStorage.swift
//  FSNotes
//
//  Created by Oleksandr Glushchenko on 10/12/18.
//  Copyright © 2018 Oleksandr Glushchenko. All rights reserved.
//

#if os(OSX)
import AppKit
#else
import UIKit
#endif

extension NSTextStorage {
    
    //    这段代码是一个函数，它接收一个URL作为参数，并返回一个`NSRange`对象或者`nil`。函数的作用是在给定的文本范围内查找包含特定URL的文本附件的位置。
    //    让我们一步步来解释代码：
    //    1. `affectedRange` 是一个 `NSRange` 对象，表示了整个文本的范围，从0到文本的长度。
    //    2. `foundRange` 是一个可选的 `NSRange` 对象，用于存储找到的目标范围。
    //    3. `enumerateAttribute` 方法用于在指定范围内枚举文本属性。在这里，我们枚举了 `.attachment` 这个属性，表示文本中的附件。
    //    4. 在枚举的闭包中，首先检查当前范围内的属性是否为 `NSTextAttachment` 类型，并且使用 `attribute` 方法检查该范围是否包含名为 `.todo` 的自定义属性。
    //    5. 如果上述条件都满足，则进一步检查是否存在一个自定义的属性，其键为 `"co.fluder.fsnotes.image.url"`。这个属性应该存储了一个URL。如果这个URL的路径与传入的URL的路径相匹配，则将当前范围设置为 `foundRange`，并终止枚举循环。
    //    6. 最后，函数返回 `foundRange`，它可能是一个有效的范围，也可能是 `nil`，表示没有找到匹配的文本附件。
    //    总体来说，这段代码的作用是在给定文本中查找一个特定的URL对应的文本附件，并返回该文本附件的范围。
    public func getImageRange(url: URL) -> NSRange? {
        let affectedRange = NSRange(0..<length)
        var foundRange: NSRange?

        enumerateAttribute(.attachment, in: affectedRange) { (value, range, stop) in
            if value as? NSTextAttachment != nil, attribute(.todo, at: range.location, effectiveRange: nil) == nil {

                let pathKey = NSAttributedString.Key(rawValue: "co.fluder.fsnotes.image.url")
                if let result = attribute(pathKey, at: range.location, effectiveRange: nil) as? URL, url.path == result.path {

                    foundRange = range
                    stop.pointee = true
                }
            }
        }

        return foundRange
    }

    /// 这里好像主要在处理 todo 标签的逻辑
    public func updateParagraphStyle(range: NSRange? = nil) {
        let scanRange = range ?? NSRange(0..<length)

        if scanRange.length == 0 {
            return
        }

        beginEditing()

        let font = UserDefaultsManagement.noteFont
        let tabs = getTabStops()

        addTabStops(range: scanRange, tabs: tabs)

        let spaceWidth = " ".widthOfString(usingFont: font, tabs: tabs)

        // Todo head indents
        enumerateAttribute(.attachment, in: scanRange, options: .init()) { value, range, _ in
            if attribute(.todo, at: range.location, effectiveRange: nil) != nil {
                let parRange = mutableString.paragraphRange(for: NSRange(location: range.location, length: 0))
                let parStyle = NSMutableParagraphStyle()
                parStyle.headIndent = font.pointSize + font.pointSize / 2 + spaceWidth
                parStyle.lineSpacing = CGFloat(UserDefaultsManagement.editorLineSpacing)
                addAttribute(.paragraphStyle, value: parStyle, range: parRange)
            }
        }

        endEditing()
    }

    /*
     * Implements https://github.com/glushchenko/fsnotes/issues/311
     */
    public func addTabStops(range: NSRange, tabs: [NSTextTab]) {
        var paragraph = NSMutableParagraphStyle()
        let font = UserDefaultsManagement.noteFont

        mutableString.enumerateSubstrings(in: range, options: .byParagraphs) { value, parRange, _, _ in
            var parRange = parRange

            if let value = value,
                value.count > 1,
                value.starts(with: "    ")
                || value.starts(with: "\t")
                || value.starts(with: "* ")
                || value.starts(with: "- ")
                || value.starts(with: "+ ")
                || value.starts(with: "> ")
                || self.getNumberListPrefix(paragraph: value) != nil {

                let prefix = value.getSpacePrefix()
                let checkList = [
                    prefix + "* ",
                    prefix + "- ",
                    prefix + "+ ",
                    prefix + "> ",
                    "* ",
                    "- ",
                    "+ ",
                    "> "
                ]

                var result = String()
                for checkItem in checkList {
                    if value.starts(with: checkItem) {
                        result = checkItem
                        break
                    }
                }

                if let prefix = self.getNumberListPrefix(paragraph: value) {
                    result = prefix
                }

                let width = result.widthOfString(usingFont: font, tabs: tabs)

                paragraph = NSMutableParagraphStyle()
                paragraph.lineSpacing = CGFloat(UserDefaultsManagement.editorLineSpacing)
                paragraph.alignment = .left
                paragraph.headIndent = width
            } else {

                // Fixes new line size (proper line spacing)
                if parRange.length == 0 && parRange.location > 0 {
                    parRange = NSRange(location: parRange.location, length: 1)
                }

                paragraph = NSMutableParagraphStyle()
                paragraph.lineSpacing = CGFloat(UserDefaultsManagement.editorLineSpacing)
                paragraph.alignment = .left
            }

            paragraph.tabStops = tabs

            self.addAttribute(.paragraphStyle, value: paragraph, range: parRange)
        }
    }

    /**
     这段代码定义了一个函数 `getTabStops()`，它返回一个包含了一系列文本标签的数组 `[NSTextTab]`。
     现在来逐步解释代码：
     1. `tabs` 是一个空数组，用于存储生成的文本标签。
     2. `tabInterval` 是一个整数，表示文本标签之间的间隔。在这里，每个文本标签的间隔是 40 个单位。
     3. 使用 `for` 循环，从 1 到 25，生成一系列文本标签。循环的每一次迭代都会创建一个新的 `NSTextTab` 对象，并将其添加到 `tabs` 数组中。
     4. 在每次迭代中，通过 `NSTextTab` 的初始化方法创建一个新的文本标签。这个方法接收三个参数：
        - `textAlignment`：文本对齐方式，这里设置为 `.left`，表示左对齐。
        - `location`：文本标签的位置，通过乘以 `tabInterval` 和当前的循环索引来确定。
        - `options`：这里是一个空字典，表示没有额外的选项。
     5. 每次创建完文本标签后，都将它添加到 `tabs` 数组中。
     6. 最后，函数返回包含所有生成的文本标签的数组 `tabs`。
     总的来说，这段代码的作用是生成一系列具有指定间隔和对齐方式的文本标签，并将它们存储在数组中返回。
     */
    public func getTabStops() -> [NSTextTab] {
        var tabs = [NSTextTab]()
        let tabInterval = 40

        for index in 1...25 {
            let tab = NSTextTab(textAlignment: .left, location: CGFloat(tabInterval * index), options: [:])
            tabs.append(tab)
        }

        return tabs
    }

    /**
     获取数字列表的前缀
     */
    public func getNumberListPrefix(paragraph: String) -> String? {
        var result = String()
        var numberFound = false
        var dotFound = false

        for char in paragraph {
            if char.isWhitespace {
                result.append(char)
                if dotFound && numberFound {
                    return result
                }
                continue
            } else if char.isNumber {
                numberFound = true
                result.append(char)
                continue
            } else if char == "." {
                if !numberFound {
                    return nil
                }
                dotFound = true
                result.append(char)
                continue
            }

            if !numberFound || !dotFound {
                return nil
            }
        }

        return nil
    }
}
