//
//  ChatViewController.swift
//  finalproject_1
//
//  Created by Mai on 17/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit
import Firebase

class DoctorViewController: UIViewController {
    
    @IBOutlet weak var chatTable: UITableView!
    
    var doctors: [Doctor] = []
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp()  {
        
//        chatTable.register(DoctorTableViewCell.self, forCellReuseIdentifier: "DoctorTableViewCell")
        chatTable.dataSource = self
        chatTable.delegate = self
        chatTable.register(UINib(nibName: "DoctorTableViewCell", bundle: nil), forCellReuseIdentifier: "DoctorTableViewCell")
        
//        let docRef = db.collection("users").whereField("status", in: ["Doctor"]).getDocuments(completion: {
//            (data,error) in
//
//        })
    }
}

extension DoctorViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorTableViewCell",for: indexPath) as? DoctorTableViewCell else { return UITableViewCell() }
//        var doctor = doctors[indexPath.row]
        if indexPath.row == 0 {
//            cell.textLabel?.text = "test20"
            cell.configurate(name: "test20")
        } else {
//            cell.textLabel?.text = "test15"
            cell.configurate(name: "test15")
        }
        
        cell.didClickDoctorButton = { [weak self] in
            guard let strongSelf = self else { return }
            print("test")
        }
        
        return cell
        
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        var doctor = doctors[indexPath.row]
        //show chat messages
        let vc = ChatViewController()
        vc.title = "Chat"
        vc.user2UID = doctor.uid
        vc.user2Name = doctor.name
//        if indexPath.row == 0 {
//            vc.user2UID = "g7aOSF7KUMTc116j4efExMqBFPm1"
//            vc.user2Name = "test20"
//        } else {
//            vc.user2UID = "kCmCGsyXFnMgacdyuR6wk0oiveJ3"
//            vc.user2Name = "test15"
//        }
        
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
