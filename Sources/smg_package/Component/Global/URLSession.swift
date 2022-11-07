//
//  URLSession.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//


import Foundation
import UniformTypeIdentifiers
import SwiftUI
import WebKit


class URLSessionCustom {
       
    @discardableResult
    class func asyncAwaitURLSession(formData: [String:String], url: String) async throws -> (Data?, URLResponse?)  {
       
//        print("URL Session => ", Common.cookies)
        
        let config = URLSessionConfiguration.default
        if Common.cookies != [] {
            config.httpCookieStorage?.setCookie(
                Common.cookies[0]
            )
        }
        config.httpShouldSetCookies = true
        config.httpCookieAcceptPolicy = .always
        let session = URLSession(configuration: config)
        
        
        let fomDataString = (formData.compactMap({
            (key, value) in
            return "\(key)=\(value)"
        }) as Array ).joined(separator: "&")
        
//        let formEncodedData = fomDataString.data(using: .utf8)
               
        guard let url = URL(string: url) else {fatalError("urlSession url is nil!")}
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
//        request.httpBody = formEncodedData
        request.httpBody = try! JSONEncoder().encode(formData)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        if let sessionId = Storage.shared.getUserDefaults(key: "connect.sid") as? String {
            
            DispatchQueue.main.async {
                print("localstorage session id => ", sessionId)

            }
            
            request.setValue("connect.sid=\(sessionId)", forHTTPHeaderField: "cookie")
        }
        
        print("header => ", request.allHTTPHeaderFields)
        
        // URLSession 객체를 통해 전송, 응답값 처리
        do{
            let (data, response) = try await session.data(for: request)
//            print("response => ", response)
//            guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("statusCode error")}
            // 받아온 쿠키를 저장합니다! ...
            if
                let httpResponse = response as? HTTPURLResponse,
                let fields = httpResponse.allHeaderFields as? [String: String] {
                    print("in response -> \(fields)")
                
                
//                let cookies: [HTTPCookie] = HTTPCookie.cookies(withResponseHeaderFields: fields, for: response.url!)
            }
            return (data, response)
        } catch {
            throw URLSessionError.inSessionTask
        }
    }
    
}
