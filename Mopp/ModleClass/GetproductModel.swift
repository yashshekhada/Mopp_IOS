//
//  GetproductModel.swift
//  Mopp
//
//  Created by mac on 8/15/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
struct GetproductModel : Codable {
    let statusCode : Int?
    let statusMsg : String?
    let data : [GetproductModel_Data]?

    enum CodingKeys: String, CodingKey {

        case statusCode = "statusCode"
        case statusMsg = "statusMsg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        statusMsg = try values.decodeIfPresent(String.self, forKey: .statusMsg)
        data = try values.decodeIfPresent([GetproductModel_Data].self, forKey: .data)
    }

}


struct GetproductModel_Data : Codable {
    let id : Int?
    let title : String?
    let price : Int?
    let image : String?
    let desc : String?
    let s_id : Int?
    let u_id : Int?
    let contact_link : String?
    let status : String?
    let created_by : String?
    let updated_by : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case price = "price"
        case image = "image"
        case desc = "desc"
        case s_id = "s_id"
        case u_id = "u_id"
        case contact_link = "contact_link"
        case status = "status"
        case created_by = "created_by"
        case updated_by = "updated_by"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price = try values.decodeIfPresent(Int.self, forKey: .price)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        desc = try values.decodeIfPresent(String.self, forKey: .desc)
        s_id = try values.decodeIfPresent(Int.self, forKey: .s_id)
        u_id = try values.decodeIfPresent(Int.self, forKey: .u_id)
        contact_link = try values.decodeIfPresent(String.self, forKey: .contact_link)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
        updated_by = try values.decodeIfPresent(String.self, forKey: .updated_by)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}
