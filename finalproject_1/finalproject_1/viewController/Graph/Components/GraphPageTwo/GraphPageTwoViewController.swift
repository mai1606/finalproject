//
//  GraphPageTwoViewController.swift
//  finalproject_1
//
//  Created by KANTAPONG UTTARAWICHIEN on 14/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit
import FirebaseAuth
import Foundation
import Firebase

class GraphPageTwoViewController: UIViewController {
    
    
    @IBOutlet weak var dayLabal: UILabel!

    @IBOutlet weak var noSexProgressView: UIProgressView!
    @IBOutlet weak var noSexLabel: UILabel!
    @IBOutlet weak var noSexView: UIView!
    
    @IBOutlet weak var sexProgressView: UIProgressView!

    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    var toDay = Date.currentDate()
    @IBOutlet weak var protectProgressView: UIProgressView!
    @IBOutlet weak var protectLabel: UILabel!
    
    let dateFormat = DateFormatter()
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    var countSex : Float = 0.0
    var countNoSex : Float = 0.0
    var countProtectSex : Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = .zero
        backgroundView.layer.shadowRadius = 20
        backgroundView.layer.shadowOpacity = 0.1
        dateFormat.dateFormat = "MMMM yyyy"
        dateFormat.locale = Locale(identifier: "th_TH")
        dayLabal.text = dateFormat.string(from: toDay)
        
       // noSexProgressView.layer.cornerRadius
 
        noSexProgressView.layer.borderWidth = 2
        noSexView.layer.cornerRadius = 10
        noSexProgressView.layer.cornerRadius = 10
        noSexProgressView.layer.masksToBounds = true
        
        noSexProgressView.layer.borderColor = UIColor.orange.cgColor
        
        sexProgressView.layer.borderWidth = 2
        //sexLabel.layer.cornerRadius = 10
        
        sexProgressView.layer.cornerRadius = 10
        //sexProgressView.tintColor = UIColor.blue
        sexProgressView.layer.borderColor = UIColor.orange.cgColor
        sexProgressView.layer.masksToBounds = true
        
        protectProgressView.layer.borderWidth = 2
        protectProgressView.layer.cornerRadius = 10
        protectProgressView.layer.borderColor = UIColor.orange.cgColor
        protectProgressView.layer.masksToBounds = true
    
    }
    override func viewWillAppear(_ animated: Bool) {
        //รีค่า
        countSex = 0.0
        countNoSex = 0.0
        countProtectSex = 0.0
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd MMM yyyy"
        
        db.collection("users").document(user!.uid).collection("date").getDocuments() {
            (data, errorr) in
            if (errorr == nil) {
                var setDetails : [String] = []
                var setDay : String = ""
                for  document in data!.documents {
                   // setDetails.append(contentsOf: document.data()["Detail"] as! [String])
                    setDetails = document.data()["Detail"] as! [String]
                    setDay = document.data()["Day"] as! String
                    //เริ่ม
                    let day =  dateFormatter1.string(from: self.toDay)
                    
                    let month = String(setDay.split(separator: " ")[1])+String(setDay.split(separator: " ")[2])
                    
                    let month1 = String(day.split(separator: " ")[1])+String(day.split(separator: " ")[2])
                    //เปรียบเทียบเดือนจบ
                    //print(month,month1)
                    if month == month1 {
                        for setDetail in setDetails {
                            if (setDetail == "ป้องกัน" ){
                                self.countProtectSex = self.countProtectSex + 1
                                
                                //print("Count", self.countSex)
                            }
                            if (setDetail == "ไม่ป้องกัน" ){
                                self.countSex = self.countSex + 1
                                
                               // print("countSex", self.countSex)
                            }
                            if (setDetail == "ไม่มี" ){
                                self.countNoSex = self.countNoSex + 1
                                
                               // print("countNoSex", self.countSex)
                            }
                        }
                    }
                    
                    self.setProgress()
                }
            } else {
                print(errorr!)
            }
        }
    }
    
    func setProgress() {
        let setData0: Float = countNoSex/30
        let setData1: Float = countSex/30
        let setData2: Float = countProtectSex/30
        //print(setData2,setData0,setData1)
        
        noSexLabel.text = String(Int(countNoSex))+"  "
        sexLabel.text = String(Int(countSex))+"  "
        protectLabel.text = String(Int(countProtectSex))+"  "
        
        noSexProgressView.progress = setData0
        sexProgressView.progress = setData1
        protectProgressView.progress = setData2
    }
    
    func dbFirebase(){
//        let docRef = db.collection("users").document(user!.uid).collection("date").document()
//        docRef.getDocument{ (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
            
//            db.collection("users").document(user!.uid).collection("date").getDocument(){ (querySnapshot, err) in
//                if let err = err {
//                    print("Error getting documents: \(err)")
//                } else {
//                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
//                    }
//                }
//            }
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
