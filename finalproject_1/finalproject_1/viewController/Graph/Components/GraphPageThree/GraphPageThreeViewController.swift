//
//  GraphPageThreeViewController.swift
//  finalproject_1
//
//  Created by KANTAPONG UTTARAWICHIEN on 15/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit
import FirebaseAuth
import Foundation
import Firebase

class GraphPageThreeViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var backgroundView2: UIView!
    @IBOutlet weak var diseaseProgressView1: UIProgressView!
    @IBOutlet weak var diseaseLabel1: UILabel!
    
    @IBOutlet weak var diseaseProgressView2: UIProgressView!
    @IBOutlet weak var diseaseLabel2: UILabel!
    
    @IBOutlet weak var diseaseProgressView3: UIProgressView!
    @IBOutlet weak var diseaseLabel3: UILabel!
    
    @IBOutlet weak var diseaseProgressView4: UIProgressView!
    @IBOutlet weak var diseaseLabel4: UILabel!
    
    @IBOutlet weak var diseaseProgressView5: UIProgressView!
    
    let test: [String] = ["test"]
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    var toDay = Date.currentDate()
    var disease: [Disease] = DiseaseConfigurator.getDisease()
    var emotion1: [Emotion] = DiseaseConfigurator.getEmotion()
    var daycount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
       
        
       
        
    }
    func setup() {
        backgroundView.layer.cornerRadius = 20
        backgroundView.layer.shadowColor = UIColor.black.cgColor
        backgroundView.layer.shadowOffset = .zero
        backgroundView.layer.shadowRadius = 20
        backgroundView.layer.shadowOpacity = 0.1
        backgroundView2.layer.cornerRadius = 20
        backgroundView2.layer.shadowColor = UIColor.black.cgColor
        backgroundView2.layer.shadowOffset = .zero
        backgroundView2.layer.shadowRadius = 20
        backgroundView2.layer.shadowOpacity = 0.1
        
        diseaseProgressView1.layer.cornerRadius = 10
        diseaseProgressView1.backgroundColor = .white      
        diseaseProgressView1.layer.borderColor = UIColor.orange.cgColor
        diseaseProgressView1.layer.masksToBounds = true
        
        diseaseProgressView2.layer.cornerRadius = 10
       // diseaseProgressView2.backgroundColor = .white
        diseaseProgressView2.layer.borderColor = UIColor.orange.cgColor
        diseaseProgressView2.layer.masksToBounds = true
        
        diseaseProgressView3.layer.cornerRadius = 10
        diseaseProgressView3.backgroundColor = .white
        diseaseProgressView3.layer.borderColor = UIColor.orange.cgColor
        diseaseProgressView3.layer.masksToBounds = true
        
        diseaseProgressView4.layer.cornerRadius = 10
        diseaseProgressView4.backgroundColor = .white
        diseaseProgressView4.layer.borderColor = UIColor.orange.cgColor
        diseaseProgressView4.layer.masksToBounds = true
       
        diseaseProgressView5.layer.cornerRadius = 10
        diseaseProgressView5.backgroundColor = .white
        diseaseProgressView5.layer.borderColor = UIColor.orange.cgColor
        diseaseProgressView5.layer.masksToBounds = true
        
        diseaseLabel4.font = UIFont(name: "Kanit-Light", size: UIFont.labelFontSize)
        diseaseLabel1.font = UIFont(name: "Kanit-Light", size: UIFont.labelFontSize)
        diseaseLabel2.font = UIFont(name: "Kanit-Light", size: UIFont.labelFontSize)
        diseaseLabel3.font = UIFont(name: "Kanit-Light", size: UIFont.labelFontSize)
    }
    override func viewWillAppear(_ animated: Bool){
           
            self.disease = DiseaseConfigurator.getDisease()
            self.emotion1 = DiseaseConfigurator.getEmotion()
        
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "dd MMM yyyy"
            
            db.collection("users").document(user!.uid).collection("date").getDocuments() {
                (data, errorr) in
                if (errorr == nil) {
                    var setDetails : [String] = []
                    var setDay : String = ""
                   
                    //self.datcount = data!.documents.count
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
                            
                            for DetailsUser in setDetails {
                                for (index, dd) in self.disease.enumerated() {
                                   
                                    if dd.symptom.contains(DetailsUser) || dd.emotion.contains(DetailsUser) {
                                        self.disease[index].count = self.disease[index].count + 1
                                       // print( self.disease[index].count,"  ")
                                    }
                                }
                                for (index, dd) in self.emotion1.enumerated() {
                                   
                                    if dd.emotion.contains(DetailsUser){
                                        self.emotion1[index].count = self.emotion1[index].count + 1
                                        print("ฟฟฟหฟกฟหกฟหกฟกห",self.emotion1[index].count)
                                    }
                                }
                            }
                            self.daycount += 1
                            
                        }else{
                            
                        }
                        
                     
                    }
                } else {
                    print(errorr!)
                }
                print("นับวันที่",self.daycount)
                self.calculateDisease()
            }
    }
    func calculateDisease() {
       // print(self.datcount)
        for (index, tt) in disease.enumerated(){
            disease[index].sumCount = (tt.count/7)/Float(tt.symptom.count)
        }
        for (index, tt) in emotion1.enumerated(){
            emotion1[index].sumCount = (tt.count/Float(daycount))/Float(tt.emotion.count)
        }
       // print("XXX=====>",disease)
        disease.sort {$0.sumCount > $1.sumCount}
        let arraySlice = disease[..<4]
        //print(arraySlice)
        for (index, tt) in arraySlice.enumerated(){
            if index == 0 {
                diseaseProgressView1.progress = tt.sumCount
                diseaseLabel1.text = tt.name
                setColor(Name: diseaseProgressView1, num: tt.sumCount)
            }else if index == 1 {
                diseaseProgressView2.progress = tt.sumCount
                diseaseLabel2.text = tt.name
                setColor(Name: diseaseProgressView2, num: tt.sumCount)
            }else if index == 2 {
                diseaseProgressView3.progress = tt.sumCount
                diseaseLabel3.text = tt.name
                setColor(Name: diseaseProgressView3, num: tt.sumCount)
            }else{
                
                diseaseProgressView4.progress = tt.sumCount
                diseaseLabel4.text = tt.name
                setColor(Name: diseaseProgressView4, num: tt.sumCount)
            }
            emotion1.sort {$0.sumCount > $1.sumCount}
            let arraySlice2 = emotion1[..<1]
           //print(arraySlice2)
            for tt in arraySlice2{
                if tt.name == "อารมณ์ปกติ" {
                    diseaseProgressView5.progress = 0.3
                    setColor(Name: diseaseProgressView5, num: 0.3)
                    
                }else if tt.name == "อารมณ์แปรปรวน"{
                    diseaseProgressView5.progress = 0.5
                    setColor(Name: diseaseProgressView5, num: 0.5)
                }else {
                    diseaseProgressView5.progress = 1
                    setColor(Name: diseaseProgressView5, num: 1)
                }
                
            }
           
           
        }
//        diseaseProgressView1
//        diseaseLabel1
//        diseaseProgressView2
//        diseaseLabel2
//        diseaseProgressView3
//        diseaseLabel3
//        diseaseProgressView4
//        diseaseLabel4
    }
    func setColor(Name:UIProgressView ,num: Float){
        if num < 0.5 {
            Name.tintColor = UIColor(named: "Color_main4")
        }
        else if num >= 0.5 &&  num < 0.8 {
            Name.tintColor = UIColor(named: "Color_main1")
        }else{
            Name.tintColor = UIColor(named: "Color_main3")
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
