//
//  UINavigationController.swift
//  Sewon-mento
//
//  Created by 서민균 on 2022/09/19.
//

import Foundation
import UIKit

// swipe 시 뒤로 가기 관련
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let mainView = viewControllers.last else {return false}
        if ((mainView as? LoginViewController) != nil) {
            print("\(mainView)'s back swipe is blocked!!"); return false
        } else
        if ((mainView as? MainTabBarController) != nil) {
            print("\(mainView)'s back swipe is blocked!!"); return false
        } else
        {
            return true
        }
    }
    
}
