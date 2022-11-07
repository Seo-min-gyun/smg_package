//
//  CALayer.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import UIKit

// UI 요소의 테두리 설정 관련 ex)textfield의 bottom border line만 표시하고 싶을때 etc
extension CALayer {
    
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, alpha: CGFloat, width: CGFloat, viewWidth: CGFloat){
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: viewWidth, height: width)
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height-width, width: viewWidth, height: width)
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width-width, y: 0, width: width, height: frame.height)
            default:
                break
            }
            border.backgroundColor = color.withAlphaComponent(alpha).cgColor
            self.addSublayer(border)
        }
    }
    
}
