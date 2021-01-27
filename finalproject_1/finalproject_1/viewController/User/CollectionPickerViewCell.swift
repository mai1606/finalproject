//
//  CollectionPickerViewCell.swift
//  finalproject_1
//
//  Created by Mai on 4/2/2564 BE.
//  Copyright © 2564 BE ICTSUIM. All rights reserved.
//

import UIKit

class CollectionPickerViewCell: UICollectionViewCell {
    var label: UILabel!
    var font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    var highlightedFont = UIFont.systemFont(ofSize: UIFont.systemFontSize)
    override var isSelected: Bool {
        didSet {
            let animation = CATransition()
            animation.type = CATransitionType.fade
            animation.duration = 0.15
            self.label.layer.add(animation, forKey: "")
            self.label.font = self.isSelected ? self.highlightedFont : self.font
        }
    }
    
    func initialize() {
        self.layer.isDoubleSided = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.label = UILabel(frame: self.contentView.bounds)
        self.label.backgroundColor = UIColor.clear
        self.label.textAlignment = .center
        self.label.textColor = UIColor.gray
        self.label.numberOfLines = 1
        self.label.lineBreakMode = .byTruncatingTail
        self.label.highlightedTextColor = UIColor.black
        self.label.font = self.font
        self.label.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin, .flexibleRightMargin]
        self.contentView.addSubview(self.label)
        
    }
    
    init() {
        super.init(frame: CGRect.zero)
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init!(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
}
