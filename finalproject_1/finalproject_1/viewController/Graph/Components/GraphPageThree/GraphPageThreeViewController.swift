//
//  GraphPageThreeViewController.swift
//  finalproject_1
//
//  Created by KANTAPONG UTTARAWICHIEN on 15/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit

class GraphPageThreeViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    let test: [String] = ["test"]
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.cornerRadius = 20
        var disease: [Disease] = DiseaseConfigurator.getDisease()
        
        for tt in test {
            for (index, dd) in disease.enumerated() {
                if dd.symptom.contains(tt) || dd.emotion.contains(tt) {
                    disease[index].count = disease[index].count + 1
                }
            }
        }
        // Do any additional setup after loading the view.
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
