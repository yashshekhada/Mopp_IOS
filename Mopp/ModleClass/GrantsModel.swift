//
//  GrantsModel.swift
//  Mopp
//
//  Created by mac on 8/9/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
struct GrantsModel :Codable {
    let statusCode : Int?
    let statusMsg : String?
    let GrantsModel_data : [GrantsModel_Data]?

    enum CodingKeys: String, CodingKey {

        case statusCode = "statusCode"
        case statusMsg = "statusMsg"
        case GrantsModel_data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        statusMsg = try values.decodeIfPresent(String.self, forKey: .statusMsg)
        GrantsModel_data = try values.decodeIfPresent([GrantsModel_Data].self, forKey: .GrantsModel_data)
    }

}
struct GrantsModel_Data : Codable {
    let id : Int?
    let s_title : String?
    let s_desc : String?
    let s_link : String?
    let s_education : String?
    let s_money : String?
    let s_contact : String?
    let s_department : String?
    let s_enddate : String?
    let univercity_id : Int?
    let status : String?
    let created_by : String?
    let updated_by : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case s_title = "s_title"
        case s_desc = "s_desc"
        case s_link = "s_link"
        case s_education = "s_education"
        case s_money = "s_money"
        case s_contact = "s_contact"
        case s_department = "s_department"
        case s_enddate = "s_enddate"
        case univercity_id = "univercity_id"
        case status = "status"
        case created_by = "created_by"
        case updated_by = "updated_by"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        s_title = try values.decodeIfPresent(String.self, forKey: .s_title)
        s_desc = try values.decodeIfPresent(String.self, forKey: .s_desc)
        s_link = try values.decodeIfPresent(String.self, forKey: .s_link)
        s_education = try values.decodeIfPresent(String.self, forKey: .s_education)
        s_money = try values.decodeIfPresent(String.self, forKey: .s_money)
        s_contact = try values.decodeIfPresent(String.self, forKey: .s_contact)
        s_department = try values.decodeIfPresent(String.self, forKey: .s_department)
        s_enddate = try values.decodeIfPresent(String.self, forKey: .s_enddate)
        univercity_id = try values.decodeIfPresent(Int.self, forKey: .univercity_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
        updated_by = try values.decodeIfPresent(String.self, forKey: .updated_by)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
