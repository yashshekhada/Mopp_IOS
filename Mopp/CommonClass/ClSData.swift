//
//  ClS.swift
//  Mopp
//
//  Created by mac on 7/25/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
import iOTool
public  class ClS{
    public static let head = ["Content-Type": "application/json"]
    
    public static var App_Name = "Mopp: Only What Matters"
    public static var baseUrl=DomainName+"/api/"//"http://mopp.virenmshah.com/api/";
    public static var serverKEY="AAAALkXbBIM:APA91bE4M_oAw1XM8rJ6j5AkZPNFmfWtMaZ4As968WCPBn7DqmlEcDCeY47DK9E5thNywn58NZ8WpQwavjaNumVCCuQTGidDCiacJDKrw997wDqsk0NOEb85x_icZgQIrP3bt1eYFLfr"
        public static var SelectedDomainName="SelectedDomainName"
    public static var DomainName=""
    public static var ImageUrl=DomainName+"/images/";
    public static var getunivercity="getunivercity?";
    public static var login="login?";
    public static var campusjob="campusjob?";
    public static var forgotpassword="forgotpassword?";
    public static var getpostlist="getpostlist"
    public static var postdelete="postdelete"
    public static var getscholarshiplist="getscholarshiplist?"
    public static var Password_pts="Password_pts"
    public static var Email_pts="Email_pts"
    public static var Univercity_pts="Univercity_pts"
    public static var RememberMe_status="RememberMe_status"
    public static var getcomment="getcomment"
    public static var postcomment="postcomment"
    public static var getproduct="getproduct"
    public static var postlike="postlike"
    public static var getmyproduct="getmyproduct"
    public static var createproduct="createproduct"
    public static var deleteproduct="deleteproduct"
    public static var register="register"
    public static var otpvarification="otpvarification"
    public static var logout="logout"
    public static var createpost="createpost"
    public static var jobapply="jobapply"
    public static var scholarshipapply="scholarshipapply"
    public static var updateprofile="updateprofile"
    
    // SF Data
    public static var sf_Token = "Token"
    public static var sf_User_id = "User_id"
    public static var sf_Name = "Name"
    public static var sf_Email = "Email"
    public static var sf_Status = "Status"
    public static var sf_University_id = "University_id"
    public static var sf_Uid = "Uid"
    public static var Sf_DataOfNotification="DataOfNotification"
    public static var sf_password = "password"
    public static var Token = iOTool.GetPref(Name: ClS.sf_Token)
    public static var University_id = iOTool.GetPref(Name: ClS.sf_University_id)
    public static var user_id = iOTool.GetPref(Name: ClS.sf_User_id)
    public static var Uid = iOTool.GetPref(Name: ClS.sf_Uid)
    public static var FCMtoken=""// = iOTool.GetPref(Name: ClS.sf_Token)
     public static var DataOfNotification = iOTool.GetPref(Name: ClS.Sf_DataOfNotification)
    
    public static var PageSize = 10
    
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension Date {
    func getElapsedInterval() -> String {
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Bundle.main.preferredLocalizations[0])
        // IF THE USER HAVE THE PHONE IN SPANISH BUT YOUR APP ONLY SUPPORTS I.E. ENGLISH AND GERMAN
        // WE SHOULD CHANGE THE LOCALE OF THE FORMATTER TO THE PREFERRED ONE
        // (IS THE LOCALE THAT THE USER IS SEEING THE APP), IF NOT, THIS ELAPSED TIME
        // IS GOING TO APPEAR IN SPANISH
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        formatter.calendar = calendar
        
        var dateString: String?
        
        let interval = calendar.dateComponents([.year, .month, .weekOfYear, .day], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            formatter.allowedUnits = [.year] //2 years
        } else if let month = interval.month, month > 0 {
            formatter.allowedUnits = [.month] //1 month
        } else if let week = interval.weekOfYear, week > 0 {
            formatter.allowedUnits = [.weekOfMonth] //3 weeks
        } else if let day = interval.day, day > 0 {
            formatter.allowedUnits = [.day] // 6 days
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: Bundle.main.preferredLocalizations[0]) //--> IF THE USER HAVE THE PHONE IN SPANISH BUT YOUR APP ONLY SUPPORTS I.E. ENGLISH AND GERMAN WE SHOULD CHANGE THE LOCALE OF THE FORMATTER TO THE PREFERRED ONE (IS THE LOCALE THAT THE USER IS SEEING THE APP), IF NOT, THIS ELAPSED TIME IS GOING TO APPEAR IN SPANISH
            dateFormatter.dateStyle = .medium
            dateFormatter.doesRelativeDateFormatting = true
            
            dateString = dateFormatter.string(from: self) // IS GOING TO SHOW 'TODAY'
        }
        
        if dateString == nil {
            dateString = formatter.string(from: self, to: Date())
        }
        
        return dateString!
    }
}
extension Date {

    func timeAgoSinceDate() -> String {

        // From Time
        let fromDate = self

        // To Time
        let toDate = Date()

        // Estimation
        // Year
        if let interval = Calendar.current.dateComponents([.year], from: fromDate, to: toDate).year, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "year ago" : "\(interval)" + " " + "years ago"
        }

        // Month
        if let interval = Calendar.current.dateComponents([.month], from: fromDate, to: toDate).month, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "month ago" : "\(interval)" + " " + "months ago"
        }

        // Day
        if let interval = Calendar.current.dateComponents([.day], from: fromDate, to: toDate).day, interval > 0  {

            return interval == 1 ? "\(interval)" + " " + "day ago" : "\(interval)" + " " + "days ago"
        }

        // Hours
        if let interval = Calendar.current.dateComponents([.hour], from: fromDate, to: toDate).hour, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "hour ago" : "\(interval)" + " " + "hours ago"
        }

        // Minute
        if let interval = Calendar.current.dateComponents([.minute], from: fromDate, to: toDate).minute, interval > 0 {

            return interval == 1 ? "\(interval)" + " " + "minute ago" : "\(interval)" + " " + "minutes ago"
        }

        return "a moment ago"
    }
}
extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
