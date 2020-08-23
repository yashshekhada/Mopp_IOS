//
//  Message.swift
//  Mopp
//
//  Created by mac on 8/21/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
import FirebaseAuth

class Messagesx: NSObject {
    var name: String?
    var last_name: String?
    var email: String?
    var online: Bool?
    var photo: String?
       var Last_msg: String?
    var uni_id: String?
     var Key_ID: String?
    var TypingStatus: Bool? = false
    var Count: Int? = 0
   
// func chatPartnerId() -> String {
  //   return (fromId == Auth.auth().currentUser?.uid ? toId : fromId)!
// }
}


class Messages: NSObject {

   var message: String? = ""
    var messageFrom:String? = ""
   var messageId:String? = ""
   var messageTime:String? = ""
   var messageType:String? = ""
      func chatPartnerId() -> String {
          return (messageFrom == Auth.auth().currentUser?.uid ? messageId : messageFrom)!
      }


}
