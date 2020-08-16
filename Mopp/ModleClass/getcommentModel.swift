//
//  getcommentModel.swift
//  Mopp
//
//  Created by mac on 8/16/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation

struct getcommentModel : Codable {
    let statusCode : Int?
    let statusMsg : String?
    let data : [getcommentModel_Data]?

    enum CodingKeys: String, CodingKey {

        case statusCode = "statusCode"
        case statusMsg = "statusMsg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        statusMsg = try values.decodeIfPresent(String.self, forKey: .statusMsg)
        data = try values.decodeIfPresent([getcommentModel_Data].self, forKey: .data)
    }

}

struct getcommentModel_Data : Codable {
    let id : Int?
    let post_id : Int?
    let comment : String?
    let comment_by : String?
    let status : String?
    let created_by : String?
    let updated_by : String?
    let created_at : String?
    let updated_at : String?
    let name : String?
    let s_id : Int?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case post_id = "post_id"
        case comment = "comment"
        case comment_by = "comment_by"
        case status = "status"
        case created_by = "created_by"
        case updated_by = "updated_by"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case name = "name"
        case s_id = "s_id"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        post_id = try values.decodeIfPresent(Int.self, forKey: .post_id)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        comment_by = try values.decodeIfPresent(String.self, forKey: .comment_by)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
        updated_by = try values.decodeIfPresent(String.self, forKey: .updated_by)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        s_id = try values.decodeIfPresent(Int.self, forKey: .s_id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}
