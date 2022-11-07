//
//  UrlValidation.swift
//  Sewon-mento
//
//  Created by 서민균 on 2022/09/27.
//

import Foundation

final class Check {
    static var shared = Check()
    
    //url "/" 체크
    func checkUrl(str: String) -> String {
        let lists = str.split(separator: "/")
        var result = ""
        for list in lists {
            result = result + "/\(list)"
        }
        print("result => ", result)
        return result
    }
}


