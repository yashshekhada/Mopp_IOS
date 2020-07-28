//
//  RUConstant.swift
//  RateUs
//
//  Created by Abhijit Soni on 19/03/17.
//  Copyright © 2017 Abhijit Soni. All rights reserved.
//

import UIKit

typealias Utill        = IPUtill
typealias Text         = IPText




let Application                      = UIApplication.shared.delegate as! AppDelegate

let Global:             IPGlobal     = IPGlobal.global

let UserDefault                      = UserDefaults.standard
let Screen                           = UIScreen.main.bounds.size
let UserKey                          = "UserKey"
let UserAdminLoginKey                = "UserAdminLoginKey"
let TDRM_IDKey                       = "TDRM_ID"
let RememberKey                      = "RememmberMe"
let BranchNameKey                    = "Branch"
let UserNameKey                      = "Username"
let PasswordKey                      = "Password"
let CompanyNameKey                   = "CompanyName"
let ISMOBILEVERIFIED                 = "isMobileVerified"
let LOGINVALUES                      = "loginValues"
let UniqAppId                        = "deviceId"
let SubscriptionTopic                = "/topics/global";
let PushToken                        = "pushToken"
let AppName                          = "ITSBusConnect"
let AdLoginUserName                  = "AdLoginUserName"
let AdLoginPassWord                  = "AdLoginPassWord"
let AdLoginRememberKey               = "AdLoginRememberKey"


//let UniqID                           = UIDevice.current.identifierForVendor!.uuidString
let systemVersion                    = UIDevice.current.systemVersion

//MARK:- Static Constants
let IPHONE6_WIDTH       = 375.0
let IPHONE6_HEIGHT      = 667.0
let IPHONE6_PLUS_WIDTH  = 414.0

//MARK:- Default Colour
let BAR_COLOR = #colorLiteral(red: 0.537254902, green: 0.537254902, blue: 0.537254902, alpha: 1)

//UserDefault Key
var LocalNotification = "LocalNotification"



//MARK:- Font name
//["ProximaNova-Light", "ProximaNova-Semibold", "ProximaNova-Bold", "ProximaNova-Regular"]

enum MenuAction:Int {
    
    case Home = 0
    case MyBookings = 1
    case Cancellation = 2
    case Gallery = 3
    case Feedback = 4
    case AboutUs = 5
    case ContactUs = 6
    case Logout = 7
}
