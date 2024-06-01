//
//  CustomEditorDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation
import SwiftUI

// 编辑器示例
struct CustomEditorDemoView: View {
    
    @State var canUndo: Bool = false
    @State var canRedo: Bool = false
        
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                options
            }
            ScrollView {
                CustomEditorView()
                    .frame(minHeight: 400)
                    .frame(width: UIScreen.main.bounds.width)
                    .border(.black)
            }
        }
    }
    
    private var options: some View {
        HStack {
            Button(action: {
                canUndo = find(of: UIApplication.shared.windows.first)?.undo() == true
            }, label: {
                Image(systemName: "arrowshape.turn.up.left")
                    .frame(width: 40, height: 40)
            }).opacity(canUndo ? 1 : 0.5)
            Button(action: {
                canRedo = find(of: UIApplication.shared.windows.first)?.redo() == true
            }, label: {
                Image(systemName: "arrowshape.turn.up.right")
                    .frame(width: 40, height: 40)
            }).opacity(canRedo ? 1 : 0.5)
            Button(action: {
//                find()?.boldPressed()
            }, label: {
                Image(systemName: "bold")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.italicPressed()
            }, label: {
                Image(systemName: "italic")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.strikePressed()
            }, label: {
                Image(systemName: "strikethrough")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.underlinePressed()
            }, label: {
                Image(systemName: "underline")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.indentPressed()
            }, label: {
                Image(systemName: "increase.indent")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.unIndentPressed()
            }, label: {
                Image(systemName: "decrease.indent")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.headerPressed()
            }, label: {
                Text("#")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.linkPressed()
            }, label: {
                Image(systemName: "link")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.imagePressed()
            }, label: {
                Image(systemName: "photo.on.rectangle.angled")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.codePressed()
            }, label: {
                Image(systemName: "terminal")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.quotePressed()
            }, label: {
                Image(systemName: "quote.opening")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.listPressed()
            }, label: {
                Image(systemName: "list.dash")
                    .frame(width: 40, height: 40)
            })
            Button(action: {
//                find()?.orderedListPressed()
            }, label: {
                Image(systemName: "list.number")
                    .frame(width: 40, height: 40)
            })
        }
    }
    
    private func find() -> CustomTextView? {
        return self.find(of: UIApplication.shared.windows.first)
    }
    
    private func find(of view: UIView?) -> CustomTextView? {
          guard let view = view else { return nil }
          if let ctv = view as? CustomTextView {
              return ctv
          }
          for subview in view.subviews {
              if let ctv = find(of: subview) {
                  return ctv
              }
          }
          return nil
    }
}

#Preview {
    CustomEditorDemoView()
}



