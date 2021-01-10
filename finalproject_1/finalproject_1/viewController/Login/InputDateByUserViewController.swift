//
//  InputDateByUserViewController.swift
//  finalproject_1
//
//  Created by _maiWeb#15 on 10/21/20.
//  Copyright © 2020 ICTSUIM. All rights reserved.
//

import UIKit
import DropDown
import FirebaseAuth
import Firebase
import FirebaseFirestore


class InputDateByUserViewController: UIViewController {
    
    
    @IBOutlet weak var navigationBar: UILabel!
    
    @IBOutlet weak var btmFemale: UIButton!
    
    @IBOutlet weak var btmMale: UIButton!
    
    @IBOutlet weak var btmDropDownAge: UIButton!
    
    @IBOutlet weak var btnDropDown1: UIButton!
    
    @IBOutlet weak var btnDropDown2: UIButton!
    
    @IBOutlet weak var btmSumit: UIButton!
    
    @IBOutlet weak var btmNeedUser1: UIButton!
    
    @IBOutlet weak var btmNeedUser2: UIButton!
    @IBOutlet weak var uiBackgriundInput: UIView!
    @IBOutlet weak var uiBackgriundInput2: UIView!
    
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    var dropDownageVariable:Int = 2541
    var dropDownPeriodDayVariable:Int = 5
    var dropDownPeriodMonthVariable:Int = 28
    var userName: String = ""
    var userEmail: String = ""
    var userPassword: String = ""
    var gender:String = ""
    var needUser:String = ""
    var colorPage:UIColor = .mainColorFemale
    let db = Firestore.firestore()
    
    let menuF: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "2540" ,
            "2541" ,
            "2542" ,
            "2543" ,
            "2544" ,
            "2545" ,
            "2546" ,
            "2547" ,
            "2548" ,
        ]
        return menu
    }()
    let menuF1: DropDown = {
        let menu1 = DropDown()
        menu1.dataSource = [
            "1" ,
            "2" ,
            "3" ,
            "4" ,
            "5" ,
            "6" ,
            "7" ,
        ]
        return menu1
    }()
    let menuF2: DropDown = {
        let menu1 = DropDown()
        menu1.dataSource = [
            "20" ,
            "21" ,
            "22" ,
            "23" ,
            "24" ,
            "25" ,
            "26" ,
            "27" ,
            "28" ,
            "29" ,
            "30" ,
        ]
        return menu1
    }()

    override func viewDidLoad() {
        uiBackgriundInput.backgroundColor = UIColor.white
        uiBackgriundInput.layer.cornerRadius = 20
        uiBackgriundInput.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner ]
        uiBackgriundInput.layer.shadowColor = UIColor.black.cgColor
        uiBackgriundInput.layer.shadowOffset = .zero
        uiBackgriundInput.layer.shadowRadius = 20
        uiBackgriundInput.layer.shadowOpacity = 0.1
        uiBackgriundInput2.backgroundColor = UIColor.white
        uiBackgriundInput2.layer.cornerRadius = 20
        uiBackgriundInput2.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner ]
        uiBackgriundInput2.layer.shadowColor = UIColor.black.cgColor
        uiBackgriundInput2.layer.shadowOffset = .zero
        uiBackgriundInput2.layer.shadowRadius = 20
        uiBackgriundInput2.layer.shadowOpacity = 0.1
        
        super.viewDidLoad()
        let myview = UIView(frame: navigationController?.navigationBar.frame ?? .zero)
        navigationController?.navigationBar.topItem?.titleView = myview
        guard let topView =  navigationController?.navigationBar.topItem?.titleView else {
            return
        
            
        FirebaseApp.configure()
        
    
         
        }
        let gestue = UITapGestureRecognizer(target: self, action: #selector(didTapTopItem))
        gestue.numberOfTouchesRequired = 1
        gestue.numberOfTapsRequired = 1
        topView.addGestureRecognizer(gestue)
        // Do any additional setup after loading the view.
        menuF.selectionAction = { index ,title in
           print("index\(index),Title\(title)")
            self.btmDropDownAge.setTitle(title, for: .normal)
            self.dropDownageVariable = (title as NSString).integerValue
            print("ค่า\(self.dropDownageVariable)")
        }
        menuF1.selectionAction = { index ,title in
           print("index\(index),Title\(title)")
             self.btnDropDown1.setTitle(title, for: .normal)
            self.dropDownPeriodDayVariable = (title as NSString).integerValue
            print("ค่า1 \(self.dropDownPeriodDayVariable)")
        }
        menuF2.selectionAction = { index ,title in
           print("index\(index),Title\(title)")
             self.btnDropDown2.setTitle(title, for: .normal)
            self.dropDownPeriodMonthVariable = (title as NSString).integerValue
            print("ค่า2 \(self.dropDownPeriodMonthVariable)")
        }
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        print("===========>" + userName + "=======>" + userEmail)
//    }
    
    @IBAction func genderBtnUser(_ sender: Any) {
       
       
        if (sender as AnyObject).tag == 1{
            gender = "female"
            colorPage = .mainColorFemale
            print("ค่า2 \(gender)")
            btmFemale.backgroundColor = colorPage
            btmMale.backgroundColor = .white
            
            navigationBar.backgroundColor = colorPage
            btmDropDownAge.backgroundColor = colorPage
            btnDropDown1.backgroundColor = colorPage
            btnDropDown2.backgroundColor = colorPage
            btmSumit.backgroundColor = colorPage
            btmNeedUser1.backgroundColor = colorPage
            btmNeedUser2.backgroundColor = .white
            switch1.thumbTintColor = colorPage
            switch2.thumbTintColor = colorPage
        }
        if (sender as AnyObject).tag == 0{
           gender = "male"
            colorPage = .mainColorMale
            print("ค่า2 \(gender)")
            btmFemale.backgroundColor = .white
            btmMale.backgroundColor = colorPage
            navigationBar.backgroundColor = colorPage
            btmDropDownAge.backgroundColor = colorPage
            btnDropDown1.backgroundColor = colorPage
            btnDropDown2.backgroundColor = colorPage
            btmSumit.backgroundColor = colorPage
            btmNeedUser1.backgroundColor = colorPage
            btmNeedUser2.backgroundColor = .white
            switch1.thumbTintColor = colorPage
            switch2.thumbTintColor = colorPage
            
        }
    }
    
    
    @IBAction func needUser(_ sender: Any) {
        if (sender as AnyObject).tag == 1{
            needUser = "ติดตามรอบเดือน"
             print("ความต้องการ \(needUser)")
            btmNeedUser1.backgroundColor = colorPage
            btmNeedUser2.backgroundColor = .white
        
        }
        if (sender as AnyObject).tag == 2{
            needUser = "พร้อมมีบุตร"
             print("ความต้องการ \(needUser)")
            btmNeedUser1.backgroundColor = .white
            btmNeedUser2.backgroundColor = colorPage
        }
        
    }
    
    @objc func didTapTopItem()  {
        menuF.show()
    }
    
    @IBAction func handleDropDown(_ sender: UIButton) {
        menuF.show()
        
    }
    
    @IBAction func dropDownPeriodDay(_ sender: Any) {
         menuF1.show()
    }
    @IBAction func dropDownPeriodMonth(_ sender: Any) {
          menuF2.show()
    }
    
    
    @IBAction func SaveData(_ sender: Any) {
        
        if gender == "female" {
            utilities.setColor(check: true)
        }else {
            utilities.setColor(check: false)
        }

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DatePickerViewController") as! DatePickerViewController
        vc.userName = userName
        vc.userEmail = userEmail
        vc.userPassword = userPassword
        vc.gender = gender
        vc.needUser = needUser
        vc.colorPage = colorPage
        vc.age = dropDownageVariable 
        vc.PeriodDay = dropDownPeriodDayVariable
        vc.PeriodMonth = dropDownPeriodMonthVariable
        navigationController?.pushViewController(vc,
        animated: true)
        
//        db.collection("users").document("0x6LZRL1zD0FsLwQJzuz").updateData([
//           "gender": gender ,
//            "age" :dropDownageVariable ,
//            "needUser" : needUser,
//            "PeriodDay" :dropDownPeriodDayVariable ,
//            "PeriodMonth" :dropDownPeriodMonthVariable ,
//        ]) { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//            } else {
//                print("Document successfully written!")
//            }
//        }

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
