//
//  StatusModel.swift
//  Mopp
//
//  Created by mac on 7/29/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct StatusModel: Codable {
    let statusCode: Int = 0
    let statusMsg: String = ""
}
struct StatusModel2:  Codable {
    let statusCode : Int?
    let statusMsg : String?

    enum CodingKeys: String, CodingKey {

        case statusCode = "statusCode"
        case statusMsg = "statusMsg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        statusMsg = try values.decodeIfPresent(String.self, forKey: .statusMsg)
    }

}
