//
//  MessageViewController.swift
//  finalproject_1
//
//  Created by Mai on 17/12/2563 BE.
//  Copyright © 2563 BE ICTSUIM. All rights reserved.
//

import UIKit
import MessageKit

struct Sender: SenderType {
    var senderId: String
    
    var displayName: String
}
struct Message1:MessageType{
    var sender: SenderType
    
    var messageId: String = ""
    
    var sentDate: Date
    
    var kind: MessageKind
    
}

class MessageUserViewController: MessagesViewController,MessagesDataSource,MessagesLayoutDelegate,MessagesDisplayDelegate {
    
    let currentUser = Sender(senderId: "self", displayName: "iOS Academy")
    let otherUser = Sender(senderId: "other", displayName: "jone Academy")
    var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messages.append(Message1(sender: currentUser,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("Hello LOL")))
        messages.append(Message1(sender: otherUser,
                                messageId: "2",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("Hello LOL")))
        messages.append(Message1(sender: currentUser,
                                messageId: "3",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("Hello LOL")))
        messages.append(Message1(sender: otherUser,
                                messageId: "4",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("Hello LOL")))
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
       
    }
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.row]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    

  

}
