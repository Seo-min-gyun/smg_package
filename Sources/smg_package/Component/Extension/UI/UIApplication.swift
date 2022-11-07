//
//  UIApplication.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import UIKit

extension UIApplication {
    
    public var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap{$0 as? UIWindowScene}
            .flatMap{$0.windows}
            .first{$0.isKeyWindow}
    }
    
}
