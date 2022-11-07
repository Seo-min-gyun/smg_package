//
//  Array.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation

extension Array where Element: Numeric {
    
    func sum() -> Element {
        return self.reduce(0, +)
    }
    
}
