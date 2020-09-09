//
//  GetbaseUrl.swift
//  Mopp
//
//  Created by mac on 9/2/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
import Foundation
struct GetbaseUrl : Codable {
  
    let BaseUrl : String?
  

    enum CodingKeys: String, CodingKey {

        case BaseUrl = "BaseUrl"
       
    }

 

}
