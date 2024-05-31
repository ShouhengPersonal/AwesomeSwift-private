//
//  EditorSelectionRect.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation
import UIKit

class EditorSelectionRect: UITextSelectionRect {
    private let original: UITextSelectionRect
    private var customRect: CGRect? = nil

    override var rect: CGRect {
        if let customRect = customRect {
            return customRect
        }

        return original.rect
    }

    override var writingDirection: NSWritingDirection {
        return original.writingDirection
    }

    override var containsStart: Bool {
        return original.containsStart
    }

    override var containsEnd: Bool {
        return original.containsEnd
    }

    override var isVertical: Bool {
        return original.isVertical
    }

    init(originalRect original: UITextSelectionRect, rect: CGRect) {
        self.original = original
        self.customRect = rect
    }
}
