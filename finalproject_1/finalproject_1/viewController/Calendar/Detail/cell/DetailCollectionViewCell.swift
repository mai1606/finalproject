//
//  DetailCollectionViewCell.swift
//  finalproject_1
//
//  Created by Mai on 1/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var descrLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
//    override var isSelected: Bool {
//        didSet {
////           print("Test")
//        }
   // }
    
    
    func setup(detail: Detail?) {
//        self.isSelected = detail?.isSelected ?? false
        descrLabel.text = detail?.descr
        detailImage.image = detail?.isSelected ?? false ? detail?.selectedImage : detail?.image
    }
    func setupImage(detail: Detail?) {
        detailImage.image = detail?.selectedImage
        descrLabel.text = " "
    }
    
    func setupSelected(detail: Detail) {
        detailImage.image = detail.isSelected ? detail.selectedImage : detail.image
    }

}
