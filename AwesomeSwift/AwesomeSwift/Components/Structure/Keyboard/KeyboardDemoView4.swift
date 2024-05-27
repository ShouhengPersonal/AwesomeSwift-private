//
//  KeyboardDemoView4.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/27.
//

import Foundation
import SwiftUI

/// 软键盘示例
@available(iOS 15.0, *)
struct KeyboardDemoView4: View {
    
    /// 是否为底部菜单展开模式
    @State
    var isMenuOpenMode: Bool = false
    
    /// 可以缓存一下之前的值
    @State
    var keyboardHeight: CGFloat = 300
    
    @FocusState
    var keyboardFocused
    
    let bottomInputRegionClosedHeight: CGFloat = 60

    let bottomInputRegionExpandHeight: CGFloat = 180
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
                    HStack {
                        TextField("请输入", text: .constant(""))
                            .padding(8)
                            .border(.blue)
                        Image(systemName: "keyboard.chevron.compact.down")
                            .foregroundColor(.blue)
                            .imageScale(.medium)
                            .onTapGesture {
                                self.isMenuOpenMode = false
                                hideKeyboard()
                            }
                    }.padding(.horizontal, 15)
                    HStack {
                        let s = "proxy.safeAreaInsets.bottom: \(proxy.safeAreaInsets.bottom)\n"
                            + "proxy.safeAreaInsets.top: \(proxy.safeAreaInsets.top)\n"
                            + "键盘状态: \(proxy.safeAreaInsets.bottom > 200 ? "显示" : "隐藏")"
                        Text(s)
                        Spacer()
                    }.padding(.horizontal, 15)
                }
            }
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: calTopSpacingSize(proxy: proxy))
                HStack {
                    TextField("底部输入框", text: .constant(""))
                        .focused($keyboardFocused)
                    Image(systemName: "command.square")
                        .foregroundColor(.blue)
                        .imageScale(.large)
                        .onTapGesture {
                            if !self.isMenuOpenMode || isKeyboardShowing(proxy: proxy) {
                                keyboardHeight = max(proxy.safeAreaInsets.bottom, keyboardHeight)
                                // 先修改 isMenuOpenMode 再改变键盘状态，顺序不可变
                                self.isMenuOpenMode = true
                                hideKeyboard()
                            } else {
                                self.keyboardFocused = true
                            }
                        }
                }.frame(height: calBottomEditorHeight(proxy: proxy))
                    .padding(.horizontal, 15)
                    .background(Rectangle().fill(.gray))
                if isMenuOpenMode && !isKeyboardShowing(proxy: proxy) {
                    VStack {
                        Spacer()
                        Text("录入菜单栏/表情等 占位")
                        HStack {
                            Spacer()
                        }
                        Spacer()
                    }.background(Rectangle().fill(.red))
                        .frame(height: keyboardHeight)
                }
            }
        }.navigationBarHidden(true)
            // 是不能使用 ignore all 的
            //.ignoresSafeArea(.all)
    }
    
    /// 判断键盘是否正在展示
    private func isKeyboardShowing(proxy: GeometryProxy) -> Bool {
        let isKeyboardShowing = proxy.safeAreaInsets.bottom > 200
        return isKeyboardShowing
    }
    
    /// 计算底部输入框的高度
    private func calBottomEditorHeight(proxy: GeometryProxy) -> CGFloat {
        let isKeyboardShowing = proxy.safeAreaInsets.bottom > 200
        if isKeyboardShowing {
            // 键盘展示
            return bottomInputRegionExpandHeight
        } else {
            // 键盘隐藏
            if isMenuOpenMode {
                return bottomInputRegionExpandHeight
            }
            return bottomInputRegionClosedHeight
        }
    }
    
    /// 底部输入框和顶部之间的填充高度计算
    private func calTopSpacingSize(proxy: GeometryProxy) -> CGFloat {
        let isKeyboardShowing = proxy.safeAreaInsets.bottom > 200
        print("caling top spacing size: \(proxy.safeAreaInsets.bottom) \(isMenuOpenMode) \(isKeyboardShowing) \(keyboardHeight)")
        var topSpacing: CGFloat = 0
        if isKeyboardShowing {
            topSpacing = UIScreen.main.bounds.height
                - proxy.safeAreaInsets.bottom
                - proxy.safeAreaInsets.top
                - bottomInputRegionExpandHeight
        } else {
            if isMenuOpenMode {
                topSpacing = UIScreen.main.bounds.height
                    - proxy.safeAreaInsets.top
                    - bottomInputRegionExpandHeight
                    - keyboardHeight
                    - proxy.safeAreaInsets.bottom
            } else {
                topSpacing = UIScreen.main.bounds.height
                    - proxy.safeAreaInsets.top
                    - bottomInputRegionClosedHeight
                    - proxy.safeAreaInsets.bottom
            }
        }
        return topSpacing
    }
}

/// Hide keyboard.
func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

#Preview {
    if #available(iOS 15.0, *) {
        KeyboardDemoView4()
    } else {
        Text("Only available on 15.0 and newer")
    }
}
