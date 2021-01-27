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
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var titalLabel: UILabel!
    
    @IBOutlet weak var imageDoctor: UIImageView!
    @IBOutlet weak var nameDoctor: UILabel!
    
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var hospitaliLabel: UILabel!    
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var titalBackground: UIView!
    var didClickDoctorButton: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        talkButton.addTarget(self, action: #selector(talkButtonTapped), for: .touchUpInside)
        imageDoctor.layer.cornerRadius = 30
        titalBackground.layer.cornerRadius = 10
        background.layer.cornerRadius = 20
        background.backgroundColor = .white
        background.layer.shadowColor = UIColor.black.cgColor
        background.layer.shadowOffset = .zero
        background.layer.shadowRadius = 30
        background.layer.shadowOpacity = 0.3
        //talkButton.layer.cornerRadius = 10
        talkButton.roundCorners(corners: [.topLeft, .bottomLeft], radius: 20)
        reviewButton.roundCorners(corners: [.bottomRight, .topRight], radius: 50)
        
        
        doctorNameLabel.font = UIFont(name: "Kanit-Light", size: UIFont.labelFontSize)
        titalLabel.font = UIFont(name: "Kanit-Light", size: UIFont.labelFontSize)
        nameDoctor.font = UIFont(name: "Kanit-Light", size: UIFont.labelFontSize)
        hospitaliLabel.font = UIFont(name: "Kanit-Light", size: UIFont.labelFontSize)
        universityLabel.font = UIFont(name: "Kanit-Light", size: UIFont.labelFontSize)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configurate(_ doctor: Doctor) {
        doctorNameLabel.text = doctor.name
    }
    
    @objc func talkButtonTapped() {
        didClickDoctorButton?()
    }
    
}
