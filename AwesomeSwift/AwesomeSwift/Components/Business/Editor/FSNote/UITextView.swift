//
//  UITextView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation
import UIKit

extension UITextView {
    var cursorOffset: Int? {
        guard let range = selectedTextRange else { return nil }
        return offset(from: beginningOfDocument, to: range.start)
    }

    var cursorIndex: String.Index? {
        guard
            let location = cursorOffset,
            case let length = text.utf16.count-location
        else { return nil }
        return Range(.init(location: location, length: length), in: text)?.lowerBound
    }

    var cursorDistance: Int? {
        guard let cursorIndex = cursorIndex else { return nil }
        return text.distance(from: text.startIndex, to: cursorIndex)
    }
    
    public func getTextRange() -> UITextRange? {
        if let start = position(from: self.beginningOfDocument, offset: self.selectedRange.location),
        let end = position(from: start, offset: self.selectedRange.length),
        let selectedRange = textRange(from: start, to: end) {
            return selectedRange
        }

        return nil
    }
}
