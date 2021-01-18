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
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
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
