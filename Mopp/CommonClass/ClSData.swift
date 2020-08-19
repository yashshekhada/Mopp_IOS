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
    public static var baseUrl="http://mopp.impm.in/api/"//"http://mopp.virenmshah.com/api/";
    public static var ImageUrl="http://mopp.impm.in/images/";
    public static var getunivercity="getunivercity?";
    public static var login="login?";
    public static var campusjob="campusjob?";
    public static var forgotpassword="forgotpassword?";
    public static var getpostlist="getpostlist"
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
    
    // SF Data
    public static var sf_Token = "Token"
    public static var sf_User_id = "User_id"
    public static var sf_Name = "Name"
    public static var sf_Email = "Email"
    public static var sf_Status = "Status"
    public static var sf_University_id = "University_id"
    
    public static var sf_password = "password"
    public static var Token = iOTool.GetPref(Name: ClS.sf_Token)
    public static var University_id = iOTool.GetPref(Name: ClS.sf_University_id)
    public static var user_id = iOTool.GetPref(Name: ClS.sf_User_id)
    
    
    
    
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
