//
//  Detail2CollectionViewCell.swift
//  finalproject_1
//
//  Created by Mai on 23/2/2564 BE.
//  Copyright © 2564 BE ICTSUIM. All rights reserved.
//

import UIKit

class Detail2CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func setupImage(detail: Detail?) {
        detailImage.image = detail?.selectedImage
        descrLabel.text = detail?.descr
    }
}
