//
//  Message.swift
//  finalproject_1
//
//  Created by Mai on 17/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit
import Firebase
import MessageKit

struct Message {

    var id: String
    var content: String
    var created: Timestamp
    var senderID: String
    var senderName: String
    
    var dictionary: [String: Any] {
        
        return [
            "id": id,
            "content": content,
            "created": created,
            "senderID": senderID,
            "senderName":senderName]
        
    }
    
    struct alert {
        static var title: String = "ข้อความจากระบบ"
    }
    
    struct button {
        static var ok: String = "ตกลง"
        static var cancel: String = "ยกเลิก"
        static var save: String = "บันทึก"
    }
}

extension Message {
    init?(dictionary: [String: Any]) {
        
        guard let id = dictionary["id"] as? String,
            let content = dictionary["content"] as? String,
            let created = dictionary["created"] as? Timestamp,
            let senderID = dictionary["senderID"] as? String,
            let senderName = dictionary["senderName"] as? String
            else {return nil}
        
        self.init(id: id, content: content, created: created, senderID: senderID, senderName:senderName)
        
    }
}

extension Message: MessageType {
    
    var sender: SenderType {
        return Sender(senderId: senderID, displayName: senderName)
    }
    
    var messageId: String {
        return id
    }
    
    var sentDate: Date {
        return created.dateValue()
    }
    
    var kind: MessageKind {
        return .text(content)
    }
}
