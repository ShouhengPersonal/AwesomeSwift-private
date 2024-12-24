//
//  ImageProcessView.swift
//  AwesomeSwift
//
//  Created by shouh wang on 2024/12/24.
//

import Foundation
import SwiftUI

struct ImageProcessView: View {
    
    struct DragLine: Identifiable {
        
        let id = UUID()
        
        var pos: CGFloat = 0.0
        
        init(pos: CGFloat) {
            self.pos = pos
        }
    }

    @State private var rowText: String = "3"
    @State private var colText: String = "3"
    @State private var hLines: [DragLine] = [] // 水平的线
    @State private var vLines: [DragLine] = [] // 垂直的线
    @State private var vLineDrag: CGFloat = 0
    @State private var hLineDrag: CGFloat = 0
    @State private var vLineDragging: DragLine? = nil
    @State private var hLineDragging: DragLine? = nil
    @State private var image: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    
    private let lineWidth: CGFloat = 2
    private let imageViewWidth = UIScreen.main.bounds.width
    private let imageViewHeight = UIScreen.main.bounds.height - 200

    var body: some View {
        ZStack {
            if image == nil {
                Button("选择图片") {
                    isImagePickerPresented.toggle()
                }.padding()
            }
            if let image = self.image {
                ZStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageViewWidth, height: imageViewHeight)
                        .border(.black)
                    ForEach(vLines) { line in
                        HStack(spacing: 0) {
                            Color.red
                                .opacity(vLineDragging?.id == line.id ? 0 : 1)
                                .frame(width: lineWidth, height: imageViewHeight)
                                .offset(x: line.pos)
                                .gesture(
                                    DragGesture()
                                        .onChanged({ state in
                                            self.vLineDrag = state.location.x
                                            self.vLineDragging = line
                                        })
                                        .onEnded({ _ in
                                            withAnimation(.spring(), {
                                                self.vLineDragging = nil
                                                self.vLines.removeAll { l in
                                                    line.id == l.id
                                                }
                                                self.vLines.append(DragLine(pos: vLineDrag))
                                            })
                                        })
                                )
                                Spacer()
                            }
                    }
                    if vLineDragging != nil {
                        HStack(spacing: 0) {
                            Color.red.frame(width: lineWidth, height: imageViewHeight)
                                .offset(x: vLineDrag)
                            Spacer()
                        }
                    }
                    ForEach(hLines) { line in
                        VStack(spacing: 0) {
                            Color.red.frame(width: imageViewWidth, height: lineWidth)
                                .opacity(hLineDragging?.id == line.id ? 0 : 1)
                                .offset(y: line.pos)
                                .gesture(
                                    DragGesture()
                                        .onChanged({ state in
                                            self.hLineDrag = state.location.y
                                            self.hLineDragging = line
                                        })
                                        .onEnded({ _ in
                                            withAnimation(.spring(), {
                                                self.hLineDragging = nil
                                                self.hLines.removeAll { l in
                                                    line.id == l.id
                                                }
                                                self.hLines.append(DragLine(pos: hLineDrag))
                                            })
                                        })
                                )
                            Spacer()
                        }
                    }
                    if hLineDragging != nil {
                        VStack(spacing: 0) {
                            Color.red.frame(width: imageViewWidth, height: lineWidth)
                                .offset(y: hLineDrag)
                            Spacer()
                        }
                    }
                }.frame(width: imageViewWidth, height: imageViewHeight)
            }
            
            VStack {
                Spacer()
                HStack {
                    Text("行")
                    TextField("", text: $rowText)
                        .padding(.horizontal, 5)
                        .background(Color.gray.opacity(0.3))
                    Text("列")
                    TextField("", text: $colText)
                        .padding(.horizontal, 5)
                        .background(Color.gray.opacity(0.3))
                    Button(action: {
                        if let cols = Int(rowText), let rows = Int(colText) {
                            vLines.removeAll()
                            hLines.removeAll()
                            for row in 1..<rows {
                                let line = DragLine(pos: CGFloat(row) / CGFloat(rows) * imageViewHeight)
                                hLines.append(line)
                            }
                            for col in 1..<cols {
                                let line = DragLine(pos: CGFloat(col) / CGFloat(cols) * imageViewWidth)
                                vLines.append(line)
                            }
                            print("V: \(vLines), \(imageViewWidth)")
                            print("H: \(hLines), \(imageViewHeight)")
                        } else {
                            print("失败了")
                        }
                    }, label: {
                        Text("确定")
                    })
                    
                    Button(action: {
                        if let image = self.image {
                            let images = cropImageIntoGrid(image: image)
                            saveCroppedImages(images)
                            print("裁剪完成")
                        }
                    }, label: {
                        Text("裁剪")
                    })
                }.padding(.horizontal, 30)
            }
        }
        .fileImporter(isPresented: $isImagePickerPresented, allowedContentTypes: [.image]) { result in
            switch result {
            case .success(let url):
                guard let image = UIImage(contentsOfFile: url.path) else { return }
                self.image = image
            case .failure(let error):
                print("Failed to load image: \(error.localizedDescription)")
            }
        }
    }

    // 按照3x3切割图片
    private func cropImageIntoGrid(image: UIImage) -> [UIImage] {
        var croppedImages: [UIImage] = []
        
        let cgImage = image.cgImage!
        let imageWidth = cgImage.width
        let imageHeight = cgImage.height
        
        var vlines: [Int] = [0]
        var hlines: [Int] = [0]
        
        // 需要按照升序排列
        let hLines = self.hLines.sorted { l1, l2 in
            l1.pos < l2.pos
        }
        let vLines = self.vLines.sorted { l1, l2 in
            l1.pos < l2.pos
        }
        
        let imageRadio = CGFloat(imageWidth) / CGFloat(imageHeight)
        let viewRadio = imageViewWidth / imageViewHeight
        if imageRadio > viewRadio {
            // 图片宽度填满
            let radio = CGFloat(imageWidth) / imageViewWidth
            // 注意这里需要除以 radio，因为减去的是在页面上的高度而不是图片实际的高度
            let offset = (imageViewHeight - CGFloat(imageHeight) / radio) / 2
            hLines.forEach { line in
                // 需要判断正负，负值可以忽略
                hlines.append(Int((line.pos - offset) * radio))
            }
            vLines.forEach { line in
                vlines.append(Int(line.pos * radio))
            }
        } else {
            // 图片长度填满，或者都填满
            let radio = CGFloat(imageHeight) / imageViewHeight
            let offset = (imageViewWidth - CGFloat(imageWidth) / radio) / 2
            vLines.forEach { line in
                vlines.append(Int((line.pos - offset) * radio))
            }
            hLines.forEach { line in
                hlines.append(Int(line.pos * radio))
            }
        }
        hlines.append(imageHeight)
        vlines.append(imageWidth)
        
        print("横线 最终：\(hlines)，原始：\(self.hLines.map({ line in line.pos }))")
        print("竖线 最终：\(vlines)，原始：\(self.vLines.map({ line in line.pos }))")
        
        for vindex in 0..<vlines.count-1 {
            for hindex in 0..<hlines.count-1 {
                let x = vlines[vindex]
                let y = hlines[hindex]
                let width = vlines[vindex+1] - x
                let height = hlines[hindex+1] - y
                let cropRect = CGRect(x: x, y: y, width: width, height: height)
                
                if let croppedCGImage = cgImage.cropping(to: cropRect) {
                    let croppedImage = UIImage(cgImage: croppedCGImage)
                    croppedImages.append(croppedImage)
                }
            }
        }
        
        return croppedImages
    }

    // 保存切割后的图片
    func saveCroppedImages(_ images: [UIImage]) {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        for (index, image) in images.enumerated() {
            guard let data = image.jpegData(compressionQuality: 1.0) else { continue }
            let fileURL = documentsURL.appendingPathComponent("cropped_image_\(index + 1).jpg")
            
            do {
                try data.write(to: fileURL)
                print("Saved cropped image to \(fileURL)")
            } catch {
                print("Failed to save image: \(error.localizedDescription)")
            }
        }
    }
}


#Preview {
    ImageProcessView()
}
