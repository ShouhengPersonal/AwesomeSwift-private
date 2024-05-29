//
//  DropdownEntranceView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/29.
//

import Foundation
import SwiftUI

struct DropdownEntranceView: View {
    var body: some View {
        VStack(spacing: 15) {
            NavigationLink("自定义 Dropdown 示例", destination: {
                DropdownDemoView()
            })
            NavigationLink("开源 Dropdown 示例", destination: {
                DropdownDemoView2()
            })
        }
    }
}

#Preview {
    DropdownEntranceView()
}
