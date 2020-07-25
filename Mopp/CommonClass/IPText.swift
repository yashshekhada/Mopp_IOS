//
//  RUText.swift
//  RateUs
//
//  Created by Abhijit Soni on 19/03/17.
//  Copyright © 2017 Abhijit Soni. All rights reserved.
//

import UIKit

struct IPText {
    struct Message {
        static let noInternet = "Internet connection is not avaliable. Please try again later."
        static let somethingWrong = "Something went wrong please try again."
        static let validBranchCode = "Please enter valid branch code"
        static let validUserName = "Please enter valid user name"
        static let passwordBlank = "Please enter password"
        static let passwordSpace = "Please remove space from password"
        static let mobleVerify = "Verification Code is mandatory"
        static let companyName = "Company Name is mandatory"
        static let enterAgentBalance = "Enter Amount Of Recharge"
        static let enterBusNo = "Enter Bus No"
        static let enterKilometer = "Enter Kilometer"
        static let enterGreaterKilometer = "Enter Kilometer Greater Than Past Kilometer"
        static let selectValidBus = "Please select valid bus no"
        static let enterAgentRemark = "Enter Remarks"
        static let branchName = "Branch Name is mandatory"
        static let userName = "User Name is mandatory"
        static let mobileNumber = "Mobile Number is mandatory"
        
         static let NoData = "No Data Available"
        static let validTime = "Please select time"
        static let selectReport = "Select Report Name"
        static let selectSeatForAction = "Please select seats fro requested action."
        
        static let validEmail = "Please, Enter Valid Email Address."
        static let validPNR = "Please enter valid PNR No"
        static let reportedSeat = "Report Successful"
        static let nonreportedSeat = "NonReport Successful"
        static let noPreviousRoute = "No previous route available"
        static let noNextRoute = "No next route available"
        static let enterBranch = "Enter Branch Name"
        
        static let selectBookType = "Please select valid Booking Type."
        static let enterCustName = "Please Enter Customer Name."
        static let enterCustMobile = "Please Enter Customer Mobile Number."
        static let enterAgent = "Please type valid Agent !!!"
        static let enterTicketNo = "Please Enter Agent Ticket No."
        static let validPickupPoint = "Please Select Valid Pickup Point."
        
        static let NoReport = "Sorry, unable to view booking report"
        static let NoTime = "Time Not Available."
        static let NoPickUp = "Pickup Points Are Not Available."
        static let NoDrop = "Drop Points Are Not Available."
        static let allFields = "Please, Fill All The Fields !!!"
        static let pnrCopied = "PNR copied"
        static let enterName = "Please enter name !"
        static let validNumber = "Please, Enter Valid Mobile Number."
        static let minPassword = "You must have 6 characters in your password"
        static let validKm = "Please, Enter Valid Kilometer !"
        static let validPassSpace = "Password must not have blank space character"
        static let validConfirmPassSpace = "Confirm password must not have blank space character"
        static let passNotMatch = "Password and confirm password doesn't match"
        static let validCity = "Please, Select Valid City !!!"
        static let validSchedule = "Please, Select Valid Schedule !!!"
        static let logout = "Are you sure you want to logout?"
        static let exit = "Are you sure want to exit?"
        static let terms = "Please Agree To Terms and Condition.."
        static let dateCompare = "Onward Journey Date should be less than Return Journey Date !!!"
        static let validSource = "Please type a valid Source City"
        static let validDestination = "Please type a valid Destination City"
        static let selectSource = "Please, select your Source City"
        static let selectDestination = "Please, select your Destination City"
        static let fromToCity = "From City & To City can not be same!"
        static let verifyCode = "Please Enter Verification Code"
        static let wrongOtp = "Wrong otp entered"
        static let couponCode = "Enter Coupon Code"
        static let selectSeat = "Please Select Atleast One Seat"
        static let limitSelectSeat = "You can not select more than 10 Seats !!!"
        static let selectBoardPoint = "- Select Boarding Point -"
        static let selectDropPoint = "- Select Dropping Point -"
        static let selectValidTrip = "Please Select Valid Trip !!!"
        static let onRoadStatus = "On Road is not available."
        static let idleStatus = "Idle is not available."
        static let haltStatus = "Halt is not available."
        static let inActiveStatus = "In Active is not available."
        static let noScheduleStatus = "No Schedule is not available."
        static let totalBusesStatus = "Total Buses are not available."
        static let enterNearBy = "Please enter nearby city."
        static let enterKM = "Please enter KM."
        static let dataNotAvailable = "Data is not available"
        
        static let enterAmount = "Enter Amount"

        static let selectDay = "Select Day"
        static let selectDate = "Select Date"
        static let selectFare = "Select Route For Change Fare"
        static let selectFareType = "Select fare Type"
        static let selectFareMethod = "Select Fare Change Method"
    }
    struct Label {
        static let alert          = "Alert !!!"
        static let alert2          = "Alert!!.."
        static let ok          = "OK"
        static let cancel      = "Cancel"
        static let yes         = "Yes"
        static let no          = "No"
        static let logout      = "Logout"
        static let CallStaf      = "CALL STAFF"
        static let camera      = "Camera"
        static let gallery      = "Gallery"
        static let delete      = "Delete"
        static let enable      = "Enable"
        static let noThanks      = "No Thanks"
        static let addPic      = "Add"

    }
}
