//
//  UIViewController_WKWebView_WebView.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import WebKit

extension UIViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    // 범용적으로 사용할 메시지 키워드는 이곳에 입력...
    var messageKeyWords: [String] {
        return ["pageError404"]
    }
    
    // MARK: - MessageManager
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print("message_name => ", message.name, " || message_body => ", message.body) 
        if message.name == "pageError404" {
            LogoutProcess.shared.logoutProcess(baseVC: self)
        }
    }
    
    // MARK: - loadWebPage
    @discardableResult
    func loadWebPage(_ vc: UIViewController, url:String, to webView: WKWebView? = nil, _ sendMessageNames: [String]? = nil, _ topConstant: CGFloat = 0) -> WKWebView{

        let myWebView: WKWebView!
        
        if let view = webView {
            myWebView = view
        } else {
            let contentController = WKUserContentController()
            let config = WKWebViewConfiguration()
                       
            let preferences = WKWebpagePreferences()
            let dataStore = WKWebsiteDataStore.default()
            
            preferences.allowsContentJavaScript = true
            config.allowsInlineMediaPlayback = true
            config.mediaTypesRequiringUserActionForPlayback = []
            config.defaultWebpagePreferences = preferences
            
            if let messages = sendMessageNames {
                messages.forEach{
                    contentController.add(vc, name: $0)
                }
                messageKeyWords.forEach{
                    contentController.add(vc, name: $0)
                }
            }

            config.userContentController = contentController
            
            // 쿠키 세팅, Common.cookie에 저장된 쿠키 값들을 datastore에 전송
            if Common.cookies.count != 0 {
                let cookies = Common.cookies

                DispatchQueue.main.async {
                    let waitGroup = DispatchGroup()

                    for cookie in cookies {
                        waitGroup.enter()
                        dataStore.httpCookieStore.setCookie(cookie) {
                            waitGroup.leave()
                        }
                    }

                    waitGroup.notify(queue: DispatchQueue.main) {
                        config.websiteDataStore = dataStore
                    }
                }
            }

            // 웹뷰 최종생성
            myWebView = WKWebView(frame:.zero, configuration: config)
            
        }
        
        vc.view.addSubview(myWebView)

        myWebView.translatesAutoresizingMaskIntoConstraints = false

        myWebView.topAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.topAnchor,constant: topConstant).isActive = true
        myWebView.leadingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        myWebView.trailingAnchor.constraint(equalTo: vc.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        myWebView.bottomAnchor.constraint(equalTo:vc.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        myWebView.load(request)
        
//        print("c_url => ", url)
//        let sharedCookies: [HTTPCookie] = HTTPCookieStorage.shared.cookies(for: url!) ?? []
//        print("sharedCookies => ", sharedCookies)
        
        myWebView.uiDelegate = vc
        myWebView.navigationDelegate = vc
               
        return myWebView
    }
            
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("webView did Commit :: 웹 컨텐츠 로딩 중.")
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("webView did Start :: 웹 컨텐츠를 로딩 시작")
        
    }
    
    public func webView(_ webView: WKWebView, didReceiveRedirectForProvisionalNavigation: WKNavigation!) {
        print("webView didReceiveRedirectForProvisionalNavigation :: 서버 리디렉션을 수신")
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("webView didFail :: 탐색 중 에러 발생")
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("webView didFailProvisionalNavigation :: 컨텐츠 로드 중 오류가 발생", error)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webView didFinish :: 탐색 완료")
        
    }
    
    
    
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("webViewWebContentProcessDidTerminate :: 웹 컨텐츠 프로세스가 종료")
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
        print("webView decidePolicyFor navigationResponse ::: 상태코드에 따라 탐색 지속 여부를 결정")
        
        
        
        if (navigationResponse.response is HTTPURLResponse){
            let response = navigationResponse.response as? HTTPURLResponse
            let resCode: Int = response?.statusCode ?? 0
            let successRange = 200..<300
            
            if let fields = response?.allHeaderFields as? [String:String] {
                print("WKWebview res -> \(fields)")
            } else {
                print("fields nil!!")
            }
                        
            print(String(format: "response.statusCode: %i", response?.statusCode ?? 0))
            if successRange.contains(resCode){
                return .allow
            } else {
                return .cancel
            }
           
            
        } else {
            return .cancel
        }
    }
    
    // Url Handler
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print("url 신호를 받았습니다. :::::::::::::::::::::::")
        print(navigationAction.request.url as Any)
        
//        guard let url = navigationAction.request.url else {
//            print("111")
//            decisionHandler(.cancel)
//            return
//        }
        
//        let urlString = url.absoluteString
//        if urlString.contains("flash21.com") {
//            print("222")
//            decisionHandler(.allow)
//        } else
        if navigationAction.request.url?.scheme == "tel" {
            UIApplication.shared.open(URL(string: "\(navigationAction.request.url!)")!)
            decisionHandler(.cancel)
        }
        else {
//            UIApplication.shared.open(URL(string: "\(navigationAction.request.url!)")!)
            decisionHandler(.allow)
        }
        
    }
    
}
