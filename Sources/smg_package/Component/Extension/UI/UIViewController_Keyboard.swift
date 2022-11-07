//
//  UIViewController_Keyboard.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import UIKit

extension UIViewController {
    
    //화면터치시 firstresponder resign
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
