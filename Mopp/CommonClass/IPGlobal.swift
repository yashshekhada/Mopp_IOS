//
//  RUGlobal.swift
//  RateUs
//
//  Created by Abhijit Soni on 19/03/17.
//  Copyright © 2017 Abhijit Soni. All rights reserved.
//

import UIKit
import MMDrawController

class IPGlobal {
    static let global: IPGlobal = IPGlobal()
    
    /// Global navigation controller for application level
    var navigationController:   UINavigationController?
    var drawerController: MMDrawerViewController?
    /// Global Drawer for application level

    /// User object for application level
    var user:                   User?
    var pageSize:Int = 0
    var gcmToken:String = ""
    var loginNavigation: UINavigationController?
    var uniqDeviceid:String = ""
    var AdminUser : AdminLoginUser?
    
    
    
    
    
    var arrToCityDetail = [BCCity]()
    var arrAgent = [BCAgent]()
    var arrBusNoDetail = [BCBusNoDetail]()
    var arrDriverConductorDetail = [BCDriverConductorDetail]()
    var arrPickUpManDetail = [BCPickUpManDetail]()
    var arrBookSelectionType = [BCBookSelectionType]()
    var arrBranchMaster = [BCBranchMaster]()
    var arrBookingType = [BCBookingType]()
}
