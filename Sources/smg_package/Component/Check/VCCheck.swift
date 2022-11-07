//
//  VCCheck.swift
//  knu_female_mentoring
//
//  Created by 서민균 on 2022/10/26.
//

import Foundation
import UIKit

class VCCheck {
    
    static var shared = VCCheck()
    
    //해당 vc 체크 후 리턴
    func checkSpecificViewControllerAndReturn (baseVC: UIViewController, vcName: String) -> UIViewController? {
        let nilErrorStr: String = "guard let nil error_method: checkSpecificViewControllerAndReturn"
        
        guard let vcs = baseVC.navigationController?.viewControllers else {print(nilErrorStr); return nil}
        
        var resultList: [UIViewController] = []
        
        //UITabBarController
        for vc in vcs {
            //vc가 UITabBarController 일 경우
            if let mainTabVC = vc as? UITabBarController {
                guard let tabVCs = mainTabVC.viewControllers else {print(nilErrorStr); return nil}
                for tabVC in tabVCs {
                    guard let className = tabVC.className.split(separator: ".").last?.split(separator: ":").first else {print(nilErrorStr); return nil}
                    if className == vcName {
                        resultList.append(tabVC)
                    }
                }
            
            }
            
            // <knu_female_mentoring.MentoringVC_02_JoinForm: 0x14eb17f30>
            guard let className = vc.className.split(separator: ".").last?.split(separator: ":").first else {print(nilErrorStr); return nil}
            if className == vcName {
                resultList.append(vc)
            }
        }
        
        return resultList.first
    }
    
    
    
    
}
