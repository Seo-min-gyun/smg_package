//
//  GetDeviceInfo.swift
//  YUAmp
//
//  Created by 서민균 on 2022/07/11.
//

import UIKit

final class GetDeviceInfo {
    
    static let shared = GetDeviceInfo()
    
    //디바이스 os 버전 조회
    func getOsVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    // 디바이스 모델 조회
    func getModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let model = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return model
    }
    
    
}
