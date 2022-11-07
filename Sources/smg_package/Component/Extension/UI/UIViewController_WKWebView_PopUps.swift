//
//  UIViewController_WKWebView.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import UIKit
import WebKit

extension UIViewController: WKUIDelegate {

    // MARK: - Alert
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel){
            _ in completionHandler()
        }
        cancelAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - Confirm
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            completionHandler(false)
        }
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            completionHandler(true)
        }
        
        okAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }

    // MARK: - TextInputPanel
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: nil, message: prompt, preferredStyle: .actionSheet)
        alertController.addTextField{ (textField) in
            textField.text = defaultText
        }
        
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: {
            (action) in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: {
            (action) in
            completionHandler(nil)
        })
        
        confirmAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
 
        
    
}
