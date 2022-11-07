//
//  Error.swift
//  Sewon-mento
//
//  Created by 서민균 on 2022/09/16.
//

import Foundation

enum URLSessionError: Error {
    case inFirstData
    case inSessionTask
}

extension URLSessionError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .inFirstData:
            return "앱 시작시 sendWhenStart 메서드에서 에러 발생"
        case .inSessionTask:
            return "URLSession Task 중 에러 발생"
        }
    }
}
