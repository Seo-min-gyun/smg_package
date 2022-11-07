//
//  UIViewController.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import UIKit

extension UIViewController {
    
    var className: String {
        return String(describing: self)
    }
    
    // 스테이터스 바 설정 관련: UIViewController에서 상태창을 반환
    var statusBarView: UIView? {
       if #available(iOS 13.0, *) {
           let statusBarFrame = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame
           if let statusBarFrame = statusBarFrame {
               let statusBar = UIView(frame: statusBarFrame)
               view.addSubview(statusBar)
               return statusBar
           } else {
               return nil
           }
       } else {
           return UIApplication.shared.value(forKey: "statusBar") as? UIView
       }
    }
    
    // MARK: - make label and Return
    public func makeLabel(labelText: String, fontName: String, fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = labelText
        if fontName != "" {
            label.font = UIFont(name: fontName, size: fontSize)
        }        
        label.textColor = textColor
        label.sizeToFit()
        return label
    }
    
    // MARK: - make stackView and Return
    public func makeStackView(subViews: [UIView], stackAxis: NSLayoutConstraint.Axis) -> UIStackView{
        
        var subViewWidths: [CGFloat] = []
        var subViewHeights: [CGFloat] = []
        
        for subView in subViews {
            subViewWidths.append(subView.frame.width)
            subViewHeights.append(subView.frame.height)
        }
        
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.axis = stackAxis
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        
        switch stackAxis{
        case .horizontal:
            stackView.frame.size.width = subViewWidths.reduce(0, +)
            stackView.frame.size.height = subViewHeights.max() ?? 0
        case .vertical:
            stackView.frame.size.width = subViewWidths.max() ?? 0
            stackView.frame.size.height = subViewHeights.reduce(0, +)
        @unknown default:
            print("Error Ocurred in func maskStckView!!!")
        }
        
        return stackView
    }
    
    // MARK: - Toast
    public func showToast(controller: UIViewController, message: String, seconds: Double) {
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - 150, y: view.frame.size.height-100, width:300, height : 35))
    //        toastLabel.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        toastLabel.backgroundColor = UIColor(rgb: Common.globalTextColor)
    //        toastLabel.textColor = UIColor.black
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = NSTextAlignment.center;
        view.addSubview(toastLabel)
        toastLabel.text = message
        toastLabel.font = UIFont.boldSystemFont(ofSize: 15)
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds = true
        UIView.animate(withDuration: seconds, animations: {
            toastLabel.alpha = 0.0
        }, completion: nil)
    }
    
    // MARK: - make AlertViewController
    public func makeAlertView(vc: UIViewController, message: String, completion: @escaping () -> ()) -> UIAlertController {
        
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) {_ in
            completion()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        okAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        return alertController
        
    }
    
    public func makeAlertViewOnlyConfirm(vc: UIViewController, message: String, completion: @escaping () -> ()) -> UIAlertController {
        
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) {_ in
            completion()
        }
        okAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
        alertController.addAction(okAction)
        return alertController
        
    }
    
    
}
