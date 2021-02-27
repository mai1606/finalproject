//
//  DiseaseIntroductionViewController.swift
//  finalproject_1
//
//  Created by Mai on 15/2/2564 BE.
//  Copyright © 2564 BE ICTSUIM. All rights reserved.
//

import UIKit

class DiseaseIntroductionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var DiseaseTableView1: UITableView!
    var textDisease = ["ช็อกโกแลตซีสต์","โลหิตจาง","ไข้ทับระดู","เนื้องอกในมดลูก","สัญญาณเตือนบอกโรค"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        DiseaseTableView1.delegate = self
        DiseaseTableView1.dataSource = self
        DiseaseTableView1.register(UITableViewCell.self, forCellReuseIdentifier: "DiseaseTableViewcell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return textDisease.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiseaseTableViewcell",for: indexPath)
       // let user = textDisease[indexPath.row]
        cell.textLabel?.text = "test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "DiseaseIntroduction", bundle: nil).instantiateViewController(withIdentifier: "DiseaseImageViewController") as! DiseaseImageViewController
        vc.disease = textDisease[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


