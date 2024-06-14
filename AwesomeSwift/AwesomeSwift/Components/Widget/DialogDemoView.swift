//
//  DialogDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/6/13.
//

import Foundation
import SwiftUI

struct DialogDemoView: View {

    @State var isActive: Bool = false

    @State var isActiveV2: Bool = false

    var body: some View {
        ZStack {
            VStack {
                Button {
                    isActive = true
                } label: {
                    Text("显示自定义对话框")
                        .padding(10)
                }
                Button {
                    isActiveV2 = true
                } label: {
                    Text("显示自定义对话框 V2")
                        .padding(10)
                }
            }
            .padding()

            if isActiveV2 {
                if #available(iOS 15.0, *) {
                    CustomDialogV2(isActive: $isActiveV2,
                                   title: "Access photos?",
                                   message: "This lets you choose which photos you want to add to this project.",
                                   buttonTitle: "Give Access") {
                        print("Pass to viewModel")
                    }
                }
            }
        }.customDialog(isShowing: $isActive) {
            VStack {
                Text("Access photos?")
                    .font(.title2)
                    .bold()
                    .padding()
                Text("This lets you choose which photos you want to add to this project.")
                    .font(.body)
                Button {
                    self.isActive = false
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.red)
                        Text("Give Access")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .padding()
                }
            }.fixedSize(horizontal: false, vertical: true)
        }
    }
}

#Preview {
    DialogDemoView()
}
