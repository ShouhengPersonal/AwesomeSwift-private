//
//  CustomEditorDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation
import SwiftUI

struct CustomEditorDemoView: View {
    
    @State var canUndo: Bool = false
    @State var canRedo: Bool = false
        
    var body: some View {
        ScrollView {
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.left")
                            .frame(width: 40, height: 40)
                            .opacity(canUndo ? 1 : 0.5)
                            .onTapGesture {
                                canUndo = findButtonInSubviews(of: UIApplication.shared.windows.first)?.undo() == true
                            }
                        Image(systemName: "arrowshape.turn.up.right")
                            .frame(width: 40, height: 40)
                            .opacity(canRedo ? 1 : 0.5)
                            .onTapGesture {
                                canRedo = findButtonInSubviews(of: UIApplication.shared.windows.first)?.redo() == true
                            }
                    }
                }
                CustomEditorView().border(.black)
            }
        }
    }
    
    private func findButtonInSubviews(of view: UIView?) -> CustomTextView? {
          guard let view = view else { return nil }
          if let ctv = view as? CustomTextView {
              return ctv
          }
          for subview in view.subviews {
              if let ctv = findButtonInSubviews(of: subview) {
                  return ctv
              }
          }
          return nil
      }
}

#Preview {
    CustomEditorDemoView()
}
