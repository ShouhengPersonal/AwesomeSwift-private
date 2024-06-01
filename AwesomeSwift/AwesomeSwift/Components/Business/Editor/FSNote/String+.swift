//
//  String+.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation
import UIKit

extension String {
    
    func startsWith(string: String) -> Bool {
        guard let range = range(of: string, options: [.caseInsensitive, .diacriticInsensitive]) else {
            return false
        }
        return range.lowerBound == startIndex
    }
    
    func isValidEmail() -> Bool {
        let pattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"

        if let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) {
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }

        return false
    }

    var isValidUUID: Bool {
        return UUID(uuidString: self) != nil
    }
    
    func isHexColor() -> Bool {
        return self.count == 6 && self.allSatisfy({ $0.isHexDigit })
    }
    
    var isWhitespace: Bool {
        guard !isEmpty else { return true }

        let whitespaceChars = NSCharacterSet.whitespacesAndNewlines

        return self.unicodeScalars
            .filter { (unicodeScalar: UnicodeScalar) -> Bool in !whitespaceChars.contains(unicodeScalar) }
            .count == 0
    }

    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

    var isContainsLetters: Bool {
        let letters = CharacterSet.letters
        return self.rangeOfCharacter(from: letters) != nil
    }

//    var withoutSpecialCharacters: String {
//        return self.components(separatedBy: CharacterSet.alphanumerics.inverted).joined(separator: " ")
//                .condenseWhitespace()
//    }
    
    /**
     这个函数的名称是 `widthOfString(usingFont:tabs:)`，它计算了给定字符串的宽度，使用了指定的字体和可选的文本标签数组。

     现在让我逐步解释代码：

     1. 创建一个 `NSMutableParagraphStyle` 对象 `paragraph`，用于定义文本的排版样式。

     2. 如果参数 `tabs` 不为 `nil`，即传入了文本标签数组，就将这些标签设置为 `paragraph` 的 `tabStops` 属性。

     3. 创建一个字体属性字典 `fontAttributes`，其中包含了字体和段落样式。

     4. 使用 `self.size(withAttributes:)` 方法计算了使用指定字体和段落样式的字符串的尺寸。`self` 表示调用这个函数的字符串本身。

     5. 最后，返回了计算出的字符串的宽度。

     总的来说，这个函数的作用是计算给定字符串在指定字体和排版样式下的宽度。如果提供了文本标签数组，则还考虑了标签的影响。
     */
    func widthOfString(usingFont font: UIFont, tabs: [NSTextTab]? = nil) -> CGFloat {
        let paragraph = NSMutableParagraphStyle()
        if let tabs = tabs {
            /**
             表示段落制表位的文本制表对象。
             NSTextTab对象按位置排序，定义段落样式的制表位。默认值是一个数组，包含12个左对齐的选项卡，间隔28点。
             */
            paragraph.tabStops = tabs
        }

        let fontAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: paragraph
        ]

        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    //    这个函数名叫 `getSpacePrefix()`，它返回一个包含了空格和制表符前缀的字符串。
    //
    //    现在让我逐步解释代码：
    //
    //    1. `prefix` 是一个空字符串，用于存储空格和制表符的前缀。
    //
    //    2. 使用 `for-in` 循环遍历字符串的 Unicode 标量（unicodeScalars）。这使得我们可以逐个处理字符串中的字符。
    //
    //    3. 在循环中，对于每个字符 `char`：
    //       - 如果字符是制表符（"\t"）或空格（" "），则将其追加到 `prefix` 中。
    //       - 如果字符不是制表符或空格，说明前缀已经结束，跳出循环。
    //
    //    4. 循环结束后，函数返回存储了空格和制表符前缀的字符串 `prefix`。
    //
    //    总体来说，这个函数的作用是从一个字符串中提取出开头的空格和制表符，并返回它们作为一个字符串。
    func getSpacePrefix() -> String {
        var prefix = String()
        for char in unicodeScalars {
            if char == "\t" || char == " " {
                prefix += String(char)
            } else {
                break
            }
        }
        return prefix
    }

    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}

extension StringProtocol where Index == String.Index {
    public func nsRange(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}
