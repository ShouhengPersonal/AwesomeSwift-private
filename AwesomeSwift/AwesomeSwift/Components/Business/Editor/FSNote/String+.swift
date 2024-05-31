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
    
    func widthOfString(usingFont font: UIFont, tabs: [NSTextTab]? = nil) -> CGFloat {
        let paragraph = NSMutableParagraphStyle()
        if let tabs = tabs {
            paragraph.tabStops = tabs
        }

        let fontAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.paragraphStyle: paragraph
        ]

        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

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
