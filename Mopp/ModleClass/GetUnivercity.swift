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
import Foundation

struct GetUnivercity:  Codable {
    let statusCode : Int?
    let statusMsg : String?
    let data : [GetUnivercity_Data]?
    
    enum CodingKeys: String, CodingKey {
        
        case statusCode = "statusCode"
        case statusMsg = "statusMsg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        statusMsg = try values.decodeIfPresent(String.self, forKey: .statusMsg)
        data = try values.decodeIfPresent([GetUnivercity_Data].self, forKey: .data)
    }
    
}

// MARK: - Datum


struct GetUnivercity_Data : Codable {
    let id : Int?
    let user_type : Int?
    let name : String?
    let email : String?
    let image : String?
    let username : String?
    let password : String?
    let postfix : String?
    let status : Int?
    let forgotforgotkey : String?
    let created_by : String?
    let updated_by : String?
    let created_at : String?
    let updated_at : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case user_type = "user_type"
        case name = "name"
        case email = "email"
        case image = "image"
        case username = "username"
        case password = "password"
        case postfix = "postfix"
        case status = "status"
        case forgotforgotkey = "forgotkey"
        case created_by = "created_by"
        case updated_by = "updated_by"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_type = try values.decodeIfPresent(Int.self, forKey: .user_type)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        postfix = try values.decodeIfPresent(String.self, forKey: .postfix)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        forgotforgotkey = try values.decodeIfPresent(String.self, forKey: .forgotforgotkey)
        created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
        updated_by = try values.decodeIfPresent(String.self, forKey: .updated_by)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
    
}
