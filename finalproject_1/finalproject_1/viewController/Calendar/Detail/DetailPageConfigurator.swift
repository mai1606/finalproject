//
//  DetailPageConfigurator.swift
//  finalproject_1
//
//  Created by Mai on 1/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import Foundation

class DetailPageConfigurator {
    static func getSymptons() -> [Detail] {
        return [
            Detail(image: #imageLiteral(resourceName: "symptom1"), selectedImage: #imageLiteral(resourceName: "symptom1_1"), descr: "ทุกอย่างปกติ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom2"), selectedImage: #imageLiteral(resourceName: "symptom2_1"), descr: "เจ็บเต้านม", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom3"), selectedImage: #imageLiteral(resourceName: "symptom3_1"), descr: "ปวดท้อง", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom4"), selectedImage: #imageLiteral(resourceName: "symptom4_1"), descr: "ปวดหลัง", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom5"), selectedImage: #imageLiteral(resourceName: "symptom5_1"), descr: "ปวดหัวไหล่", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom6"), selectedImage: #imageLiteral(resourceName: "symptom6_1"), descr: "ปวดศีรษะ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom7"), selectedImage: #imageLiteral(resourceName: "symptom7_1"), descr: "กังวน", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom8"), selectedImage: #imageLiteral(resourceName: "symptom8_1."), descr: "ท้องผูก", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom9"), selectedImage: #imageLiteral(resourceName: "symptom9_1."), descr: "ท้องอืด", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom10"), selectedImage: #imageLiteral(resourceName: "symptom10_1."), descr: "น้ำหนักตัวเพิ่ม", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom11"), selectedImage: #imageLiteral(resourceName: "symptom11_1."), descr: "ปวดกล้ามเนื้อ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom12"), selectedImage: #imageLiteral(resourceName: "symptom12_1."), descr: "ปวดเอว", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom13"), selectedImage: #imageLiteral(resourceName: "symptom13_1."), descr: "สิ้วขึ้น", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom14"), selectedImage: #imageLiteral(resourceName: "symptom14_1."), descr: "เหนื่อยล้า", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom15"), selectedImage: #imageLiteral(resourceName: "symptom15_1."), descr: "อ่อนเพลีย", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom15"), selectedImage: #imageLiteral(resourceName: "symptom15_1."), descr: "ประจำเดือนเลื่อน", type: .emotion, isSelected: false),
        ]
    }
    static func getEmotion() -> [Detail] {
        return [
            Detail(image: #imageLiteral(resourceName: "emotion2"), selectedImage: #imageLiteral(resourceName: "emotion2_1"), descr: "ปกติ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion1"), selectedImage: #imageLiteral(resourceName: "emotion1_1"), descr: "มีความสุข", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion3"), selectedImage: #imageLiteral(resourceName: "emotion3_1"), descr: "มีอารมณ์แปรปรวน", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion6"), selectedImage: #imageLiteral(resourceName: "emotion6_1"), descr: "หงุดหงิด", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion7"), selectedImage: #imageLiteral(resourceName: "emotion7_1"), descr: "เศร้าเสียใจ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion5"), selectedImage: #imageLiteral(resourceName: "emotion5_1"), descr: "เฉยเมย", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion7_1-1"), selectedImage: #imageLiteral(resourceName: "emotion7-1"), descr: "กระปรี้กระเปร่า", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion8"), selectedImage: #imageLiteral(resourceName: "emotion8_1"), descr: "ขี้เล่น", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion10"), selectedImage: #imageLiteral(resourceName: "emotion4_1"), descr: "สดใส", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion11"), selectedImage: #imageLiteral(resourceName: "emotion11_1"), descr: "อ่อนไหวง่าย", type: .emotion, isSelected: false),
        ]
        
    }
    static func getContent() -> [Detail] {
        return [
            Detail(image: #imageLiteral(resourceName: "content2"), selectedImage: #imageLiteral(resourceName: "content2_1"), descr: "ปริมาณปกติ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "content3"), selectedImage: #imageLiteral(resourceName: "content3_1"), descr: "ปริมาณมาก", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "content1"), selectedImage: #imageLiteral(resourceName: "content1_1"), descr: "ปริมาณน้อย", type: .emotion, isSelected: false),
            
        ]
    }
    static func getSex() -> [Detail] {
        return [
            Detail(image: #imageLiteral(resourceName: "sex1"), selectedImage: #imageLiteral(resourceName: "sex1_1"), descr: "ไม่มี", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "sex3"), selectedImage: #imageLiteral(resourceName: "sex3_1"), descr: "ป้องกัน", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "sex2"), selectedImage: #imageLiteral(resourceName: "sex2_1"), descr: "ไม่ป้องกัน", type: .emotion, isSelected: false),
            
        ]
    }
    static func getLeucorrhoea() -> [Detail] {
        return [
            Detail(image: #imageLiteral(resourceName: "leucorrhoea6"), selectedImage: #imageLiteral(resourceName: "leucorrhoea6_1"), descr: "สีใส", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "leucorrhoea1"), selectedImage: #imageLiteral(resourceName: "leucorrhoea1_1"), descr: "สีเหลือง", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "leucorrhoea2"), selectedImage: #imageLiteral(resourceName: "leucorrhoea2_1"), descr: "สีเขียว", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "leucorrhoea3"), selectedImage: #imageLiteral(resourceName: "leucorrhoea3_1"), descr: "สีเทา", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "leucorrhoea4"), selectedImage: #imageLiteral(resourceName: "leucorrhoea4_1"), descr: "สีเหลืองเขียว", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "leucorrhoea5"), selectedImage: #imageLiteral(resourceName: "leucorrhoea5_1"), descr: "สีขาวมีเลือด", type: .emotion, isSelected: false),
            
            
        ]
    }
    static func getAll() -> [Detail] {
        return [
            Detail(image: #imageLiteral(resourceName: "symptom1"), selectedImage: #imageLiteral(resourceName: "symptom1_1"), descr: "ทุกอย่างปกติ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom2"), selectedImage: #imageLiteral(resourceName: "symptom2_1"), descr: "เจ็บเต้านม", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom3"), selectedImage: #imageLiteral(resourceName: "symptom3_1"), descr: "ปวดท้อง", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom4"), selectedImage: #imageLiteral(resourceName: "symptom4_1"), descr: "ปวดหลัง", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom5"), selectedImage: #imageLiteral(resourceName: "symptom5_1"), descr: "ปวดหัวไหล่", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom6"), selectedImage: #imageLiteral(resourceName: "symptom6_1"), descr: "ปวดศีรษะ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion2"), selectedImage: #imageLiteral(resourceName: "emotion2_1"), descr: "ปกติ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion1"), selectedImage: #imageLiteral(resourceName: "emotion1_1"), descr: "มีความสุข", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion3"), selectedImage: #imageLiteral(resourceName: "emotion3_1"), descr: "มีอารมณ์แปรปรวน", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion6"), selectedImage: #imageLiteral(resourceName: "emotion6_1"), descr: "หงุดหงิด", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion7"), selectedImage: #imageLiteral(resourceName: "emotion7_1"), descr: "เศร้าเสียใจ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion5"), selectedImage: #imageLiteral(resourceName: "emotion5_1"), descr: "เฉยเมย", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "content2"), selectedImage: #imageLiteral(resourceName: "content2_1"), descr: "ปริมาณปกติ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "content3"), selectedImage: #imageLiteral(resourceName: "content3_1"), descr: "ปริมาณมาก", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "content1"), selectedImage: #imageLiteral(resourceName: "content1_1"), descr: "ปริมาณน้อย", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "sex1"), selectedImage: #imageLiteral(resourceName: "sex1_1"), descr: "ไม่มี", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "sex3"), selectedImage: #imageLiteral(resourceName: "sex3_1"), descr: "ป้องกัน", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "sex2"), selectedImage: #imageLiteral(resourceName: "sex2_1"), descr: "ไม่ป้องกัน", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "leucorrhoea6"), selectedImage: #imageLiteral(resourceName: "leucorrhoea6_1"), descr: "สีใส", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "leucorrhoea1"), selectedImage: #imageLiteral(resourceName: "leucorrhoea1_1"), descr: "สีเหลือง", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "leucorrhoea2"), selectedImage: #imageLiteral(resourceName: "leucorrhoea2_1"), descr: "สีเขียว", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "leucorrhoea3"), selectedImage: #imageLiteral(resourceName: "leucorrhoea3_1"), descr: "สีเทา", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "leucorrhoea4"), selectedImage: #imageLiteral(resourceName: "leucorrhoea4_1"), descr: "สีเหลืองเขียว", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "leucorrhoea5"), selectedImage: #imageLiteral(resourceName: "leucorrhoea5_1"), descr: "สีขาวมีเลือด", type: .emotion, isSelected: false),
            
            Detail(image: #imageLiteral(resourceName: "symptom7"), selectedImage: #imageLiteral(resourceName: "symptom7_1"), descr: "กังวน", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom8"), selectedImage: #imageLiteral(resourceName: "symptom8_1."), descr: "ท้องผูก", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom9"), selectedImage: #imageLiteral(resourceName: "symptom9_1."), descr: "ท้องอืด", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom10"), selectedImage: #imageLiteral(resourceName: "symptom10_1."), descr: "น้ำหนักตัวเพิ่ม", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom11"), selectedImage: #imageLiteral(resourceName: "symptom11_1."), descr: "ปวดกล้ามเนื้อ", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom12"), selectedImage: #imageLiteral(resourceName: "symptom12_1."), descr: "ปวดเอว", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom13"), selectedImage: #imageLiteral(resourceName: "symptom13_1."), descr: "สิ้วขึ้น", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom14"), selectedImage: #imageLiteral(resourceName: "symptom14_1."), descr: "เหนื่อยล้า", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "symptom15"), selectedImage: #imageLiteral(resourceName: "symptom15_1."), descr: "อ่อนเพลีย", type: .emotion, isSelected: false),
            
            Detail(image: #imageLiteral(resourceName: "emotion7_1-1"), selectedImage: #imageLiteral(resourceName: "emotion7-1"), descr: "กระปรี้กระเปร่า", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion8"), selectedImage: #imageLiteral(resourceName: "emotion8_1"), descr: "ขี้เล่น", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion10"), selectedImage: #imageLiteral(resourceName: "emotion4_1"), descr: "สดใส", type: .emotion, isSelected: false),
            Detail(image: #imageLiteral(resourceName: "emotion11"), selectedImage: #imageLiteral(resourceName: "emotion11_1"), descr: "อ่อนไหวง่าย", type: .emotion, isSelected: false),
        ]
    }
}
