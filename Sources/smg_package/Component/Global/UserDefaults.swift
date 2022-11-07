//
//  UserDefaults.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation

final class Storage {
    
    static var shared = Storage()
    
    @discardableResult
    func isFirstStart() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "isFirstStart") == nil {
            defaults.set("No", forKey: "isFirstStart")
            return true
        } else {
            return false
        }
    }
    
        
    func setUserDefaults(key: String, value: Any) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
//        if defaults.object(forKey: key) == nil {
//            defaults.set(value, forKey: key)
//        }
    }
    
    func getUserDefaults(key: String) -> Any? {
        let defaults = UserDefaults.standard        
        return defaults.object(forKey: key)
    }
        
    func removeUserDefaults(key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)        
    }
}
