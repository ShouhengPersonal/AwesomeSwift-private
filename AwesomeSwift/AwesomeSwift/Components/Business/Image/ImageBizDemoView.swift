//
//  ImageBizDemoView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/5/29.
//

import Foundation
import SwiftUI
import CropViewController

/// 图片业务 demo
struct ImageBizDemoView: View {
    
    @State private var showImageCropper = false
    @State private var tempInputImage: UIImage?

    func imageCropped(image: UIImage){
        self.tempInputImage = nil
    }
    
    var body: some View {
        VStack(spacing: 15) {
            NavigationLink("基于 ImageViewer 的图片浏览", destination: {
                ImageViewerDemoView()
            })
            NavigationLink("基于 SKPhotoBrowser 的图片浏览", destination: {
                SKPhotoBrowserDemoView()
            })
            Button("图片裁剪") {
                self.tempInputImage = R.image.christmas_star()!
                self.showImageCropper = true
            }
        }.popover(isPresented: $showImageCropper, content: {
            ImageCropper(image: self.$tempInputImage,
                         visible: self.$showImageCropper,
                         done: self.imageCropped)
        })
    }
}

struct ImageCropper: UIViewControllerRepresentable{
  @Binding var image: UIImage?
  @Binding var visible: Bool
  var done: (UIImage) -> Void
  
  class Coordinator: NSObject, CropViewControllerDelegate{
    let parent: ImageCropper
    
    init(_ parent: ImageCropper){
      self.parent = parent
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
      withAnimation{
        parent.visible = false
      }
      parent.done(image)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
      withAnimation{
        parent.visible = false
      }
    }
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
  
  func makeUIViewController(context: Context) -> some UIViewController {
    let img = self.image ?? UIImage()
    let cropViewController = CropViewController(image: img)
    cropViewController.delegate = context.coordinator
    return cropViewController
  }
}

#Preview {
    ImageBizDemoView()
}
