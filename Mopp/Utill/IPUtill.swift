//
//  IPUtill.swift
//  Mopp
//
//  Created by INFINITY INFOWAY PVT.LTD. on 24/07/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import SVProgressHUD
import KSToastView
import MMDrawController
import KeychainSwift
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON

class IPUtill {

    class func prepareApplication() {
//      UserDefault[ISMOBILEVERIFIED] = true
        setDeviceID()
        prepareBaseApplication()
        Utill.prepareUser()
        Utill.checkVersion(FromLoginCall: false)
        GMSServices.provideAPIKey(ClS.mapApiKey)
        GMSPlacesClient.provideAPIKey(ClS.mapApiKey)
    }
    class func setDeviceID()  {
        let keyChain = KeychainSwift()
        if let deviceid = keyChain.get("UniqDeviceId") {
            Global.uniqDeviceid = deviceid
            Utill.checkForIssue()
        } else {
            let uuid = UIDevice.current.identifierForVendor!.uuidString
            Global.uniqDeviceid = uuid
            keyChain.set(uuid, forKey: "UniqDeviceId")
        }
//        Global.uniqDeviceid = "3FDDCD45-5864-4F1A-ACA9-5248DDF08C0E"
    }
    class func checkForIssue()  {
        if let verison = Bundle.main.releaseVersionNumber {
            if verison == "1.5" {
                if Global.uniqDeviceid == "91EA041B-89CB-48E9-B8EF-A2C402A421D6" {
                    UserDefault[ISMOBILEVERIFIED] = nil
                    UserDefault[TDRM_IDKey] = nil
                    let keyChain = KeychainSwift()
                    let uuid = UIDevice.current.identifierForVendor!.uuidString
                    Global.uniqDeviceid = uuid
                    keyChain.set(uuid, forKey: "UniqDeviceId")
                } else if UserDefault[TDRM_IDKey] != nil && UserDefault[ISMOBILEVERIFIED] == nil {
                    UserDefault[TDRM_IDKey] = nil
                }
            }
        }
    }
    class func prepareBaseApplication()  {
        UIApplication.shared.statusBarStyle = .lightContent
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        IQKeyboardManager.shared.enable = true
        if let pagesize = UserDefault["pageSize"] {
            Global.pageSize = pagesize as! Int
        } else {
            UserDefault["pageSize"] = 10
            Global.pageSize = 10
        }
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = BAR_COLOR
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().clipsToBounds = false
        UINavigationBar.appearance().backgroundColor = BAR_COLOR
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    class func getIPAddress() -> [String] {
        var addresses = [String]()
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return [] }
        guard let firstAddr = ifaddr else { return [] }
        
        // For each interface ...
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            let addr = ptr.pointee.ifa_addr.pointee
            
            // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
            if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if (getnameinfo(ptr.pointee.ifa_addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                        let address = String(cString: hostname)
                        if address.components(separatedBy: ".").count == 4 {
                            addresses.append(address)
                        }
                    }
                }
            }
        }
        
        freeifaddrs(ifaddr)
        return addresses
    }

    class func showAlert(message:String,fromVC:UIViewController,title:String)  {
        let alertController =  UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (ACTION :UIAlertAction!)in
            alertController.dismiss(animated: true, completion: nil)
        }))
        fromVC.present(alertController, animated: true, completion: nil)
    }
    

    class func enableDisableIQkeyboard(enable:Bool)  {
        IQKeyboardManager.shared.enable = enable
    }
    
   
    class func showProgress()  {
        SVProgressHUD.show()
    }
    class func dismissProgress()  {
        SVProgressHUD.dismiss()
    }
    class func showProgressWithText(text:String)  {
        SVProgressHUD.show(withStatus: text)
    }
    class func toggleDrawer(from vc:UIViewController)  {
        if let drawer = vc.drawer() ,
            let manager = drawer.getManager(direction: .left){
            let value = !manager.isShow
            drawer.showLeftSlider(isShow: value)
        }
    }
    class func setCenterViewController(_ viewController: UIViewController) {
        
        /**
         Condition checks whether topViewController of navigationController is same which is in center now
         */
        if Global.navigationController!.topViewController!.isKind(of: viewController.classForCoder) {
           // Utill.toggleDrawer(from: Global.navigationController!.topViewController!)
            if Global.navigationController!.topViewController! is HomeViewController {
                (Global.navigationController!.topViewController! as! HomeViewController).resetData()
            }
        } else {
            Global.navigationController!.setViewControllers([viewController], animated: false)
            // Utill.toggleDrawer(from: viewController)
        }
    }
    class func reachable() -> Bool {
        let reachability = Reachability.forInternetConnection()
        if (reachability?.isReachableViaWiFi())! || (reachability?.isReachableViaWWAN())!{
            return true
        }
        return false
    }
    class func uuid() -> String {
        let uniqueString: CFUUID = CFUUIDCreate(nil)
        let isString: CFString = CFUUIDCreateString(nil, uniqueString)
        return isString as String
    }
    class func showToastWith(_ message:String) {
        KSToastView.ks_showToast(message, duration: 1.5)
    }
    class func prepareUser() {
        //initialize User object if it is logged In
        if let userData = UserDefault[UserKey] as! Data? {
            Global.user = NSKeyedUnarchiver.unarchiveObject(with: userData) as? User
        }
    }
    
    class func showVersionAlert()  {
        let alertController =  UIAlertController(title: AppName, message: "There is a newer version of this application available.Update now.", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (ACTION :UIAlertAction!)in
            DispatchQueue.main.async {
                if UIApplication.shared.canOpenURL(URL.init(string: "https://itunes.apple.com/in/app/its-busconnect/id1196236795?mt=8")!) {
                    UIApplication.shared.open(URL.init(string: "https://itunes.apple.com/in/app/its-busconnect/id1196236795?mt=8")!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                }
            }
            alertController.dismiss(animated: true, completion: nil)
        }))
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func alertOptionalUpdate(LoginCall:Bool) {
        let alertController =  UIAlertController(title: AppName, message: "There is a newer version of this application available.Update now.", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { (ACTION :UIAlertAction!)in
            DispatchQueue.main.async {
                if UIApplication.shared.canOpenURL(URL.init(string: "https://itunes.apple.com/in/app/its-busconnect/id1196236795?mt=8")!) {
                    UIApplication.shared.open(URL.init(string: "https://itunes.apple.com/in/app/its-busconnect/id1196236795?mt=8")!, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                }
            }
            alertController.dismiss(animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: "Not Now", style: .destructive, handler: { (UIAlertAction) in
            if LoginCall == false {
                IPUtill.checkUserRegistration()
            }
        }))
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func checkVersion(FromLoginCall:Bool) {
        if Utill.reachable() {
            let url =  URL(string: ClS.baseUrl+ClS.checkVersionInfo_V2Tag)!
            Utill.showProgress()
            let param = ["android_id": Global.uniqDeviceid,
                         "version_name": Bundle.main.releaseVersionNumber!,
                         "version_code": Bundle.main.buildVersionNumber!,
                         "update_severity": "0",
                         "AppName": APIAppName] as [String : Any]
            
            Alamofire.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: ClS.head).responseJSON { (response) -> Void in
                Utill.dismissProgress()
                switch(response.result) {
                case .success(_):
                    DispatchQueue.main.async {
                        if let dataa = response.result.value {
                            let json = JSON(dataa)
                            if json["status"].stringValue == "1"  {
                                if let appversion = Int(Bundle.main.buildVersionNumber!) {
                                    if let apiVersion = Int(json["data"][0]["version_code"].stringValue) {
                                        if apiVersion > appversion {
                                            if json["data"][0]["update_severity"].stringValue ==  "1" {
                                                IPUtill.alertOptionalUpdate(LoginCall: FromLoginCall)
                                            } else if json["data"][0]["update_severity"].stringValue ==  "2" {
                                                Utill.showVersionAlert()
                                            } else {
                                                if FromLoginCall == false {
                                                    IPUtill.checkUserRegistration()
                                                }
                                            }
                                        }else{
                                            if FromLoginCall == false {
                                                IPUtill.checkUserRegistration()
                                            }
                                        }
                                    }
                                }
                            }else{
                                Utill.showToastWith(json["message"].stringValue)
                            }
                        }
                    }
                case .failure(_):
                    Utill.showToastWith("Error")
                    break
                }
            }
        }
    }
    
    class func checkUserRegistration(){
        Utill.showProgress()
        let param = ["TDRM_OSDeviceID" : Global.uniqDeviceid,
                     "TDRM_OSVerifyCall":VerifyCall]
        ClSApi.AlamofireRequest(completion: { (MData:JSCheckUserRegi) in
            Utill.dismissProgress()
            if MData.data[0].loginStatus == 1 {
                prepareInitialStoryboard(isthroughLogin: false,isAlreadyReg:true)
            }else{
                prepareInitialStoryboard(isthroughLogin: false,isAlreadyReg:false)
            }
        }, Tag: ClS.CheckRegistrationTag, Prams: param, Method: ClS.post)
    }
    /// This function set root storyboard from condition
    class func prepareInitialStoryboard(isthroughLogin:Bool,isAlreadyReg:Bool) {
        DispatchQueue.main.async {
            if let _ = UserDefault[ISMOBILEVERIFIED] {
                if isthroughLogin == false {
                    if isAlreadyReg {
                        let navigationVC = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginNavigationViewController") as! UINavigationController
                        let loginVC = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginViewController")
                        navigationVC.viewControllers = [loginVC]
                        Application.window?.rootViewController = navigationVC
                    }else{
                        let navigationVC = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginNavigationViewController") as! UINavigationController
                        let loginVC = UIStoryboard.main.instantiateViewController(withIdentifier: "RegisterUserViewController")
                        navigationVC.viewControllers = [loginVC]
                        Application.window?.rootViewController = navigationVC
                     
                    }
                } else {
                    
                    Application.window?.rootViewController = UIStoryboard.dashboard.instantiateViewController(withIdentifier: "DrawerViewController") as! DrawerViewController
                }
//                if let _ = Global.user {
//                    if isthroughLogin == false {
//                        getLoginDetails()
//                    }
//                    Application.window?.rootViewController = UIStoryboard.dashboard.instantiateViewController(withIdentifier: "DrawerViewController") as! DrawerViewController
//
//                } else {
//                    let navigationVC = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginNavigationViewController") as! UINavigationController
//                    let loginVC = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginViewController")
//                    navigationVC.viewControllers = [loginVC]
//                    Application.window?.rootViewController = navigationVC
//                }
            } else if let _ = UserDefault[TDRM_IDKey] {
                let navigationVC = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginNavigationViewController") as! UINavigationController
                let verifyVC = UIStoryboard.main.instantiateViewController(withIdentifier: "VerifyNumberViewController")
                navigationVC.viewControllers = [verifyVC]
                Application.window?.rootViewController = navigationVC
            } else {
                
                if isAlreadyReg  {
                    let navigationVC = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginNavigationViewController") as! UINavigationController
                    let loginVC = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginViewController")
                    navigationVC.viewControllers = [loginVC]
                    Application.window?.rootViewController = navigationVC
                }else{
                    let navigationVC = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginNavigationViewController") as! UINavigationController
                    let loginVC = UIStoryboard.main.instantiateViewController(withIdentifier: "RegisterUserViewController")
                    navigationVC.viewControllers = [loginVC]
                    Application.window?.rootViewController = navigationVC
                }
                
               // Application.window?.rootViewController = UIStoryboard.main.instantiateInitialViewController()
            }
        }
    }
    class func prepareUserForLogout(frmoVC:UINavigationController) {
        
        let alertController =  UIAlertController(title: AppName, message: Text.Message.logout, preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: Text.Label.logout, style: UIAlertAction.Style.default, handler: { (ACTION :UIAlertAction!)in
            Utill.logOut()
        }))
        
        alertController.addAction(UIAlertAction(title: Text.Label.cancel, style: UIAlertAction.Style.cancel, handler: { (ACTION :UIAlertAction!)in
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        frmoVC.present(alertController, animated: true, completion: nil)
    }
    class func logOut()  {
        Global.user?.logout()
        prepareInitialStoryboard(isthroughLogin: false,isAlreadyReg:true)
    }
    
    class func registerGCMOnserver()  {
        if let _ = Global.user {
           /* PushNotificationRegistration.init().pushnotification(registerid: Global.gcmToken) { (json, status, message) in
            }*/
        }
    }
    class func getLoginDetails() {
        if Utill.reachable() {
            Utill.showProgress()
            let parameter = UserDefault[LOGINVALUES]
            LoginService.init().login(parameter: parameter as! [String : Any]) { (user, status, message) in
                Utill.dismissProgress()
                if status {
                    Global.user = user
                    user?.saveInUserDefaults()
                    UserDefault[LOGINVALUES] = parameter
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .downloadedCities, object: nil)
                    }
                } else {
                    Utill.showToastWith(message)
                }
            }
        }
        else {
            Utill.showToastWith(Text.Message.noInternet)
        }
    }
    class func isiPhoneX() -> Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                return true
            default:
                return false
            }
        }
        return false
    }
    class func convertDateString(dateString : String!, fromFormat sourceFormat : String!, toFormat desFormat : String!) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceFormat
        let date = dateFormatter.date(from: dateString)
        dateFormatter.dateFormat = desFormat
        return dateFormatter.string(from: date!)
    }
    class func getStringFromDate(_ currentFormat:String,date:Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = currentFormat
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
    class func getLocalStringFromDate(_ currentFormat:String,date:Date,iden:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = currentFormat
        formatter.locale = Locale(identifier: iden)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        return formatter.string(from: date)
    }
    class func getDateFromString(_ currentFormat:String,dateStr:String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = currentFormat
        formatter.locale = Locale(identifier: "en_US")
        return formatter.date(from: dateStr)
    }
    
    class func GetDateserverToLocal(_ currentFormat:String,dateStr:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let localDate = dateFormatter.date(from: dateStr)
        return localDate
    }
    
    class func convertDateToString(_ currentFormat:String,toFormat:String,date:Date) -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = currentFormat

        let myString = formatter.string(from: date) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = toFormat
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }
    
    class func getCurrntDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let myString = formatter.string(from: Date()) // string purpose I add here
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = .current
        let myStringafd = formatter.string(from: yourDate!)
        return myStringafd
    }
    
    

    class func setRecentBooking(dict:[String:String]) {
        var arrSeacrh = [[String:String]]()
        arrSeacrh.append(dict)
        if let arr = UserDefault["RecentBooking"] as? [[String:String]] {
            arrSeacrh.append(contentsOf: arr)
        }
        UserDefault["RecentBooking"] = arrSeacrh
    }
    
    class func setRecentSearch()  {
        var arrSeacrh = [[String:String]]()
        var dictSearch = [String:String]()
        dictSearch["From"] = SelectedRoue.source.CM_CityName
        dictSearch["Fromid"] = SelectedRoue.source.CM_CityID
        dictSearch["To"] = SelectedRoue.destination.CM_CityName
        dictSearch["Toid"] = SelectedRoue.destination.CM_CityID
        dictSearch["Date"] = Utill.getStringFromDate("EEE MMM dd,yyyy", date: SelectedRoue.routeDate)
        arrSeacrh.append(dictSearch)
        if let arr = UserDefault["RecentSearch"] as? [[String:String]] {
            for dict in arr {
                if (dict["Fromid"] == SelectedRoue.source.CM_CityID && dict["Toid"] == SelectedRoue.destination.CM_CityID) {
                    
                } else  if (dict["Fromid"] == SelectedRoue.destination.CM_CityID && dict["Toid"] == SelectedRoue.source.CM_CityID) {
                    
                } else {
                    arrSeacrh.append(dict)
                }
            }
        }
        UserDefault["RecentSearch"] = arrSeacrh
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

// CheckUserRegister
class JSCheckUserRegi: Codable {
    let status: Int
    let message: String
    let data: [DBCheckReg]

    init(status: Int, message: String, data: [DBCheckReg]) {
        self.status = status
        self.message = message
        self.data = data
    }
}

// MARK: - Datum
class DBCheckReg: Codable {
    let loginStatus: Int
    let loginMsg: String

    enum CodingKeys: String, CodingKey {
        case loginStatus = "LoginStatus"
        case loginMsg = "LoginMsg"
    }

    init(loginStatus: Int, loginMsg: String) {
        self.loginStatus = loginStatus
        self.loginMsg = loginMsg
    }
}


/*
  class func checkVersion(FromLoginCall:Bool)  {
         if Utill.reachable() {
             Utill.showProgress()
             CheckVersionService.init().versionDetail { (json, status, message) in
                 Utill.dismissProgress()
                 if status {
                     if json["update_severity"].stringValue ==  "1" {
 //                        self.showVersionAlert(isForceFully: false)
                     } else if json["update_severity"].stringValue ==  "2" {
                         Utill.showVersionAlert()
                     } else {
                         if FromLoginCall == false {
                             checkUserRegistration()
                         }
 //                        Utill.showAlert(message: "You are using latest version", fromVC: Global.navigationController!, title: AppName)
                     }
                     
                 } else {
 //                    Utill.showToastWith(message)
                 }
             }
         } else {
 //            Utill.showToastWith(Text.Message.noInternet)
         }
     }
 */
