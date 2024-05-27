//
//  DrawerLayout.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/27.
//

import Foundation
import SwiftUI

/// 抽屉控件
struct DrawerLayout<MainContent: View, DrawerContent: View>: View {
    
    /// 主界面的内容
    let mainContent: MainContent
    
    /// 抽屉的内容
    let drawerContent: DrawerContent
    
    /// 抽屉展开时阴影的颜色
    var blackShadeColor: Color = .black.opacity(0.2)
    
    /// 抽屉的宽度
    var drawerWidth: CGFloat = .infinity
    
    /// 抽屉的背景颜色
    var drawerBackground: Color = .red
    
    @Binding var isDrawerOpen: Bool
    
    var body: some View {
        ZStack {
            // 底部阴影
            blackShadeColor
                .ignoresSafeArea(.all)
                .animation(.easeInOut(duration: 1))
                .opacity(isDrawerOpen ? 1.0 : 0.0)
                .onTapGesture {
                    withAnimation {
                        self.isDrawerOpen = false
                    }
                }
            // 主内容区域
            mainContent.zIndex(1)
            // 抽屉式菜单
            if isDrawerOpen {
                HStack(spacing: 0) {
                    drawerContent
                        .frame(width: drawerWidth)
                        .background(Rectangle().fill(drawerBackground))
                    Spacer()
                }.transition(.move(edge: .leading))
                    .edgesIgnoringSafeArea(.vertical)
                    .zIndex(2)
            }
        }
    }
}

// 使用示例
struct DrawerLayoutSampleView: View {
    
    @State private var isDrawerOpen = false
    
    var body: some View {
        DrawerLayout(
            mainContent: VStack {
                Text("Main Content").padding()
                Button("Open Drawer") {
                    withAnimation {
                        self.isDrawerOpen.toggle()
                    }
                }.foregroundColor(.white)
            }.background(Rectangle().fill(.blue)),
            drawerContent: VStack {
                Spacer()
                HStack {
                    Spacer()
                }
                Text("Drawer Content")
                Button("Close Drawer") {
                    withAnimation {
                        self.isDrawerOpen.toggle()
                    }
                }
                Spacer()
            },
            drawerWidth: UIScreen.main.bounds.width * 3 / 4,
            isDrawerOpen: $isDrawerOpen
        ).navigationBarItems(leading: Button(action: {
                withAnimation {
                    self.isDrawerOpen.toggle()
                }
            }) {
                Image(systemName: "line.horizontal.3")
            })
            .navigationBarTitle("Drawer Layout")
    }
}

#Preview {
    DrawerLayoutSampleView()
}
