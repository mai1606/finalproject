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
    
    func setup(detail: Detail?) {
        descrLabel.text = detail?.descr
        detailImage.image = detail?.image
    }
    func setupImage(detail: Detail?,X: String) {
        if (detail?.descr == X){
        detailImage.image = detail?.image
        descrLabel.text = detail?.descr
        }else{
            detailImage.image = nil
            descrLabel.text = nil
        }
    }
    
    func setupSelected(detail: Detail) {
        detailImage.image = detail.isSelected ? detail.selectedImage : detail.image
    }

}
