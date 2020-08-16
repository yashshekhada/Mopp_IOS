//
//  UserData_m.swift
//  Mopp
//
//  Created by mac on 7/29/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct UserData_m: Codable {
    let statusCode: Int
    let statusMsg: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
 
        let id : Int?
        let email : String?
        let name : String?
        let l_name : String?
        let image : String?
        let username : String?
        let dob : String?
        let city : String?
        let country : String?
        let gender : String?
        let qualification : String?
        let phone_number : String?
        let api_token : String?
        let univercity_id : Int?
        let univercity_name : String?
        let session_token : String?

        enum CodingKeys: String, CodingKey {

            case id = "id"
            case email = "email"
            case name = "name"
            case l_name = "l_name"
            case image = "image"
            case username = "username"
            case dob = "dob"
            case city = "city"
            case country = "country"
            case gender = "gender"
            case qualification = "qualification"
            case phone_number = "phone_number"
            case api_token = "api_token"
            case univercity_id = "univercity_id"
            case univercity_name = "univercity_name"
            case session_token = "session_token"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            email = try values.decodeIfPresent(String.self, forKey: .email)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            l_name = try values.decodeIfPresent(String.self, forKey: .l_name)
            image = try values.decodeIfPresent(String.self, forKey: .image)
            username = try values.decodeIfPresent(String.self, forKey: .username)
            dob = try values.decodeIfPresent(String.self, forKey: .dob)
            city = try values.decodeIfPresent(String.self, forKey: .city)
            country = try values.decodeIfPresent(String.self, forKey: .country)
            gender = try values.decodeIfPresent(String.self, forKey: .gender)
            qualification = try values.decodeIfPresent(String.self, forKey: .qualification)
            phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
            api_token = try values.decodeIfPresent(String.self, forKey: .api_token)
            univercity_id = try values.decodeIfPresent(Int.self, forKey: .univercity_id)
            univercity_name = try values.decodeIfPresent(String.self, forKey: .univercity_name)
            session_token = try values.decodeIfPresent(String.self, forKey: .session_token)
        }

    }
