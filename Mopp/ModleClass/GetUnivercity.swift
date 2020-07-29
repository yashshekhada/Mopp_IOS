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

open class GetUnivercity: Codable {
    let statusCode: Int
    let statusMsg: String = ""
    let data: [GetUnivercity_Data]
}

// MARK: - Datum
struct GetUnivercity_Data: Codable {
    let id, userType: Int
    let name, email, image, username: String
    let password, datumPostfix: String
    let status: Int
    let forgotkey: String
    let isDelete: Int
    let createdBy, updatedBy: String?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userType = "user_type"
        case name, email, image, username, password
        case datumPostfix = "postfix"
        case status, forgotkey
        case isDelete = "is_delete"
        case createdBy = "created_by"
        case updatedBy = "updated_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
