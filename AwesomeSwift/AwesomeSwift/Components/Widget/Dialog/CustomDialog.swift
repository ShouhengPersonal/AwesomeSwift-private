//
//  CustomDialog.swift
//  englishdog
//
//  Created by shouh wang on 2024/4/30.
//

import Foundation
import SwiftUI

/// Custom dialog global config.
struct CustomDialogConfig {
    
    static let DEFAULT_DIALOG_MARGIN: CGFloat = 30

}

/// Custom dialog.
struct CustomDialog<DialogContent: View>: ViewModifier {

    @Binding private var isShowing: Bool // set this to show/hide the dialog
    private let dialogContent: DialogContent
    private let dialogMargin: CGFloat
    private let outCancelable: Bool
    @State private var offset: CGFloat = 1000

    init(
        isShowing: Binding<Bool>,
        dialogMargin: CGFloat = CustomDialogConfig.DEFAULT_DIALOG_MARGIN,
        outCancelable: Bool = true,
        @ViewBuilder dialogContent: () -> DialogContent
    ) {
        _isShowing = isShowing
        self.dialogMargin = dialogMargin
        self.outCancelable = outCancelable
        self.dialogContent = dialogContent()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                Rectangle().foregroundColor(Color.black.opacity(0.5))
                    .ignoresSafeArea(.all)
                    .onTapGesture {
                        if outCancelable {
                            close()
                        }
                    }
            }
            ZStack {
                dialogContent
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color.white))
                    .onTapGesture {
                        
                    }
            }.padding(dialogMargin)
                .offset(x: 0, y: offset)
        }.onChange(of: isShowing) { newValue in
            withAnimation(.spring()) {
                if newValue {
                    self.offset = 0
                } else {
                    self.offset = 1000
                }
            }
        }
    }
    
    private func close() {
        withAnimation(.spring()) {
            self.isShowing = false
//            offset = 1000
        }
    }
}

extension View {
    func customDialog<DialogContent: View>(
        isShowing: Binding<Bool>,
        dialogMargin: CGFloat = CustomDialogConfig.DEFAULT_DIALOG_MARGIN,
        outCancelable: Bool = true,
        @ViewBuilder dialogContent: @escaping () -> DialogContent
    ) -> some View {
        self.modifier(
            CustomDialog(
                isShowing: isShowing,
                dialogMargin: dialogMargin,
                outCancelable: outCancelable,
                dialogContent: dialogContent
            )
        )
    }
}

struct CustomDialog_Previews: PreviewProvider {
    
    @State private static var isShowing: Bool = true
    
    static var previews: some View {
        VStack {
            ZStack {
                
            }.customDialog(isShowing: CustomDialog_Previews.$isShowing, dialogMargin: 50) {
                    Color(.white)
            }.frame(height: UIScreen.main.bounds.height/3)
            ZStack {
                
            }.customDialog(isShowing: CustomDialog_Previews.$isShowing, dialogMargin: 30) {
                    Color(.white)
            }.frame(height: UIScreen.main.bounds.height/3)
            ZStack {
                
            }.customDialog(isShowing: CustomDialog_Previews.$isShowing) {
                    Color(.white)
            }.frame(height: UIScreen.main.bounds.height/3)
        }
    }
}
