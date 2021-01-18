//
//  DiseaseConfigurator.swift
//  finalproject_1
//
//  Created by Mai on 17/1/2564 BE.
//  Copyright © 2564 BE ICTSUIM. All rights reserved.
//

import Foundation


class DiseaseConfigurator {
    static func getDisease() -> [Disease] {
        return [
            Disease(name: "โรคโลหิตจาง", symptom: ["ปริมาณมาก"]),
            Disease(name: "โรคช็อกโกแลตซีสต์", symptom: ["ปริมาณมาก","ปวดท้อง","ศีรษะ"], emotion: ["test"]),
            Disease(name: "เนื้องอกมดลูก", symptom: ["ปริมาณมาก","ปวดท้อง"]),
            Disease(name: "เนื้องอกในรังไข่", symptom: ["ศีรษะ","ประจำเดือนเลื่อน"]),
            Disease(name: "โรคต่อมใต้สมองขาดเลือด", symptom: ["ปริมาณน้อย","เจ็บเต้านม"]),
            Disease(name: "อุ้งเชิงกรานอักเสบ", symptom: ["สีขาวมีเลือด","ปริมาณมาก"]),
        ]
    }
}
