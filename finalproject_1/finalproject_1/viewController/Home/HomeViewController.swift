//
//  HomeViewController.swift
//  finalproject_1
//
//  Created by _maiWeb#15 on 10/20/20.
//  Copyright © 2020 ICTSUIM. All rights reserved.
//

import UIKit
import FirebaseAuth
import Foundation
import Firebase


class HomeViewController: UIViewController {

    private var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var imageUIview: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var textStatusLabel: UILabel!
    
    @IBOutlet weak var countDownLabel: UILabel!
    let dateFormat = DateFormatter()
    let dateFormat2 = DateFormatter()
    let dateFormat3 = DateFormatter()
    let dateFormat4 = DateFormatter()
    var numCount = 0
    var period = true
    var toDay = Date.currentDate()
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    var NextPeriodMonth = ""
    var isPeriod : [String] = []
    var lastday = Date()
    
    var periodTodayYesNo = false // เช็คประจำเดือนมา
    var periodTodayYesNo1 = false //เช็ควันหลังมีประจำเดือน
    var ovulationDayYesNo = false // เช็ควันตกไข่
    var normal = false
    
    var daycalculate = 0 //ตัวคำนวนวันหลัก
    var daycalculate1 = 0 //ตัวคำนวนวันรอง
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormat.dateFormat = "EEEE, d MMM"
        dateFormat.calendar = Calendar(identifier: .buddhist)
        dateFormat.locale = Locale(identifier: "th_TH")
        todayLabel.text = dateFormat.string(from: toDay)
    
//        dateFormat2.dateFormat = "d"
//        numCount = 0
//        var a2 = dateFormat2.string(from: toDay)
//        var num2 = 0
//        numCount = 30 - Int(a2)!
//        countDownLabel.text = String(numCount)
//        setImageGraphics()
       
       dbData()
       
       // lastday  = dateFormat3.date(from: NextPeriodMonth)!
//        print("1==========>",lastday)
//        setImageGraphics(days: daycalculate)
       // viewWillAppear(true)
//        daycalculate = daysBetween(start: toDay, end: self.lastday)
//        print("2=============>",daycalculate,"ค่าที่เอาไปใช่",lastday)
        
    }
    func dbData()  {
        dateFormat2.dateFormat = "MMM YYYY"
        dateFormat3.dateFormat = "dd MMM yyyy"
//        dateFormat3.locale = Locale(identifier: "th_TH")
        let docRef = db.collection("users").document(user!.uid).collection("periods").document (dateFormat2.string(from: toDay))
        
        
        docRef.getDocument {(document, error) in
            if let document = document, document.exists {
               let  dataDescription = document.data()!["periodsNextMonth"] as! String
               let  isPeriodDb = document.data()!["periods"] as! [String]
               let firstPeriod = document.data()!["firstPeriods"] as! String
                let ovulationDay = document.data()!["ovulationDay"] as! [String]
                self.NextPeriodMonth = dataDescription
                self.isPeriod = isPeriodDb
               
                self.lastday  = self.dateFormat3.date(from: self.NextPeriodMonth) ?? self.toDay
               
                
                self.dateFormat4.dateFormat = "d MMM yyyy"
                self.dateFormat4.locale = Locale(identifier: "en_us")
                let aDay  = self.dateFormat4.string(from: self.toDay)
                let sDay = self.dateFormat4.date(from: firstPeriod)
                print(self.lastday)
                print(self.toDay)
                print(firstPeriod)
                print(sDay)
                print(self.isPeriod)
                print(aDay)
                if self.isPeriod.contains(aDay){
                    self.periodTodayYesNo = true
                    self.ovulationDayYesNo = false
//                    print("ค่ามันคือออออออะไรนะ1",self.dateFormat4.date(from:firstPeriod)!)
//                    print("ค่ามันคือออออออะไรนะ2",aDay)

                    self.daycalculate = self.daysBetween(start:sDay!, end: self.toDay)
                    let a = self.daysBetween(start: self.toDay, end: self.lastday)
//                    print("ทำไมค่ามันมาแต่ 0 ",self.daycalculate)
//                    print("ระยะทางจากวันนี้ไปเดือนหน้า",a)
                    self.setImageGraphics(days: self.daycalculate)
                }else if ovulationDay.contains(aDay){
                    self.ovulationDayYesNo = true
                    self.daycalculate = self.daysBetween(start: self.toDay, end: self.lastday)
                    self.setImageGraphics(days: self.daycalculate)
                }
                else{
                    self.periodTodayYesNo = false
                    print("lastDate",self.lastday)
                    print(self.daycalculate)
                    self.daycalculate = self.daysBetween(start: self.toDay, end: self.lastday)
                    self.daycalculate1 = self.daysBetween(start:sDay!, end: self.toDay)
                    print(self.daycalculate1,"aaaaaa")
                    //  ====     เช็คหลังมีประจำเดือน
                        if self.daycalculate1 >= 7 && self.daycalculate1 <= 8{
                            self.periodTodayYesNo1 = true
                        }else{
                            self.periodTodayYesNo1 = false
                        }
                    // END
                    self.setImageGraphics(days: self.daycalculate)
                  
                }
//                for a in self.isPeriod {
//
//                    if aDay == a {
//                        self.periodTodayYesNo = true
//                         print(a)
//                        print(self.periodTodayYesNo)
//                    }
//                }
                
                
            }else {
                print("ไม่มีข้อมูล")
            
            }
        }
    }
    

    
    func daysBetween(start: Date, end: Date) -> Int {
       return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    func setImageGraphics(days: Int)  {
       //print(days)
        if (days == 0 || days < 0)  && periodTodayYesNo == false && periodTodayYesNo1 == false {
            statusLabel.text = "วันคาดการประจำเด็นมา"
            textStatusLabel.text = "คาดการวันที่"
            countDownLabel.text = String(days*(-1)+1)
           // print("aaaaaa",days*1)
            imageUIview.image = UIImage(named:"character206")
        }else if days < 2 && days > 0 && periodTodayYesNo == false && periodTodayYesNo1 == false{
            statusLabel.text = "ก่อนประจำเดือนมา"
            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
            countDownLabel.text = "0"+String(days)
            imageUIview.image = UIImage(named:"character206")
        }else if days > 16 && days < 30  && periodTodayYesNo == false && periodTodayYesNo1 == false && ovulationDayYesNo == false {
            statusLabel.text = "ช่วงวันไข่ตก"
            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
            countDownLabel.text = String(days)
            imageUIview.image = UIImage(named:"character204")
        }
       else if periodTodayYesNo == true {
            statusLabel.text = "ช่วงมีประจำเดือน"
            textStatusLabel.text = "ประจำเดือนมาวันที่"
            countDownLabel.text = "0"+String(days+1)
            imageUIview.image = UIImage(named:"character202")
            
        }
        else if periodTodayYesNo1 == true {
            statusLabel.text = "หลังประจำเดือนมา"
            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
            imageUIview.image = UIImage(named:"character203")
            countDownLabel.text = String(days)
        }
       
        else if ovulationDayYesNo {
            statusLabel.text = "วันไข่สุก"
            textStatusLabel.text = "ประจำเดือนมาวันที่"
            countDownLabel.text = "0"+String(days)
            imageUIview.image = UIImage(named:"character205")
            ovulationDayYesNo = false
        }else{
            statusLabel.text = "ปกติ"
            textStatusLabel.text = "ประจำเดือนมาวันที่"
            countDownLabel.text = String(days)
            imageUIview.image = UIImage(named:"character201")
        }
        
        
        
        
//        if(numCount == 0 && numCount < 0){
//            statusLabel.text = "วันคาดการประจำเด็นมา"
//            textStatusLabel.text = "คาดการวันที่"
//            imageUIview.image = UIImage(named:"character202")
//            if(period){
//                statusLabel.text = "ระหว่างประจำเดือน"
//                textStatusLabel.text = "เป็นประจำเดือนวันที่"
//                imageUIview.image = UIImage(named:"character202")
//            }
//        }
//        else if(numCount >= 0 && numCount < 7){
//            statusLabel.text = "ก่อนประจำเดือนมา"
//            imageUIview.image = UIImage(named:"character206")
//        }else if(numCount >= 8 && numCount < 12){
//            statusLabel.text = "หลังประจำเดือนมา"
//            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
//            imageUIview.image = UIImage(named:"character203")
//        }else if(numCount >= 12 && numCount < 14){
//            statusLabel.text = "ช่วงไข่สุก"
//            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
//            imageUIview.image = UIImage(named:"character205")
//        }else if(numCount >=  14 && numCount < 15){
//            statusLabel.text = "วันไข่ตก"
//            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
//            imageUIview.image = UIImage(named:"character204")
//        }else{
//            statusLabel.text = "ปกติ"
//            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
//            imageUIview.image = UIImage(named:"character201")
//        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       
        dbData()
        setImageGraphics(days: daycalculate)
        
        
        
        
        
         handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                      if Auth.auth().currentUser != nil {
                    // User is signed in.
                         
                      } else {
                    // No user is signed in.
                        let LoginViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? ViewController
                            self.view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController!)
                            self.view.window?.makeKeyAndVisible()
                      }
                  }
       
    }
   
}
