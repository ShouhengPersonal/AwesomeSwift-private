//
//  MarkdownKitDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/11/23.
//

import Foundation
import SwiftUI
import MarkdownKit

struct MarkdownKitDemoView: View {
    
    private let text: NSAttributedString
    
    init() {
        let markdownParser = MarkdownParser(
            font: UIFont.italicSystemFont(ofSize: 16)
        )
        markdownParser.enabledElements = .disabledAutomaticLink
        markdownParser.bold.color = UIColor.black
        markdownParser.italic.font = UIFont.italicSystemFont(ofSize: 300)
        markdownParser.header.font = UIFont.systemFont(ofSize: 18)
        markdownParser.header.fontIncrease = 1
        let markdown = """
## Title 1
## Title 2
### 语法改进意见：\n\n1. **句子结构**：\n   - 第一句可以简化为：“I think this feature is helpful for those who want to learn English more effectively.”\n   - “Since” 和 “in my opinion” 可以合并成一个更简洁的表达：“In my opinion, the best way to learn a language is to use it in daily life.”\n\n2. **连贯性**：\n   - “By writing articles, we could find out grammar issues when speaking English.” 可以改为：“By writing articles, we can identify grammar issues that arise when speaking English.”\n   - “Also, the more we write, the more it helps when we talk with in English.” 中的“talk with in English” 应该改为“talk in English”。\n\n3. **逻辑连接**：\n   - “Cause we don’t need to think which word to pick, since we already did it many times.” 可以改为：“This is because we don’t need to think about which words to choose, as we have already done it many times.”\n\n### 改进后的文章：\n\nI think this feature is helpful for those who want to learn English more effectively. In my opinion, the best way to learn a language is to use it in daily life. By writing articles, we can identify grammar issues that arise when speaking English. Additionally, the more we write, the more it helps when we talk in English. This is because we don’t need to think about which words to choose, as we have already done it many times.\n\n### 用词准确性需要提高的地方：\n\n1. **“could” vs. “can”**：\n   - “we could find out grammar issues” 可以改为“we can identify grammar issues”，因为这里是在描述当前的能力，而不是假设的情况。\n\n2. **“talk with in English”**：\n   - 这个短语不正确，应该改为“talk in English”。\n\n3. **“Cause”**：\n   - “Cause” 是口语化的表达，正式写作中应使用“Because”。\n\n4. **“which word to pick”**：\n   - “which word to pick” 可以改为“which words to choose”，更加正式和准确。\n\n通过这些改进，文章的语法和用词将更加准确和流畅。"
"""
        self.text = markdownParser.parse(markdown)
    }
    
    var body: some View {
        ScrollView {
            if #available(iOS 15, *) {
                Text(AttributedString(text))
//                    .font(.system(size: 16))
            } else {
                AttributedStringView(attributedString: text)
            }
        }
    }
}

#Preview {
    MarkdownKitDemoView()
}
