//
//  SwipeActionDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/29.
//

import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct SwipeActionDemoView: View {

    let friends = ["Antoine", "Bas", "Curt", "Dave", "Erica"]

    @State private var total = 0

    var body: some View {
        VStack {
            Text("普通侧滑")
            List {
                ForEach(friends, id: \.self) { friend in
                    Text(friend)
                        .swipeActions(allowsFullSwipe: false) {
                            Button {
                                print("Muting conversation")
                            } label: {
                                Label("Mute", systemImage: "bell.slash.fill")
                            }
                            .tint(.indigo)

                            Button(role: .destructive) {
                                print("Deleting conversation")
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            
                            Button(action: {
                                
                            }, label: {
                                VStack {
                                    Text("TEST")
                                    Image(systemName: "trash.fill")
                                }.tint(.purple)
                            })
                        }
                }
            }
            Text("前/后侧滑")
            List {
                ForEach(1..<100) { i in
                    Text("\(i)")
                        .swipeActions(edge: .leading) {
                            Button {
                                total += i
                            } label: {
                                Label("Add \(i)", systemImage: "plus.circle")
                            }
                            .tint(.indigo)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                total -= i
                            } label: {
                                Label("Subtract \(i)", systemImage: "minus.circle")
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    if #available(iOS 15.0, *) {
        SwipeActionDemoView()
    } else {
        Text("15.0+ only")
    }
}
