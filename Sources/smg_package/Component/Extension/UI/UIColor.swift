//
//  UIColor.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import UIKit

//색을 HexCode로 지정하기 위해 설정한 코드
/**
 사용 예시
 let color = UIColor(rgb: 0xFFFFFF)
 
 알파값 포함
 let color = UIColor(rgb: 0xFFFFFF).withAlphaComponent(1.0)
 let color2 = UIColor(argb: 0xFFFFFFFF)
 */

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red)/255.0,
            green: CGFloat(green)/255.0,
            blue: CGFloat(blue)/255.0,
            alpha: CGFloat(a)/255.0
        )
    }
    
    convenience init(rgb: Int){
        self.init(
            red:(rgb>>16)&0xFF,
            green:(rgb>>8)&0xFF,
            blue:rgb&0xFF
        )
    }
    
    convenience init(argb: Int) {
        self.init(
            red:(argb>>16)&0xFF,
            green:(argb>>8)&0xFF,
            blue:argb&0xFF,
            a:(argb>>24)&0xFF
        )
    }
}
