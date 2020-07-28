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

    var pageSize:Int = 0
    var gcmToken:String = ""
    var loginNavigation: UINavigationController?
    var uniqDeviceid:String = ""

}
