//
//  CallJavaScripts.swift
//  Sewon-mento
//
//  Created by 서민균 on 2022/09/27.
//

import Foundation
import WebKit

class CallJavaScripts {
    static var shared = CallJavaScripts()
    
    func callJavascript(webView: WKWebView?, methodName: String, parameterList: [String]) {
       
        var sendString: String = ""
                
        let lastIndex: Int = parameterList.count
        
        if parameterList.count == 0 {
            sendString = "\(methodName)()"
        }
        else if parameterList.count == 1 {
            guard let param = parameterList.first else {
                print("optional exception error_ Method: callJavascript"); return
            }
            sendString = "\(methodName)('\(param)')"
        }
        else if parameterList.count >= 2 {
            for (index, parameter) in parameterList.enumerated() {
                if index == 0 {
                    sendString = "\(methodName)('\(parameter)', "
                } else if index == (lastIndex-1) {
                    sendString = sendString + "'\(parameter)')"
                } else {
                    sendString = sendString + "'\(parameter)', "
                }
            }
        } else {
            print("parameterList.count error_ Method: callJavascript"); return
        }
        
        print("created_JSMethods => ", sendString)
        
        webView?.evaluateJavaScript(sendString, completionHandler: {
            result, error in
            if let err = error {
                print("ERROR in callJavaScript!! ::: \(err)")
            } else {
                print("call javascript SUCCESS!! ::: \(String(describing: result))")
            }
        })
        
       
    }
}
