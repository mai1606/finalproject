//
//  UserModifyViewController.swift
//  finalproject_1
//
//  Created by Mai on 2/2/2564 BE.
//  Copyright © 2564 BE ICTSUIM. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserModifyViewController: UIViewController {
    
    
    @IBOutlet weak var userWBtn: UILabel!
    @IBOutlet weak var userMBtn: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var Btn1: UIButton!
    @IBOutlet weak var Btn2: UIButton!
    @IBOutlet weak var Btn3: UIButton!
    @IBOutlet weak var b: UIView!
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    var  userName :String = ""
    var gender :String = ""
    var  needUser :String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        setUp()
    }
    func setUp()  {
        Btn1.isEnabled = true
        Btn2.isEnabled = true
        b.backgroundColor = UIColor.white
        b.layer.cornerRadius = 20
       // b.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner ]
        b.layer.shadowColor = UIColor.black.cgColor
        b.layer.shadowOffset = .zero
        b.layer.shadowRadius = 20
        b.layer.shadowOpacity = 0.1
        userWBtn.layer.cornerRadius = 10
        userWBtn.backgroundColor = UIColor(named: "Color_main1")
        userMBtn.layer.cornerRadius = 10
        Btn1.layer.cornerRadius = 10
        Btn2.layer.cornerRadius = 10
        Btn3.layer.cornerRadius = 10
        setUpData()
    }
    func setUpData(){
        let docRef = db.collection("users").document(user!.uid)
        
        docRef.getDocument { [self] (document, error) in
            if let document = document, document.exists {
                userName = document.data()!["NameUser"] as! String
                gender = document.data()!["gender"] as! String
                needUser = document.data()!["needUser"] as! String
                textField.text = userName
                if gender == "female" {
                    userMBtn.backgroundColor = .white
                    userWBtn.backgroundColor = UIColor(named: "Color_main1")
                }else {
                    userWBtn.backgroundColor = .white
                    userMBtn.backgroundColor = UIColor(named: "Color_main2")
                }
                if needUser == "พร้อมมีบุตร"{
                    Btn2.backgroundColor = UIColor(named: "Color_main1")
                    Btn1.backgroundColor = .white
                }else {
                   // "ติดตามรอบเดือน"
                    Btn1.backgroundColor = UIColor(named: "Color_main1")
                    Btn2.backgroundColor = .white
                }
                UserDefaults.standard.set(self.userName, forKey: "userName")
                UserDefaults.standard.set(self.needUser, forKey: "userNeed")
                UserDefaults.standard.set(self.gender, forKey: "userGender")
                
                
            } else {
                print("ไม่มีข้อมูลมา ไม่พบข้อมูล")
               
            }
        }
    }
    @IBAction func setTextName(_ sender: Any) {
//        if textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
//            //userName = textField.text!
//        }
    }
    
    @IBAction func userwBtn(_ sender: UIButton) {
        showLoading()
        if sender.tag == 0 {
            userMBtn.backgroundColor = .white
            userWBtn.backgroundColor = UIColor(named: "Color_main1")
            gender = "female"
        }
        if sender.tag == 1 {
            userWBtn.backgroundColor = .white
            userMBtn.backgroundColor = UIColor(named: "Color_main2")
            gender = "male"
            
        }
        if sender.tag == 2 {
            Btn1.backgroundColor = UIColor(named: "Color_main1")
            Btn2.backgroundColor = .white
           
            needUser = "ติดตามรอบเดือน"
        }
        if sender.tag == 3 {
            Btn2.backgroundColor = UIColor(named: "Color_main1")
            Btn1.backgroundColor = .white
            needUser = "พร้อมมีบุตร"
            
        }
        if sender.tag == 4 {
            Btn2.backgroundColor = UIColor(named: "Color_main1")
            Btn1.backgroundColor = .white
            needUser = "พร้อมมีบุตร"
            
        }
        if sender.tag == 5 {
            guard let nameUser = textField.text else {return}
//            UserDefaults.standard.set(self.userName, forKey: "userName")
//            UserDefaults.standard.set(self.needUser, forKey: "userNeed")
//            UserDefaults.standard.set(self.gender, forKey: "userGender")
            db.collection("users").document(user!.uid).updateData(["NameUser":  nameUser,"gender":gender,"needUser":needUser])
            setUpData()
            self.navigationController?.popViewController(animated: true)
            
        }
        hideLoading()
    }


}
