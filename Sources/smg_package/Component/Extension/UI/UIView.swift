//
//  UIView.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import UIKit

extension UIView {
    
    // scrolling의 여부를 판단후 반환하는 메서드
    func isScrolling() -> Bool {
        if let scrollView = self as? UIScrollView {
            if (scrollView.isDragging || scrollView.isDecelerating){
                return true
            }
        }
        
        for subView in self.subviews {
            if (subView.isScrolling()) {
                return true
            }
        }
        return false
    }
    
    func waitTillDoneScrolling (completion: @escaping () -> Void) {
        var isMoving = true
        DispatchQueue.global(qos: .background).async {
            while isMoving == true {
                isMoving = self.isScrolling()
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
}
