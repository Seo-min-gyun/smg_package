//
//  Common.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import UIKit
import WebKit
import Foundation

struct Common {
    
    //URL
    static var url = "http://192.168.0.22:9082"
//    static var url = "https://knu-female-mentoring.flash21.com"
    
    //token
    static var token = "token_nil"
    static var tokenSend: Bool = true
    
    //phoneNum
    static var phoneNum = ""
    
    //앱 버전 체크용
    static var appUserVer = "1"
    static var appDataBaseVer = "1"
    
    static var cookies: [HTTPCookie] = []
    static var dataStore = WKWebsiteDataStore.default()
    
    static var globalTextColor = 0xea0000
    
    //메인 탭 바 아이템 새로고침 관련
    static var mainTabBarInitialize: Bool = false
    
    //푸쉬로 실행시, 자동 탭바 이동관련
    static var runByPush: Bool = false
    static var tabBarPage: Int = 0
    
    //viewController
    static var mainTabView: MainTabBarController?
}
