//
//  Cookie.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import WebKit

final class CookieMethods {
    static let shared = CookieMethods()
    
    // make cookies!
    public func makeCookie(name: String, value: String, expires: TimeInterval){
        let dom = String((String((Common.url.split(separator: ":"))[1]).components(separatedBy: "//"))[1])
        print("this domain willbe use in cookies!! :::::::::::::: [\(dom)]")
               
        guard let cookDevice = HTTPCookie(properties: [
            .domain: dom,
            .path: "/",
            .name : name,
            .value : value,
            .expires: NSDate(timeIntervalSinceNow: expires) //초단위: 하루는 86400초
        ]) else {return}

        Common.cookies = [cookDevice]
        
        print("makeCookie ", Common.cookies)
        
        DispatchQueue.main.async {
            WKWebsiteDataStore.default().httpCookieStore.setCookie(Common.cookies[0])
        }
    }
    
    public func makeSession(name: String, value: String) {
        let dom = String((String((Common.url.split(separator: ":"))[1]).components(separatedBy: "//"))[1])
        print("this domain willbe use in cookies!! :::::::::::::: [\(dom)]")
               
        guard let session = HTTPCookie(properties: [
            .domain: dom,
            .path: "/",
            .name : name,
            .value : value,
            .expires: "'(null)'"
        ]) else {return}
        
        Common.cookies = [session]
        print("make_session => ", session)
        
        DispatchQueue.main.async {
            WKWebsiteDataStore.default().httpCookieStore.setCookie(session)
        }
        
    }

    // see cookies!
    public func seeCookie(){
        var cnt: Int = 1
        WKWebsiteDataStore.default().httpCookieStore.getAllCookies ({
            cookies in
            print("============seeCookie===========")
            for cookie in cookies {
                print("\(cnt)번째 쿠키 ============")
                print(cookie)
                cnt += 1
            }
            print("=======================")
        })
    }
    
    // get cookies!
    public func getCookie(name: String, completion: @escaping (String)->()) {
        WKWebsiteDataStore.default().httpCookieStore.getAllCookies({
            cookies in
            
            for cookie in cookies {
                if cookie.name == name {
                    completion(cookie.value)
                }
            }
            
            completion("")
        })
    }
    
    // return cookies!
    public func returnCookies(name: String?, singleCompletion: @escaping (HTTPCookie)->(), listCompletion: @escaping ([HTTPCookie])->()) {
        
        if let name = name {
            WKWebsiteDataStore.default().httpCookieStore.getAllCookies({
                cookies in
                for cookie in cookies {
                    if cookie.name == name {
                        singleCompletion(cookie)
                    }
                }
            })
        } else {
            WKWebsiteDataStore.default().httpCookieStore.getAllCookies({
                cookies in
                listCompletion(cookies)
            })
        }
    }
    
    // delete cookies
    public func deleteCookies(name: String){
        WKWebsiteDataStore.default().httpCookieStore.getAllCookies({
            cookies in
            for cookie in cookies {
                if cookie.name == name {
                    WKWebsiteDataStore.default().httpCookieStore.delete(cookie)
                }
            }
        })        
    }
    
    
    
}


