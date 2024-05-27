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
    
    /// 抽屉展开时向右滑动的判断阈值
    var drawerDragOpenStartThreshold: CGFloat = 150

    /// 抽屉展开时向右滑动的距离的判断阈值
    var drawerDragOpenLengthThreshold: CGFloat = 100
    
    /// 抽屉关闭时向左滑动的距离的判断阈值
    var drawerDragCloseThreshold: CGFloat = 100
    
    @Binding var isDrawerOpen: Bool
        
    @State private var drawerOffset = CGSize.zero

    @State private var mainStartLocation: CGPoint? = nil
    
    var body: some View {
        ZStack {
            // 主内容区域
            mainContent
                .zIndex(1)
                .gesture(
                    DragGesture()
                        .onChanged({ gesture in
                            let touchLocation = gesture.location
                            if mainStartLocation == nil {
                                mainStartLocation = touchLocation
                            }
                        })
                        .onEnded({ value in
//                            print("底部拖拽：\(String(describing: mainStartLocation?.x)) \(value.location.x)")
                            if mainStartLocation != nil && mainStartLocation!.x < self.drawerDragOpenStartThreshold {
                                let draggedLength = value.location.x - mainStartLocation!.x
                                let isDrawerOpenTrigged = draggedLength > self.drawerDragOpenLengthThreshold
//                                print("检测到左侧 100 滑动事件：\(draggedLength)")
                                if isDrawerOpenTrigged {
//                                    print("触发了抽屉展开事件")
                                    withAnimation {
                                        self.isDrawerOpen = true
                                    }
                                }
                            }
                            mainStartLocation = nil
                        })
                )
            // 阴影遮罩
            blackShadeColor
                .ignoresSafeArea(.all)
                .animation(.easeInOut(duration: 1))
                .opacity(isDrawerOpen ? 1.0 : 0.0)
                .onTapGesture {
                    withAnimation {
                        self.isDrawerOpen = false
                    }
                }
                .zIndex(1)
            // 抽屉式菜单
            if isDrawerOpen {
                HStack(spacing: 0) {
                    drawerContent
                        .frame(width: drawerWidth)
                        .background(Rectangle().fill(drawerBackground))
                    Spacer()
                }.transition(.move(edge: .leading))
                    // 抽屉的区域控制，根据需要自定义吧
//                    .edgesIgnoringSafeArea(.vertical)
                    .zIndex(2)
                    .offset(x: min(0, self.drawerOffset.width))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.drawerOffset = value.translation
                            }
                            .onEnded { value in
                                // 拖动结束后重置偏移量
                                if value.translation.width > -self.drawerDragCloseThreshold {
                                    self.drawerOffset = .zero
                                } else {
                                    withAnimation {
                                        self.isDrawerOpen = false
                                        self.drawerOffset = .zero
                                    }
                                }
                            }
                    )
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
                Spacer()
                HStack {
                    Spacer()
                }
                Text("Main Content").padding()
                Button("Open Drawer") {
                    withAnimation {
                        self.isDrawerOpen.toggle()
                    }
                }.foregroundColor(.white)
                Spacer()
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
