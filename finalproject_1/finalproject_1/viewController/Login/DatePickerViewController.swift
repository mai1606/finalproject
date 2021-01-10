//
//  DatePickerViewController.swift
//  finalproject_1
//
//  Created by _maiWeb#15 on 10/21/20.
//  Copyright © 2020 ICTSUIM. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class DatePickerViewController: UIViewController {

    @IBOutlet weak var navigationBar: UILabel!
    @IBOutlet weak var btmSumit: UIButton!
    @IBOutlet weak var dateFirstPicker: UITextField!
    var userName: String = ""
    var userEmail: String = ""
    var userPassword: String = ""
    var gender:String = ""
    var needUser:String = ""
    var colorPage:UIColor?
    var age: Int = 0
    var PeriodDay: Int = 0
    var PeriodMonth: Int = 0
    private var datePicker : UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(DatePickerViewController.dateChanged(datePicker:)), for: .valueChanged)
        dateFirstPicker.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DatePickerViewController.ViewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        dateFirstPicker.inputView = datePicker
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationBar.backgroundColor = UIColor.mainColor
        btmSumit.backgroundColor = UIColor.mainColor
    }
    @objc func ViewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        dateFirstPicker.text = dateFormatter.string(from:datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func handleSumit(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: userEmail, password: userPassword) { (result, err) in
            // เช็คข้อผิดพลาด
            if err != nil {
                //สร้างผู้ใช้ผิดพลาด
                print(err!.localizedDescription)
            }else{

                let db = Firestore.firestore()
                db.collection("users").document(result!.user.uid).setData([
                    "NameUser" : self.userName,
                    "gender" : self.gender,
                    "needUser" : self.needUser,
                    "age" : self.age,
                    "PeriodDay" : self.PeriodDay,
                    "PeriodMonth" : self.PeriodMonth,
                    "uid" : result!.user.uid]){(error) in
                    
                    UserDefaults.standard.set(self.userName, forKey: "userName")
                    UserDefaults.standard.set(self.userEmail, forKey: "userEmail")
                    UserDefaults.standard.set(self.needUser, forKey: "userNeed")
                    UserDefaults.standard.set(self.PeriodDay, forKey: "periodDay")
                    UserDefaults.standard.set(self.PeriodMonth, forKey: "periodMonth")
                    UserDefaults.standard.set(self.age, forKey: "userAge")
                    UserDefaults.standard.set(self.gender, forKey: "userGender")
                    
                    if error != nil {
                        print(error!.localizedDescription)
                    }else {
                        let HomeViewController = self.storyboard?.instantiateViewController(identifier: "startapp")
                        self.view.window?.rootViewController = HomeViewController
                        self.view.window?.makeKeyAndVisible()
                    }
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
