//
//  Detail.swift
//  finalproject_1
//
//  Created by Mai on 1/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit

enum DetailType {
    case emotion
    case sympton
    case content
    case sex
    case leucorrhoea
}

struct Detail {
    let image: UIImage?
    let selectedImage: UIImage?
    let descr: String?
    let type: DetailType?
    var isSelected: Bool = false
}

struct ArrayDetail {
    var arrayDateDetail:String?
}
