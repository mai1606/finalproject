//
//  utilites.swift
//  finalproject_1
//
//  Created by _maiWeb#15 on 10/20/20.
//  Copyright © 2020 ICTSUIM. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class utilities{

    static func isPasswordValid(_ password : String) -> Bool{
       let passRegEx = "(?=[^a-z]*[a-z])[^0-9]*[0-9].*"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    static func setColor(check: Bool){
        if check == true {
            UserDefaults.standard.set(UIColor.mainColorFemale, forKey: "mainColorApp")
        } else {
            UserDefaults.standard.set(UIColor.mainColorMale, forKey: "mainColorApp")
        }
        
    }
    
    class func showLoading() {
        let activityData = ActivityData(size: nil, message: nil, messageFont: nil, messageSpacing: nil, type: .circleStrokeSpin, color: nil, padding: nil, displayTimeThreshold: 1, minimumDisplayTime: 1, backgroundColor: nil, textColor: nil)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
        
    class func hideLoading() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }

}
class DayToday{
   static func daysBetween(start: Date, end: Date) -> Int {
           return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
}


extension DateFormatter {
    static func buddhistFormat() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "th_TH")
        return formatter
    }
}

extension Date {
    static func currentDateStr() -> String {
        let formatter = DateFormatter.buddhistFormat()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = Date()
        return formatter.string(from: date)
    }
    
    static func currentDate() -> Date {
        let formatter = DateFormatter.buddhistFormat()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = Date()
        return formatter.date(from: formatter.string(from: date))!
    }
    
    static func currentDateFromString(strDate: String) -> Date {
        let formatter = DateFormatter.buddhistFormat()
        formatter.dateFormat = "dd MMM YYYY"
        return formatter.date(from: strDate) ?? Date()
    }
}


