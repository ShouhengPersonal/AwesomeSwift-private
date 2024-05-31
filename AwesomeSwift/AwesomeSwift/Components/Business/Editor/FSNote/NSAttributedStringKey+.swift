//
//  NSAttributedStringKey+.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation

public extension NSAttributedString.Key {
    
    static var todo: NSAttributedString.Key {
        return NSAttributedString.Key(rawValue: "co.fluder.fsnotes.image.todo")
    }

    static var tag: NSAttributedString.Key {
        return NSAttributedString.Key(rawValue: "es.fsnot.attributed.tag")
    }

    static var yamlBlock: NSAttributedString.Key {
        return NSAttributedString.Key(rawValue: "es.fsnot.yaml")
    }
    
}
