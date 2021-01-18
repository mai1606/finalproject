//
//  DoctorTableViewCell.swift
//  finalproject_1
//
//  Created by Mai on 17/1/2564 BE.
//  Copyright © 2564 BE ICTSUIM. All rights reserved.
//

import UIKit

class DoctorTableViewCell: UITableViewCell {

    @IBOutlet weak var talkButton: UIButton!
    @IBOutlet weak var doctorNameLabel: UILabel!
    
    var didClickDoctorButton: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        talkButton.addTarget(self, action: #selector(talkButtonTapped), for: .touchUpInside)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurate(name: String) {
        doctorNameLabel.text = name
    }
    
    @objc func talkButtonTapped() {
        didClickDoctorButton?()
    }
    
}
