//
//  GetUnivercity.swift
//  Mopp
//
//  Created by mac on 7/25/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

open class GetUnivercity: NSObject {
    var id:String = ""
    var name:String = ""
        var email:String = ""
        var user_type:String = ""
       
    required public init(parameter: JSON) {
        self.id = parameter["id"].stringValue
        self.name = parameter["name"].stringValue
        self.email = parameter["email"].stringValue
        self.user_type = parameter["user_type"].stringValue
      
    }
}
