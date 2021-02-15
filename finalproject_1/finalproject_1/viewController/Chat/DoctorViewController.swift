//
//  ChatViewController.swift
//  finalproject_1
//
//  Created by Mai on 17/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class DoctorViewController: UIViewController {
    
    @IBOutlet weak var chatTable: UITableView!
    
    var doctors: [Doctor] = []
    var users: [UserChat] = []
    var uidUsers: [String] = []
    var status: String = ""
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        status = UserDefaults.standard.string(forKey: "status") ?? ""
        //setUp()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        setUp()
       
    }
    
    func setUp()  {
        
//        chatTable.register(DoctorTableViewCell.self, forCellReuseIdentifier: "DoctorTableViewCell")
        chatTable.dataSource = self
        chatTable.delegate = self
        if status == "doctor" , let doctorUid = Auth.auth().currentUser?.uid {
            chatTable.register(UITableViewCell.self, forCellReuseIdentifier: "chatTableViewCell")
            db.collection("Chats").whereField("users", arrayContains: doctorUid).getDocuments(completion: { (data,error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data {
                    self.uidUsers.removeAll()
                    self.users.removeAll()
                    for document in data.documents {
                        let users = document.data()["users"] as? [String]
                        if let uid = users?.first(where: {$0 != doctorUid}) {
                            self.uidUsers.append(uid)
                        }
                    }
                    self.db.collection("users").whereField("uid", in: self.uidUsers).getDocuments(completion: { (data,error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let data = data {
                            for document in data.documents {
                                if let name = document.data()["NameUser"] as? String, let uid = document.data()["uid"] as? String {
                                    self.users.append(UserChat(name: name, uid: uid))
                                }
                            }
                            self.chatTable.reloadData()
                        }
                    })
                }
                })
        } else {
            chatTable.register(UINib(nibName: "DoctorTableViewCell", bundle: nil), forCellReuseIdentifier: "DoctorTableViewCell")
            
            db.collection("users").whereField("status", isEqualTo: "doctor").getDocuments(completion: {
                (data,error) in
                if (error == nil) {
                    self.doctors.removeAll()
                    for document in data!.documents {
                        let name = document.data()["nameDoctor"] as? String
                        let gender = document.data()["gender"] as? String
                        let nameHospital = document.data()["nameHospital"] as? String
                        let nameUniversity = document.data()["nameUniversity"] as? String
                        let history = document.data()["history"] as? [String]
                        let score = document.data()["score"] as? Int
                        let uid = document.data()["uid"] as? String
                        var image = ""
                        if name == "นพ.แสนภูมิพ่าย ขาวประเสริฐ" {
                            image = "Doctor_2"
                        }
                        if name == "พญ.จิรภัทร สุริยะชัยสวัสดิ์" {
                            image = "Doctor_1"
                        }
                        if name == "นพ.นพ ขาวประเสริฐ" {
                            image = "Doctor_3"
                        }
                        
                        self.doctors.append(Doctor(name: name, gender: gender, nameHospital: nameHospital, nameUniversity: nameUniversity, uid: uid, score: Int(score ?? 0), imageDactor:image, history: history ?? []))
                        
    //                    doctor.name = document.data()["nameDoctor"] as! String
    //                    doctor.name = document.data()["nameDoctor"] as! String

    //                   print("",doctorsa)
    //                    let name: String?
    //                    let gender: String?
    //                    let nameHospital:String?
    //                    let nameUniversity:String?
    //                    let uid: String?
    //                    var score: Int
    //                    let history: [String] = []
                    }
                    self.chatTable.reloadData()
                }
                else {
                    print("fffffffffffff")
                }
            })
        }
        
    }
}

extension DoctorViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if status == "doctor" {
            return users.count
        } else {
            return doctors.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if status == "doctor" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatTableViewCell",for: indexPath)
            let user = users[indexPath.row]
            cell.textLabel?.text = user.name
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTableViewCell",for: indexPath) as? DoctorTableViewCell else { return UITableViewCell() }
            let doctor = doctors[indexPath.row]
            cell.configurate(doctor)
            
            
            cell.didClickDoctorButton = { [weak self] in
                guard let strongSelf = self else { return }
                print("test")
            }
            
            return cell
        }
        
        
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChatViewController()
        if status == "doctor" {
            let user = users[indexPath.row]
            vc.user2UID = user.uid
            vc.user2Name = user.name
        } else {
            let doctor = doctors[indexPath.row]
            vc.user2UID = doctor.uid
            vc.user2Name = doctor.name
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
