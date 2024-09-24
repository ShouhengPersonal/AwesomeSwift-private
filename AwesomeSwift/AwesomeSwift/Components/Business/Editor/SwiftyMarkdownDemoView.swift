//
//  SwiftyMarkdownDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/9/24.
//

import Foundation
import SwiftyMarkdown
import SwiftUI

struct SwiftyMarkdownDemoView: View {
    
    private let text: NSAttributedString
    
    init() {
        let md = SwiftyMarkdown(string: """
*italics* or _italics_
**bold** or __bold__
~~Linethrough~~Strikethroughs.
`code`

# Header 1

or

Header 1
====

## Header 2

or

Header 2
---

### Header 3
#### Header 4
##### Header 5 #####
###### Header 6 ######

    Indented code blocks (spaces or tabs)

[Links](http://voyagetravelapps.com/)
![Images](<Name of asset in bundle>)

[Referenced Links][1]
![Referenced Images][2]

[1]: http://voyagetravelapps.com/
[2]: <Name of asset in bundle>

> Blockquotes

- Bulleted
- Lists
    - Including indented lists
        - Up to three levels
- Neat!

1. Ordered
1. Lists
    1. Including indented lists
        - Up to three levels
""")
        md.h3.fontSize = 16
        md.h2.fontSize = 17
        md.h1.fontSize = 18
        md.h1.fontStyle = .bold
        md.body.fontSize = 15
        self.text = md.attributedString()
    }
    
    var body: some View {
        VStack {
            AttributedStringView(attributedString: text)
        }
    }
}

#Preview {
    SwiftyMarkdownDemoView()
}

struct AttributedStringView: UIViewRepresentable {
    let attributedString: NSAttributedString

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0 // 允许多行显示
        label.attributedText = attributedString
        label.textColor = .gray
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.attributedText = attributedString
    }
}
