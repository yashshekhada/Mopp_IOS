//
//  RUUtill.swift
//  RateUs
//
//  Created by Abhijit Soni on 19/03/17.
//  Copyright © 2017 Abhijit Soni. All rights reserved.
//

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
 

    class func uuid() -> String {
        let uniqueString: CFUUID = CFUUIDCreate(nil)
        let isString: CFString = CFUUIDCreateString(nil, uniqueString)
        return isString as String
    }
    class func showToastWith(_ message:String) {
        KSToastView.ks_showToast(message, duration: 1.5)
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
    
   
    class func reachable() -> Bool {
    let reachability = Reachability.forInternetConnection()
    if (reachability?.isReachableViaWiFi())! || (reachability?.isReachableViaWWAN())!{
    return true
    }
    return false
    }

    
    
    
    /// This function set root storyboard from condition
 
   
   
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
