//
//  GetNewsFeed.swift
//  Mopp
//
//  Created by mac on 8/10/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
struct GetNewsFeed : Codable {
    let statusCode : Int?
    let statusMsg : String?
    let data : [GetNewsFeed_Data]?

    enum CodingKeys: String, CodingKey {

        case statusCode = "statusCode"
        case statusMsg = "statusMsg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        statusMsg = try values.decodeIfPresent(String.self, forKey: .statusMsg)
        data = try values.decodeIfPresent([GetNewsFeed_Data].self, forKey: .data)
    }

}
struct GetNewsFeed_Data : Codable {
    let id : Int?
    let description : String?
    let post_images_array : String?
    let likes : Int?
    let comments : Int?
    let numberofimages : Int?
    let code : String?
    let s_id : Int?
    let u_id : Int?
    let status : String?
    let created_by : String?
    let updated_by : String?
    let created_at : String?
    let updated_at : String?
    let name : String?
    let image : String?
    let is_like : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case description = "description"
        case post_images_array = "post_images_array"
        case likes = "likes"
        case comments = "comments"
        case numberofimages = "numberofimages"
        case code = "code"
        case s_id = "s_id"
        case u_id = "u_id"
        case status = "status"
        case created_by = "created_by"
        case updated_by = "updated_by"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case name = "name"
        case image = "image"
        case is_like = "is_like"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        post_images_array = try values.decodeIfPresent(String.self, forKey: .post_images_array)
        likes = try values.decodeIfPresent(Int.self, forKey: .likes)
        comments = try values.decodeIfPresent(Int.self, forKey: .comments)
        numberofimages = try values.decodeIfPresent(Int.self, forKey: .numberofimages)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        s_id = try values.decodeIfPresent(Int.self, forKey: .s_id)
        u_id = try values.decodeIfPresent(Int.self, forKey: .u_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
        updated_by = try values.decodeIfPresent(String.self, forKey: .updated_by)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        is_like = try values.decodeIfPresent(Int.self, forKey: .is_like)
    }
    init(id:Int?,description:String?,post_images_array:String?,likes: Int?,comments:Int?,numberofimages:Int?,code:String?,s_id:Int?,u_id:Int?,status:String?,created_by:String?,updated_by:String?,created_at:String?,updated_at:String?,name:String?,image:String?,is_like:Int?){
        self.id = id
            self.description = description
            self.post_images_array = post_images_array
            self.likes = likes
            self.comments = comments
            self.numberofimages = numberofimages
            self.code = code
            self.s_id = s_id
            self.u_id = u_id
            self.status = status
            self.created_by = created_by
            self.updated_by = updated_by
            self.created_at = created_at
            self.updated_at = updated_at
            self.name = name
            self.image = image
            self.is_like = is_like
    }
}
