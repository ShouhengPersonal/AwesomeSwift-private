//
//  FSNoteDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/30.
//

import Foundation
import SwiftUI

struct FSNoteDemoView: View {
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    Button(action: {
                        find()?.boldPressed()
                    }, label: {
                        Image(systemName: "bold")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.italicPressed()
                    }, label: {
                        Image(systemName: "italic")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.strikePressed()
                    }, label: {
                        Image(systemName: "strikethrough")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.underlinePressed()
                    }, label: {
                        Image(systemName: "underline")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.indentPressed()
                    }, label: {
                        Image(systemName: "increase.indent")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.unIndentPressed()
                    }, label: {
                        Image(systemName: "decrease.indent")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.headerPressed()
                    }, label: {
                        Text("#")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.linkPressed()
                    }, label: {
                        Image(systemName: "link")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.imagePressed()
                    }, label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.codePressed()
                    }, label: {
                        Image(systemName: "terminal")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.quotePressed()
                    }, label: {
                        Image(systemName: "quote.opening")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.listPressed()
                    }, label: {
                        Image(systemName: "list.dash")
                            .frame(width: 40, height: 40)
                    })
                    Button(action: {
                        find()?.orderedListPressed()
                    }, label: {
                        Image(systemName: "list.number")
                            .frame(width: 40, height: 40)
                    })
                }
            }
            ScrollView {
                VStack {
                    FSEditorView()
                        .border(.black)
                        .background(Rectangle().fill(.gray))
                }
            }
        }
    }
    
    private func find() -> EditTextView? {
        return self.find(of: UIApplication.shared.windows.first)
    }
    
    private func find(of view: UIView?) -> EditTextView? {
          guard let view = view else { return nil }
          if let ctv = view as? EditTextView {
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

struct FSEditorView: UIViewRepresentable {
 
    let tv = EditTextView(coder: nil)

    func makeUIView(context: Context) -> EditTextView {
        tv?.initTextStorage()
        return tv!
    }
    
    func updateUIView(_ uiView: EditTextView, context: Context) {
    }
    
    func bold() {
        tv?.boldPressed()
    }
    
    func italic() {
        tv?.italicPressed()
    }
}

#Preview {
    FSNoteDemoView()
}
