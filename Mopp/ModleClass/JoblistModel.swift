//
//  JoblistModel.swift
//  Mopp
//
//  Created by mac on 8/20/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
struct JoblistModel : Codable {
    let statusCode : Int?
    let statusMsg : String?
    let JoblistModel_Datas : [JoblistModel_Data]?

    enum CodingKeys: String, CodingKey {

        case statusCode = "statusCode"
        case statusMsg = "statusMsg"
        case JoblistModel_Datas = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
        statusMsg = try values.decodeIfPresent(String.self, forKey: .statusMsg)
        JoblistModel_Datas = try values.decodeIfPresent([JoblistModel_Data].self, forKey: .JoblistModel_Datas)
    }

}
struct JoblistModel_Data : Codable {
    let jobimage : String?
    let jobtitle : String?
    let jobdesc : String?
    let jobenddate : String?
    let jobcontact : String?
    let lat : String?
    let long : String?
    let jobdepartment : String?
    let jobhoursalary : String?
    let jobweekhour : String?
    let jobqualification : String?
    let jobid : Int?
    let acceptbystudent : String?

    enum CodingKeys: String, CodingKey {

        case jobimage = "jobimage"
        case jobtitle = "jobtitle"
        case jobdesc = "jobdesc"
        case jobenddate = "jobenddate"
        case jobcontact = "jobcontact"
        case lat = "lat"
        case long = "long"
        case jobdepartment = "jobdepartment"
        case jobhoursalary = "jobhoursalary"
        case jobweekhour = "jobweekhour"
        case jobqualification = "jobqualification"
        case jobid = "jobid"
        case acceptbystudent = "acceptbystudent"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        jobimage = try values.decodeIfPresent(String.self, forKey: .jobimage)
        jobtitle = try values.decodeIfPresent(String.self, forKey: .jobtitle)
        jobdesc = try values.decodeIfPresent(String.self, forKey: .jobdesc)
        jobenddate = try values.decodeIfPresent(String.self, forKey: .jobenddate)
        jobcontact = try values.decodeIfPresent(String.self, forKey: .jobcontact)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        long = try values.decodeIfPresent(String.self, forKey: .long)
        jobdepartment = try values.decodeIfPresent(String.self, forKey: .jobdepartment)
        jobhoursalary = try values.decodeIfPresent(String.self, forKey: .jobhoursalary)
        jobweekhour = try values.decodeIfPresent(String.self, forKey: .jobweekhour)
        jobqualification = try values.decodeIfPresent(String.self, forKey: .jobqualification)
        jobid = try values.decodeIfPresent(Int.self, forKey: .jobid)
        acceptbystudent = try values.decodeIfPresent(String.self, forKey: .acceptbystudent)
    }

}
