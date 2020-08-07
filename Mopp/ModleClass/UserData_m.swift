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
    let id: Int
    let email, name, lName, image: String
    let username, dob, state, city: String
    let country, gender, qualification, phoneNumber: String
    let apiToken: String
    let univercityID: Int
    let univercityName, sessionToken: String

    enum CodingKeys: String, CodingKey {
        case id, email, name
        case lName = "l_name"
        case image, username, dob, state, city, country, gender, qualification
        case phoneNumber = "phone_number"
        case apiToken = "api_token"
        case univercityID = "univercity_id"
        case univercityName = "univercity_name"
        case sessionToken = "session_token"
    }
}
