//
//  String.swift
//  appFrame
//
//  Created by 서민균 on 2022/07/08.
//

import UIKit

extension String {
    
    // String to Date
    func toDate() -> Date? { //"yyyy-MM-dd HH:mm:ss"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let date = dateFormatter.date(from: self){return date}
        else {return nil}
    }
    
    //from번째부터 to번째까지의 문자반환
    func subString(from: Int, to: Int) -> String {
        guard from  < count, to >= 0, to - from >= 0 else {
            return ""
        }
        let startIndex = index(self.startIndex, offsetBy: from) //self.startIndex부터 offsetBy까지
        let endIndex = index(self.endIndex, offsetBy: to)
        return String(self[startIndex..<endIndex])
    }
    
    /* 특정문자열을 지정한 문자열로 반환
        - TODO : url 적합성 판별용 : "/" 중복방지, http 이후에만 "//" 적용
        ////////////////////////////////////////////
        PARAMETERS
        str : "///main////login///asd////123///"
        of : "/" -> of 문자 기준으로 문자열 리스트를 생성
        to : "!" -> 문자열을 합칠때 각문자 사이에 to 가 붙는다.
        idx : 0 -> idx번째로 사이의 문자만 idxTo로 바뀐다.
        idxTo : "!!"
        
        RESULTS
        "!!main!login!asd!123"
        ////////////////////////////////////////////
     */
    func checkUrlValidation(str: String, of: Character, to: String, idx: Int, idxTo: String) -> String {
        let lists = str.split(separator: of)
        var result = ""
        var cnt = 0
        for list in lists {
            if cnt == 0 {
                result = result + list
            } else if cnt == idx {
                result = result + idxTo + list
            } else {
                result = result + to + list
            }
            cnt += 1
        }
        return result
    }
}
