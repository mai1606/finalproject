//
//  ChatViewController.swift
//  finalproject_1
//
//  Created by Mai on 17/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit

class DoctorViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var chatTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    setUp()
    }
    
    func setUp()  {
        ////chatTable.register(UITableVieell.self, forCellReuseIdentifier: "cell")
        chatTable.dataSource = self
        chatTable.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "test20"
            
        } else {
            cell.textLabel?.text = "test15"
        }
        
        return cell
        
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //show chat messages
        let vc = ChatViewController()
        vc.title = "Chat"
        if indexPath.row == 0 {
            vc.user2UID = "g7aOSF7KUMTc116j4efExMqBFPm1"
            vc.user2Name = "test20"
        } else {
            vc.user2UID = "kCmCGsyXFnMgacdyuR6wk0oiveJ3"
            vc.user2Name = "test15"
            
        }
        
        
        navigationController?.pushViewController(vc, animated: true)
    }


}
