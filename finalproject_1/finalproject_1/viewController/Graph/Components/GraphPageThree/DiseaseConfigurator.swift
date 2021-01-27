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
            Disease(name: "โรคโลหิตจาง", symptom: ["ปริมาณมาก","อ่อนเพลีย"]),
            Disease(name: "โรคช็อกโกแลตซีสต์", symptom: ["ปริมาณมาก","ปวดท้อง","ปวดศีรษะ"]),
            Disease(name: "เนื้องอกในมดลูก", symptom: ["ปริมาณมาก","ปวดท้อง"]),
            Disease(name: "เนื้องอกในรังไข่", symptom: ["ปวดศีรษะ","ประจำเดือนเลื่อน"]),
            Disease(name: "โรคต่อมใต้สมองขาดเลือด", symptom: ["ปริมาณน้อย","เจ็บเต้านม","อ่อนเพลีย"]),
            Disease(name: "อุ้งเชิงกรานอักเสบ", symptom: ["สีขาวมีเลือด","ปริมาณมาก"]),
        ]
    }
    static func getEmotion() -> [Emotion] {
        return [
            Emotion(name: "อารมณ์ปกติ",emotion: ["ปกติ","มีความสุข"]),
            Emotion(name: "อารมณ์แปรปรวน",emotion: ["มีอารมณ์แปรปรวน","เฉยเมย","เศร้าเสียใจ"]),
            Emotion(name: "อารมณ์ไม่ดี",emotion: ["หงุดหงิด"]),
          
        ]
    }
    
}

