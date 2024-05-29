//
//  DropdownDemoView2.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/29.
//

import Foundation
import SwiftUI
import DropDown

struct DropdownDemoView2: View {
    
    @State var show: Bool = false
    
    var body: some View {
        VStack {
            DropDownSwiftUIView(show: $show)
                .frame(width: 100, height: 50)
            Button(action: {
                self.show.toggle()
            }, label: {
                Text("Show Drop down")
            })
        }.onAppear(perform: {
            DropDown.startListeningToKeyboard()
        })
    }
}

struct DropDownSwiftUIView: UIViewRepresentable {
    
    @Binding var show: Bool
    
    var dropDown = DropDown()
    
    func makeUIView(context: Context) -> UITextView {
        let text = UITextView()
        text.text = "Show Drop down Show Drop down Show Drop down"
//        let dropDown = DropDown()
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
        dropDown.selectionAction = { (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
        }
        dropDown.anchorView = text
        dropDown.width = 200
        return text
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if show {
            dropDown.show()
        }
    }
}

#Preview {
    DropdownDemoView2()
}
