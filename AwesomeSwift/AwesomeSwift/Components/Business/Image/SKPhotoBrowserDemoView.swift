//
//  SKPhotoBrowserDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/29.
//

import Foundation
import SwiftUI
import SKPhotoBrowser

/// SKPhotoBrowser 图片浏览示例
struct SKPhotoBrowserDemoView: View {
    
    @State var viewerImages: [SKPhoto] = [SKPhoto.photoWithImage(R.image.christmas_star()!)]
    
    @State var currentPageIndex: Int = 0
    
    var body: some View {
        VStack {
            PhotoViewer(viewerImages: $viewerImages, currentPageIndex: $currentPageIndex)
        }.onAppear {
            let photos = image_urls.map { url in
                SKPhoto.photoWithImageURL(url.absoluteString)
            }
            self.viewerImages = photos
        }
    }
}

struct PhotoViewer: UIViewControllerRepresentable {

    @Binding var viewerImages:[SKPhoto]
    
    @Binding var currentPageIndex: Int

    func makeUIViewController(context: Context) -> SKPhotoBrowser {
        let browser = SKPhotoBrowser(photos: viewerImages)
        browser.initializePageIndex(currentPageIndex)
        browser.delegate = context.coordinator
        return browser
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIViewController(_ browser: SKPhotoBrowser, context: Context) {
        browser.photos = viewerImages
        browser.currentPageIndex = currentPageIndex
    }

    class Coordinator: NSObject, SKPhotoBrowserDelegate {

        var control: PhotoViewer

        init(_ control: PhotoViewer) {
            self.control = control
        }

        func didShowPhotoAtIndex(_ browser: PhotoViewer) {
            self.control.currentPageIndex = browser.currentPageIndex
        }
    }
}

#Preview {
    SKPhotoBrowserDemoView()
}
