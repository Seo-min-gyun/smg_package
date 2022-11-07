//
//  Date.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import Foundation
import UIKit
import WebKit

extension Date {
    
    enum dateForm: String {
        case yyyyMMddHHmmss
        case yyMMdd
        case HHmmss
        case 년월일
        case 시분초
    }
    
    func toString(dataFormat: dateForm) -> String {
        let dateFormatter = DateFormatter()
        
        switch dataFormat {
        case .yyyyMMddHHmmss:
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        case .yyMMdd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        case .HHmmss:
            dateFormatter.dateFormat = "HH:mm:ss"
        case .년월일:
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        case .시분초:
            dateFormatter.dateFormat = "HH시 mm분 ss초"
        }
        
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
    
    // 두 날짜의 차이를 년월일시분초로 반환
    static func -(recent: Date, previous: Date) -> (year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) {
        let year = Calendar.current.dateComponents([.year], from: previous, to: recent).year
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        let second = Calendar.current.dateComponents([.second], from: previous, to: recent).second
        
        return (year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }
      
    //(year: Optional(0), month: Optional(3), day: Optional(104), hour: Optional(2515), minute: Optional(150939), second: Optional(9056367))
    
    
}

extension UIView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        // picker(wheel타입)에서 선택 애니메이션이 작동하는 동안, 선택 버튼 비활성화
        let typeTemp: String = String(describing: type(of: self))
        if typeTemp == "UIPickerTableViewWrapperCell" {
            guard let alertView = UIApplication.shared.keyWindow?.visibleViewController else {print("UIApplication.shared.keyWindow?.visibleViewController => nil"); return}
            guard let alertController = alertView as? UIAlertController else {print("alertView as? UIAlertController => nil"); return}
            let alertAction = alertController.actions[0]
            alertAction.isEnabled = false
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
}

extension UIViewController {
    
    // 날짜 포맷 형식을 지정
    func makeDateformatter(date_style: DateFormatter.Style, time_style: DateFormatter.Style, localCode: String, dateFormString: String ) -> DateFormatter {
        
        let formatter = DateFormatter()
        formatter.dateStyle = date_style
        formatter.timeStyle = time_style
        formatter.locale = Locale(identifier: localCode)
        formatter.dateFormat = dateFormString

        return formatter
    }
    
    func callCalendar (vc: UIViewController, afterSelected completion: @escaping (UIDatePicker) -> Void) {
        
        DispatchQueue.main.async {
            let myDatePicker: UIDatePicker = UIDatePicker()
            myDatePicker.datePickerMode = .date
            myDatePicker.locale = Locale(identifier: "ko")
//            myDatePicker.preferredDatePickerStyle = .wheels
            myDatePicker.preferredDatePickerStyle = .inline
//            myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
            myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 300)
            
            // "\n\n\n\n\n\n\n\n" -> 줄바꿈을 이용해 alert의 크기를 조절함
            let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
            alertController.view.addSubview(myDatePicker)
            
            let selectAction = UIAlertAction(title: "선택", style: .default, handler: { _ in
                completion(myDatePicker)
            })
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            selectAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
            cancelAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")

            alertController.addAction(selectAction)
            alertController.addAction(cancelAction)
                       
            vc.present(alertController, animated: true){
                // 날짜 변수의 값 변경을 감지하는 옵저버 부여
                myDatePicker.addTarget(self, action: #selector(self.sensingValueChange(_ :)), for: UIControl.Event.valueChanged)
            }
        }
        
    }
    
    // datepicker의 날짜 변경 감지시 작동하는 함수
    @objc func sensingValueChange(_ datePicker: UIDatePicker) {
        print("date values change detected....")
        
        guard let alertView = UIApplication.shared.keyWindow?.visibleViewController else {print("visible nil"); return}
        guard let alertController = alertView as? UIAlertController else {print("nil casting UIAlertController..."); return}
        let alertAction = alertController.actions[0]
        alertAction.isEnabled = true  
    }
    
    //datepicker에서 날짜를 선택 -> 아래 함수를 호출 -> web상의 js함수 호출 -> web 상의 input칸에 날짜 입력
    func callJavascriptAfterDatePicked(thisWebView: WKWebView?, myDatePicker: UIDatePicker, message: String) {
        print("Selected Date: \(myDatePicker.date)")
        
        let dateRaw: Date = myDatePicker.date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateRefined: String = formatter.string(from: dateRaw)
        
        print("dateRefined ::: \(dateRefined)")
        print("message ::: \(message)")
        
        thisWebView?.evaluateJavaScript("setIosDate('\(dateRefined)', '\(message)')", completionHandler: {result, error in
            if let err = error {
                print("ERROR in callCalendar!! ::: \(err)")
            } else {
                print("call javascript SUCCESS!! ::: \(String(describing: result))")
            }
        })
    }
    
    func callMMCalendar (vc: UIViewController, afterSelected completion: @escaping (String) -> Void) {
        var resultString: String  = ""
        
       let monthPicker = MonthYearWheelPicker()
        monthPicker.onDateSelected = { (mm, yy) in
//            let string = String(format: "%d-%02d", mm, yy)
            let string = String(format: "%d-%02d", yy, mm)
            
            // will show sth like 2022-06
            resultString = string
            print("resultString => ", resultString)
        }
        monthPicker.frame = CGRect(x: 0, y: 15, width: 270, height: 300)
        
        // "\n\n\n\n\n\n\n\n" -> 줄바꿈을 이용해 alert의 크기를 조절함
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(monthPicker)
        
        let selectAction = UIAlertAction(title: "선택", style: .default, handler: { _ in
            completion(resultString)
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        selectAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")
        cancelAction.setValue(UIColor(rgb: Common.globalTextColor), forKey: "titleTextColor")

        alertController.addAction(selectAction)
        alertController.addAction(cancelAction)
                   
        vc.present(alertController, animated: true){
            // 날짜 변수의 값 변경을 감지하는 옵저버 부여
            monthPicker.addTarget(self, action: #selector(self.sensingValueChange(_ :)), for: UIControl.Event.valueChanged)
        }
    }
    
    //년월 선택 -> 자바스크립트 가동
    func callJavascriptAfterMmyyPicked(thisWebView: WKWebView?, mmyyString: String, message: String) {
        print("Selected mmyy: \(mmyyString)")
       
        thisWebView?.evaluateJavaScript("setIosDate('\(mmyyString)', '\(message)')", completionHandler: {result, error in
            if let err = error {
                print("ERROR in callCalendar!! ::: \(err)")
            } else {
                print("call javascript SUCCESS!! ::: \(String(describing: result))")
            }
        })
    }
    
    
}
