//
//  MReservationChartAreaWise.swift
//  BusConnect
//
//  Created by INFINITY on 04/02/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

class JSReservationChartAreaWise : Codable {
    let status : Int?
    let message : String?
    let data : DBReservationAreaWise?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(DBReservationAreaWise.self, forKey: .data)
    }
}

class DBReservationAreaWise : Codable {
    let passengerDetails : [SDB_PassengerDetails]?
    let subRoute : [SDB_SubRoute]?
    let reportedSeats : [SDB_ReportedSeats]?
    let nonReportedSeats : [SDB_NonReportedSeats]?
    let pendingSeats : [SDB_PendingSeats]?

    enum CodingKeys: String, CodingKey {

        case passengerDetails = "PassengerDetails"
        case subRoute = "SubRoute"
        case reportedSeats = "ReportedSeats"
        case nonReportedSeats = "NonReportedSeats"
        case pendingSeats = "PendingSeats"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        passengerDetails = try values.decodeIfPresent([SDB_PassengerDetails].self, forKey: .passengerDetails)
        subRoute = try values.decodeIfPresent([SDB_SubRoute].self, forKey: .subRoute)
        reportedSeats = try values.decodeIfPresent([SDB_ReportedSeats].self, forKey: .reportedSeats)
        nonReportedSeats = try values.decodeIfPresent([SDB_NonReportedSeats].self, forKey: .nonReportedSeats)
        pendingSeats = try values.decodeIfPresent([SDB_PendingSeats].self, forKey: .pendingSeats)
    }
}


class SDB_PassengerDetails : Codable {
    let retStatus : Int?
    let pNRNO : Int?
    let passengerName : String?
    let pAXMobileNo : String?
    let fromCity : String?
    let toCity : String?
    let bookingTypeID : Int?
    let serviceName : String?
    let bDateTime : String?
    let remarks : String?
    let seatNo : String?
    let scheduleCode : String?
    let routeID : Int?
    let timeID : Int?
    let isSameDay : Int?
    let pickupID : Int?
    let pickupTime24 : String?
    let pickupTime : String?
    let pickupName : String?
    let journeyDate : String?
    let pickupDate : String?
    let srNo : Int?
    let companyID : Int?
    let bookedByCompanyID : Int?
    let bookingDatetime : String?
    let phoneBookigColor : String?
    let pickupManNo : String?
    let areaName : String?
    let seatStatus : Int?
    let reportedNonReportedMsg : String?
    let isPickupVan : Int?
    let baseFare : Double?
    let gST : Double?
    let totalamount : Double?
    let totalPax : Int?
    let fromCityID : Int?
    let toCityID : Int?
    let areaID : Int?
    let isStopBooking : Int?
    let locationMessage : String?
    let notReachable : String?
    let noShowMessage : String?
    let massMessage : String?

    enum CodingKeys: String, CodingKey {

        case retStatus = "RetStatus"
        case pNRNO = "PNRNO"
        case passengerName = "PassengerName"
        case pAXMobileNo = "PAXMobileNo"
        case fromCity = "FromCity"
        case toCity = "ToCity"
        case bookingTypeID = "BookingTypeID"
        case serviceName = "ServiceName"
        case bDateTime = "BDateTime"
        case remarks = "Remarks"
        case seatNo = "SeatNo"
        case scheduleCode = "ScheduleCode"
        case routeID = "RouteID"
        case timeID = "TimeID"
        case isSameDay = "IsSameDay"
        case pickupID = "PickupID"
        case pickupTime24 = "PickupTime24"
        case pickupTime = "PickupTime"
        case pickupName = "PickupName"
        case journeyDate = "JourneyDate"
        case pickupDate = "PickupDate"
        case srNo = "SrNo"
        case companyID = "CompanyID"
        case bookedByCompanyID = "BookedByCompanyID"
        case bookingDatetime = "BookingDatetime"
        case phoneBookigColor = "PhoneBookigColor"
        case pickupManNo = "PickupManNo"
        case areaName = "AreaName"
        case seatStatus = "SeatStatus"
        case reportedNonReportedMsg = "ReportedNonReportedMsg"
        case isPickupVan = "IsPickupVan"
        case baseFare = "BaseFare"
        case gST = "GST"
        case totalamount = "Totalamount"
        case totalPax = "TotalPax"
        case fromCityID = "FromCityID"
        case toCityID = "ToCityID"
        case areaID = "AreaID"
        case isStopBooking = "IsStopBooking"
        case locationMessage = "LocationMessage"
        case notReachable = "NotReachable"
        case noShowMessage = "NoShowMessage"
        case massMessage = "MassMessage"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        retStatus = try values.decodeIfPresent(Int.self, forKey: .retStatus)
        pNRNO = try values.decodeIfPresent(Int.self, forKey: .pNRNO)
        passengerName = try values.decodeIfPresent(String.self, forKey: .passengerName)
        pAXMobileNo = try values.decodeIfPresent(String.self, forKey: .pAXMobileNo)
        fromCity = try values.decodeIfPresent(String.self, forKey: .fromCity)
        toCity = try values.decodeIfPresent(String.self, forKey: .toCity)
        bookingTypeID = try values.decodeIfPresent(Int.self, forKey: .bookingTypeID)
        serviceName = try values.decodeIfPresent(String.self, forKey: .serviceName)
        bDateTime = try values.decodeIfPresent(String.self, forKey: .bDateTime)
        remarks = try values.decodeIfPresent(String.self, forKey: .remarks)
        seatNo = try values.decodeIfPresent(String.self, forKey: .seatNo)
        scheduleCode = try values.decodeIfPresent(String.self, forKey: .scheduleCode)
        routeID = try values.decodeIfPresent(Int.self, forKey: .routeID)
        timeID = try values.decodeIfPresent(Int.self, forKey: .timeID)
        isSameDay = try values.decodeIfPresent(Int.self, forKey: .isSameDay)
        pickupID = try values.decodeIfPresent(Int.self, forKey: .pickupID)
        pickupTime24 = try values.decodeIfPresent(String.self, forKey: .pickupTime24)
        pickupTime = try values.decodeIfPresent(String.self, forKey: .pickupTime)
        pickupName = try values.decodeIfPresent(String.self, forKey: .pickupName)
        journeyDate = try values.decodeIfPresent(String.self, forKey: .journeyDate)
        pickupDate = try values.decodeIfPresent(String.self, forKey: .pickupDate)
        srNo = try values.decodeIfPresent(Int.self, forKey: .srNo)
        companyID = try values.decodeIfPresent(Int.self, forKey: .companyID)
        bookedByCompanyID = try values.decodeIfPresent(Int.self, forKey: .bookedByCompanyID)
        bookingDatetime = try values.decodeIfPresent(String.self, forKey: .bookingDatetime)
        phoneBookigColor = try values.decodeIfPresent(String.self, forKey: .phoneBookigColor)
        pickupManNo = try values.decodeIfPresent(String.self, forKey: .pickupManNo)
        areaName = try values.decodeIfPresent(String.self, forKey: .areaName)
        seatStatus = try values.decodeIfPresent(Int.self, forKey: .seatStatus)
        reportedNonReportedMsg = try values.decodeIfPresent(String.self, forKey: .reportedNonReportedMsg)
        isPickupVan = try values.decodeIfPresent(Int.self, forKey: .isPickupVan)
        baseFare = try values.decodeIfPresent(Double.self, forKey: .baseFare)
        gST = try values.decodeIfPresent(Double.self, forKey: .gST)
        totalamount = try values.decodeIfPresent(Double.self, forKey: .totalamount)
        totalPax = try values.decodeIfPresent(Int.self, forKey: .totalPax)
        fromCityID = try values.decodeIfPresent(Int.self, forKey: .fromCityID)
        toCityID = try values.decodeIfPresent(Int.self, forKey: .toCityID)
        areaID = try values.decodeIfPresent(Int.self, forKey: .areaID)
        isStopBooking = try values.decodeIfPresent(Int.self, forKey: .isStopBooking)
        locationMessage = try values.decodeIfPresent(String.self, forKey: .locationMessage)
        notReachable = try values.decodeIfPresent(String.self, forKey: .notReachable)
        noShowMessage = try values.decodeIfPresent(String.self, forKey: .noShowMessage)
        massMessage = try values.decodeIfPresent(String.self, forKey: .massMessage)
    }

}


class SDB_NonReportedSeats : Codable {
    let retStatus : Int?
    let scheduleCode : String?
    let timeID : Int?
    let seatNo : String?
    let totalSeats : Int?

    enum CodingKeys: String, CodingKey {

        case retStatus = "RetStatus"
        case scheduleCode = "ScheduleCode"
        case timeID = "TimeID"
        case seatNo = "SeatNo"
        case totalSeats = "TotalSeats"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        retStatus = try values.decodeIfPresent(Int.self, forKey: .retStatus)
        scheduleCode = try values.decodeIfPresent(String.self, forKey: .scheduleCode)
        timeID = try values.decodeIfPresent(Int.self, forKey: .timeID)
        seatNo = try values.decodeIfPresent(String.self, forKey: .seatNo)
        totalSeats = try values.decodeIfPresent(Int.self, forKey: .totalSeats)
    }

}

class SDB_PendingSeats : Codable {
    let retStatus : Int?
    let scheduleCode : String?
    let timeID : Int?
    let seatNo : String?
    let totalSeats : Int?

    enum CodingKeys: String, CodingKey {

        case retStatus = "RetStatus"
        case scheduleCode = "ScheduleCode"
        case timeID = "TimeID"
        case seatNo = "SeatNo"
        case totalSeats = "TotalSeats"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        retStatus = try values.decodeIfPresent(Int.self, forKey: .retStatus)
        scheduleCode = try values.decodeIfPresent(String.self, forKey: .scheduleCode)
        timeID = try values.decodeIfPresent(Int.self, forKey: .timeID)
        seatNo = try values.decodeIfPresent(String.self, forKey: .seatNo)
        totalSeats = try values.decodeIfPresent(Int.self, forKey: .totalSeats)
    }

}

class SDB_ReportedSeats : Codable {
    let retStatus : Int?
    let scheduleCode : String?
    let timeID : Int?
    let seatNo : String?
    let totalSeats : Int?

    enum CodingKeys: String, CodingKey {

        case retStatus = "RetStatus"
        case scheduleCode = "ScheduleCode"
        case timeID = "TimeID"
        case seatNo = "SeatNo"
        case totalSeats = "TotalSeats"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        retStatus = try values.decodeIfPresent(Int.self, forKey: .retStatus)
        scheduleCode = try values.decodeIfPresent(String.self, forKey: .scheduleCode)
        timeID = try values.decodeIfPresent(Int.self, forKey: .timeID)
        seatNo = try values.decodeIfPresent(String.self, forKey: .seatNo)
        totalSeats = try values.decodeIfPresent(Int.self, forKey: .totalSeats)
    }

}

class SDB_SubRoute : Codable {
    let retStatus : Int?
    let scheduleCode : String?
    let timeID : Int?
    let subRoute : String?
    let seatNo : String?
    let totalSeats : Int?

    enum CodingKeys: String, CodingKey {

        case retStatus = "RetStatus"
        case scheduleCode = "ScheduleCode"
        case timeID = "TimeID"
        case subRoute = "SubRoute"
        case seatNo = "SeatNo"
        case totalSeats = "TotalSeats"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        retStatus = try values.decodeIfPresent(Int.self, forKey: .retStatus)
        scheduleCode = try values.decodeIfPresent(String.self, forKey: .scheduleCode)
        timeID = try values.decodeIfPresent(Int.self, forKey: .timeID)
        subRoute = try values.decodeIfPresent(String.self, forKey: .subRoute)
        seatNo = try values.decodeIfPresent(String.self, forKey: .seatNo)
        totalSeats = try values.decodeIfPresent(Int.self, forKey: .totalSeats)
    }
}
