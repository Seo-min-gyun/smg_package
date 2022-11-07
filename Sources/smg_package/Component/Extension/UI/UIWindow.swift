//
//  UIWindow.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import UIKit

extension UIWindow {
    
    //해당 rootViewController의 최상위 viewController를 반환
    public var visibleViewController: UIViewController? {
        return self.visibleViewControllerFrom(vc: self.rootViewController)
    }
    
    /**
     # visibleViewControllerFrom
     - Parameters:
        - vc : rootViewController or UITapViewController
     - Returns: UIViewController?
     - Note: returns vc most front of ViewController
     */
    
    //iOS 13,14
    //UIApplication.shared.windows.first{$0.isKeyWindow}?
    
    //iOS ~ 12
    //UIApplication.shared.keyWindow?
    
    public func visibleViewControllerFrom(vc: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return self.visibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return self.visibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return self.visibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
    
}
