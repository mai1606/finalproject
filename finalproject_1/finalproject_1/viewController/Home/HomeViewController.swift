//
//  HomeViewController.swift
//  finalproject_1
//
//  Created by _maiWeb#15 on 10/20/20.
//  Copyright © 2020 ICTSUIM. All rights reserved.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    private var handle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var imageUIview: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var textStatusLabel: UILabel!
    
    @IBOutlet weak var countDownLabel: UILabel!
    let dateFormat = DateFormatter()
    let dateFormat2 = DateFormatter()
    var numCount = 0
    var period = true
    var toDay = Date.currentDate()
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormat.dateFormat = "EEEE, d MMM"
        dateFormat.calendar = Calendar(identifier: .buddhist)
        dateFormat.locale = Locale(identifier: "th_TH")
        todayLabel.text = dateFormat.string(from: toDay)
    
        dateFormat2.dateFormat = "d"
        numCount = 0
        var a2 = dateFormat2.string(from: toDay)
        var num2 = 0
        numCount = 30 - Int(a2)!
        countDownLabel.text = String(numCount)
        setImageGraphics()
        
        let days = daysBetween(start: toDay, end: Date.currentDateFromString(strDate: "12/01/2564"))
        print(days)
    }
    
    func daysBetween(start: Date, end: Date) -> Int {
       return Calendar.current.dateComponents([.day], from: start, to: end).day!
    }
    
    func setImageGraphics()  {
        if(numCount == 0 && numCount < 0){
            statusLabel.text = "วันคาดการประจำเด็นมา"
            textStatusLabel.text = "คาดการวันที่"
            imageUIview.image = UIImage(named:"character202")
            if(period){
                statusLabel.text = "ระหว่างประจำเดือน"
                textStatusLabel.text = "เป็นประจำเดือนวันที่"
                imageUIview.image = UIImage(named:"character202")
            }
        }
        else if(numCount >= 0 && numCount < 7){
            statusLabel.text = "ก่อนประจำเดือนมา"
            imageUIview.image = UIImage(named:"character206")
        }else if(numCount >= 8 && numCount < 12){
            statusLabel.text = "หลังประจำเดือนมา"
            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
            imageUIview.image = UIImage(named:"character203")
        }else if(numCount >= 12 && numCount < 14){
            statusLabel.text = "ช่วงไข่สุก"
            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
            imageUIview.image = UIImage(named:"character205")
        }else if(numCount >=  14 && numCount < 15){
            statusLabel.text = "วันไข่ตก"
            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
            imageUIview.image = UIImage(named:"character204")
        }else{
            statusLabel.text = "ปกติ"
            textStatusLabel.text = "ประจำเดือนจะมาในอีก"
            imageUIview.image = UIImage(named:"character201")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
