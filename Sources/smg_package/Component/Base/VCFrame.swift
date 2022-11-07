//
//  VCFrame.swift
//  Sewon-mento
//
//  Created by 서민균 on 2022/09/19.
//

import Foundation
import WebKit

class VCFrame: BaseViewController {
    
    lazy var webView: WKWebView = WKWebView()
    
    let messageList: [String] = []
    
    override func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        super.userContentController(userContentController, didReceive: message)
        
        if message.name == "" {
            
        }
        
    }
    
    override func viewDidLoad() {
        print("VCFrame")
        super.viewDidLoad()
        webView = loadWebPage(self, url: fullUrl, messageList)
    }
    
}
