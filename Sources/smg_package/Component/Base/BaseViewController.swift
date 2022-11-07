//
//  BaseViewController.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import UIKit
import WebKit

class BaseViewController: UIViewController {
    
    lazy var navbarHidden = true
    lazy var loadUrl = ""
    lazy var rawUrl = "\(Common.url)\(loadUrl)"
    lazy var fullUrl = rawUrl.checkUrlValidation(str: rawUrl, of: "/", to: "/", idx: 0, idxTo: "//")
    lazy var refresh = true
    lazy var topConstant: CGFloat = 0
    
    // 뒤 버튼 설정
    lazy var leftButton: UIBarButtonItem = {
        if let image_optional = UIImage(named: "BackArrow") {
            let scaledImage: UIImage = image_optional.resize(newWidth: 15)
            let button = UIBarButtonItem(image: scaledImage, style: .done, target: self, action: #selector(goBack))
            button.tag = 1
//            button.tintColor = UIColor(rgb: Common.globalTextColor)
            button.tintColor = .darkGray
            return button
        } else {
            let button = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(goBack))
            button.tag = 1
            button.tintColor = UIColor(rgb: Common.globalTextColor)
            return button
        }
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: nil)
        button.tintColor = .white
        return button
    }()
    
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    // 이미지 로고 설정
//    lazy var navImg: UIImageView = {
//        let imgView = UIImageView(frame: CGRect(x: 0, y: 30, width: 20, height: 20))
//        imgView.contentMode = .scaleAspectFit
//        let img = UIImage(named: "top_nav")
//        imgView.image = img
//        return imgView
//    }()
    
    // 해당 VC로 이동
    func createAndMoveToVc(baseVC: BaseViewController, createVC: BaseViewController, barHidden: Bool, loadUrl: String) {
        createVC.navbarHidden = barHidden
        createVC.loadUrl = loadUrl
        createVC.refresh = true
        baseVC.navigationController?.pushViewController(createVC, animated: true)
    }
    
    // messageBody 정제
    func messageBodyRefine(messageBody: Any) -> String {
        if let obj = messageBody as? Dictionary<String, String> {
            return obj["url"] ?? ""
        } else
        if let str = messageBody as? String {
            return str
        } else {
            return ""
        }
    }
    
    // 새로고침 관련
    func splitLastUrl(url: String) -> String {
        let list = url.split(separator: "/")
        if let lastStr = list.last {
            return String(lastStr)
        } else {
            return ""
        }
    }
    
    private func checkSuffixUrl(str: String) {
        
    }
    
    private func checkPrefixUrl(str: String) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("========= \(className)_viewWillAppear =======")
        
        self.navigationController?.navigationBar.isHidden = navbarHidden
        self.rawUrl = "\(Common.url)\(self.loadUrl)"
        self.fullUrl = rawUrl.checkUrlValidation(str: rawUrl, of: "/", to: "/", idx: 0, idxTo: "//")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("========= \(className) viewDidLoad =======")
        
//        if !navbarHidden {
//            // nav bar 세팅
//            let stackView: UIStackView = makeStackView(subViews: [navImg], stackAxis: .horizontal)
//            navigationItem.titleView = stackView
//            navigationItem.leftBarButtonItem = self.leftButton
//            navigationItem.rightBarButtonItem = self.rightButton
//            
//            //nav bar appearance
//            let navigationBarAppearanceScrollEdge = UINavigationBarAppearance()
//            navigationBarAppearanceScrollEdge.backgroundColor = .white
//            self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearanceScrollEdge
//            
//            let navigationBarApperanceStandard = UINavigationBarAppearance()
//            navigationBarApperanceStandard.backgroundColor = .white
//            self.navigationController?.navigationBar.standardAppearance = navigationBarApperanceStandard
//        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("========= \(className) viewDidDisappear ======")
        
    }
}
