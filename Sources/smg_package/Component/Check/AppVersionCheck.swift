//
//  AppVersionCheck.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import UIKit
import SwiftUI

final class AppVersionCheck {
    
    static let shared = AppVersionCheck()
    
    enum VersionType: String {
        case BuildVersion
        case ProjectVersion
    }    
    
    func callDeviceAppVersion(versionType: VersionType) -> String {
        guard let buildInfoDictionary = Bundle.main.infoDictionary else {fatalError("Bundle.main.infoDictionary is nil")}
        let buildVersion: String = buildInfoDictionary["CFBundleVersion"] as? String ?? "BuildVersionNil"
        let projectVersion: String = buildInfoDictionary["CFBundleShortVersionString"] as? String ?? "ProjectVersionNil"
        
        switch versionType {
        case .BuildVersion:
            return buildVersion
        case .ProjectVersion:
            return projectVersion
        }
    }
    
//    func isUpdateNeeded(versionType: VersionType, completion: (Bool) -> ()) {
//        Common.appUserVer = callDeviceAppVersion(versionType: versionType)
//        let result: Bool = (Common.appStoreVer > Common.appUserVer) ? true : false
//        completion(result)
//    }

    func isUpdateNeeded(versionType: VersionType) -> Bool {
        
        Common.appUserVer = callDeviceAppVersion(versionType: versionType)
        return (Common.appDataBaseVer > Common.appUserVer) ? true : false        
    }
    
    //업데이트 알림창 생성
    func updateAlert(completion: @escaping(Bool)->()) -> UIAlertController{
        let alertController = UIAlertController(title: "알림", message: "새로운 버전이 있습니다. 가능하면 업데이트 해주세요.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) {
            _ in
            completion(true)
        }
        okAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
        alertController.addAction(okAction)
        return alertController
    }
    
}
