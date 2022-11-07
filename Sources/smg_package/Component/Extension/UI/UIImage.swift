//
//  UIImage.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import UIKit

extension UIImage {
    
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        return renderImage
    }
    
    func resizeImage(size: CGSize) -> UIImage {
        let originalSize = self.size
        let ratio: CGFloat = {
            return originalSize.width > originalSize.height ? 1 / (size.width / originalSize.width) :
            1 / (size.height / originalSize.height)
        }()
        print("resize Image: ", ratio)
        return UIImage(cgImage: cgImage!, scale: self.scale, orientation: self.imageOrientation)
    }
    
}
