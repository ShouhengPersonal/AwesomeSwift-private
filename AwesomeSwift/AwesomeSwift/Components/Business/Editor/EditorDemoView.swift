//
//  EditorDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/28.
//

import Foundation
import SwiftUI

/// 编辑器示例
struct EditorDemoView: View {
    var body: some View {
        VStack {
            NavigationLink("RichEditorDemoView", destination: {
                RichEditorDemoView()
            })
        }
    }
}

#Preview {
    EditorDemoView()
}
