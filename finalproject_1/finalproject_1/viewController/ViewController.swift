//
//  ViewController.swift
//  finalproject_1
//
//  Created by _maiWeb#15 on 10/20/20.
//  Copyright © 2020 ICTSUIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        utilities.setColor(check: true)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }

}

