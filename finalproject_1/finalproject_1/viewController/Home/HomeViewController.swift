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
    let dateFormat5 = DateFormatter()
    let dateFormat3 = DateFormatter()
    let dateFormat4 = DateFormatter()
    var numCount = 0
    var period = true
    var toDay = Date.currentDate()
    
    var monthCheck : [String] = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    var NextPeriodMonth = ""
    var isPeriod : [String] = []
    var lastday = Date.currentDate()
    
    var periodTodayYesNo = false // เช็คประจำเดือนมา
    var periodTodayYesNo1 = false //เช็ควันหลังมีประจำเดือน
    var ovulationDayYesNo = false // เช็ควันตกไข่
    var normal = false
    var liveAlbums = ""
    
    var daycalculate = 0 //ตัวคำนวนวันหลัก
    var daycalculate1 = 0 //ตัวคำนวนวันรอง
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormat.dateFormat = "E d MMM"
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
       
       
//        let firebaseAuth = Auth.auth()
//            do {
//              try firebaseAuth.signOut()
//            } catch let signOutError as NSError {
//              print ("Error signing out: %@", signOutError)
//            }
//
//        UserDefaults.standard.removeObject(forKey: "userName")
//        UserDefaults.standard.removeObject(forKey: "userEmail")
//        UserDefaults.standard.removeObject(forKey: "userNeed")
//        UserDefaults.standard.removeObject(forKey: "periodDay")
//        UserDefaults.standard.removeObject(forKey: "periodMonth")
//        UserDefaults.standard.removeObject(forKey: "userAge")
//        UserDefaults.standard.removeObject(forKey: "userGender")

//            let LoginViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? ViewController
//                self.view.window?.rootViewController = UINavigationController(rootViewController: LoginViewController!)
//                self.view.window?.makeKeyAndVisible()
            
        
       
       // lastday  = dateFormat3.date(from: NextPeriodMonth)!
//        print("1==========>",lastday)
//        setImageGraphics(days: daycalculate)
       // viewWillAppear(true)
//        daycalculate = daysBetween(start: toDay, end: self.lastday)
//        print("2=============>",daycalculate,"ค่าที่เอาไปใช่",lastday)
        dbCheck()
    }
    func dbCheck(){
        showLoading()
//        dateFormat4.dateFormat = "yyyy"
        dateFormat4.dateFormat = "YYYY"
        dateFormat3.dateFormat = "MMM"
        dateFormat5.dateFormat = "MMM YYYY"
        guard let user1 = user else {
            do {
                try Auth.auth().signOut()
                
            } catch  let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            }
            
            return
        }
//        self.db.collection("users").document(self.user!.uid).collection("periods").getDocuments{ (document, error) in
        //dateFormat2.string(from: toDay)
        db.collection("users").document(user1.uid).collection("periods").getDocuments{(document, error) in
            var Days :String = ""
            if  document == document{
                for a in document!.documents{
                    if a.data()["periodMonth"] as! String == self.dateFormat5.string(from: self.toDay){
                        self.dbData(day: self.dateFormat5.string(from: self.toDay))
                    }else {
                        for (index,a) in self.monthCheck.enumerated() {
                            if a == self.dateFormat3.string(from: self.toDay){
                                Days = self.monthCheck[index-1]+" "+self.dateFormat4.string(from: self.toDay)
                                self.dbData(day:Days)
//                                if let dateData = self.dateFormat5.date(from: Days){
//
//                                }
                               
                               // print(">>>>>>",Days)
                            }
                        }
                    }
                }
            }else{
               
            }
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboard.instantiateViewController(withIdentifier: "CalendarPageView") as! CalendarPageViewController
            self.hideLoading()
            UserDefaults.standard.set(Days, forKey: "dayFromHome")
            
    }
}
        func dbData(day:String)  {
        
        dateFormat2.dateFormat = "MMM YYYY"
        dateFormat3.dateFormat = "dd MMM yyyy"
        //dateFormat3.locale = Locale(identifier: "th_TH")
        guard let user = user else {
            do {
                try Auth.auth().signOut()
                
            } catch  let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            }
            
            return
        }
        let docRef = db.collection("users").document(user.uid).collection("periods")
        
        
        docRef.getDocuments{(document, error) in
            if  document == document{
                var dataDescription : String = ""
                var isPeriodDb : [String] = []
                var firstPeriod : String = ""
                var ovulationDay : [String] = []
                var sex : String = ""
                for document in document!.documents{
                    if document.data()["periodMonth"] as! String == day {
                        dataDescription = document.data()["periodsNextMonth"] as! String
                        isPeriodDb = document.data()["periods"] as! [String]
                        firstPeriod = document.data()["firstPeriods"] as! String
                        ovulationDay = document.data()["ovulationDay"] as! [String]
                        
                    }
                    
                }
                let docRef = self.db.collection("users").document(user.uid)
                
                docRef.getDocument { [self] (document, error) in
                    if let document = document, document.exists {
                        liveAlbums = document.data()!["gender"] as! String
                        
                    }
                }
              
                self.NextPeriodMonth = dataDescription
                self.isPeriod = isPeriodDb
               
                self.lastday  = self.dateFormat3.date(from: self.NextPeriodMonth) ?? self.toDay
               
                
                self.dateFormat4.dateFormat = "d MMM yyyy"
                self.dateFormat4.locale = Locale(identifier: "en_us")
                let aDay  = self.dateFormat4.string(from: self.toDay)
                let sDay = self.dateFormat4.date(from: firstPeriod)
                print("AA")
                print(self.lastday)
                print("BB")
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
//                    print("lastDate",self.lastday)
//                    print(self.daycalculate)

                    self.daycalculate = self.daysBetween(start: self.toDay, end: self.lastday)
                  //  self.daycalculate1 = self.daysBetween(start:sDay!, end: self.toDay)
                    self.daycalculate1 = self.daysBetween(start: self.dateFormat4.date(from: firstPeriod)!, end: self.toDay)
                    //print(self.daycalculate1,"aaaaaa")
                    //  ====     เช็คหลังมีประจำเดือน
                        if self.daycalculate1 >= 7 && self.daycalculate1 <= 8{
                            self.periodTodayYesNo1 = true
                        }else{
                            self.periodTodayYesNo1 = false
                        }
                    // END
                    self.setImageGraphics(days: self.daycalculate)
                  
                }
            }else {
                print("ไม่มีข้อมูล")
            
            }
        }
       
        setImageGraphics(days: daycalculate)
    }
    

    
    func daysBetween(start: Date, end: Date) -> Int {
       return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    func setImageGraphics(days: Int)  {
       
        switch liveAlbums {
        case "famale":
        if (days == 0 || days < 0)  && periodTodayYesNo == false && periodTodayYesNo1 == false {
            statusLabel.text = "วันคาดการประจำเดือนมา"
            textStatusLabel.text = "คาดการวันที่"
            if days == 1 {
                countDownLabel.text = String(days)
            }else{
                countDownLabel.text = String(days*(-1)+1)
            }
           imageUIview.image = UIImage(named:"character206")
           // imageUIview.image = UIImage.gi
            //gifImageWithName("test1_10")
                
         
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
            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
            countDownLabel.text = String(days)
            imageUIview.image = UIImage(named:"character205")
            ovulationDayYesNo = false
        }else{
            statusLabel.text = "ปกติ"
            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
            countDownLabel.text = String(days)
            imageUIview.image = UIImage(named:"character201")
        }
        case "male":
        if (days == 0 || days < 0)  && periodTodayYesNo == false && periodTodayYesNo1 == false {
            statusLabel.text = "วันคาดการประจำเดือนมา"
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
            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
            countDownLabel.text = String(days)
            imageUIview.image = UIImage(named:"character205")
            ovulationDayYesNo = false
        }else{
            statusLabel.text = "ปกติ"
            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
            countDownLabel.text = String(days)
            imageUIview.image = UIImage(named:"character201")
        }
        default:break
            
        }
}
    
    override func viewWillAppear(_ animated: Bool) {
        
       
  //  dbData()
        dbCheck()
      
        
        
        
        
        
         handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                      if Auth.auth().currentUser != nil {
                    // User is signed in.
                        if UserDefaults.standard.string(forKey: "status") == "doctor" {
                            let userMainViewController = self.storyboard?.instantiateViewController(identifier: "profilePage")
                            self.view.window?.rootViewController = userMainViewController
                            self.view.window?.makeKeyAndVisible()
                        }
                      } else {
                    // No user is signed in.
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginVC")
                        self.view.window?.rootViewController = UINavigationController(rootViewController: loginViewController)
                        self.view.window?.makeKeyAndVisible()
                        
                            self.view.window?.makeKeyAndVisible()
                    }
                  }
       
    }
   
}

