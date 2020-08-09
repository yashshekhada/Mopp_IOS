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
    public static var baseUrl="http://mopp.virenmshah.com/api/";
    public static var getunivercity="getunivercity?";
    public static var login="login?";
    public static var campusjob="campusjob?";
    public static var forgotpassword="forgotpassword?";
    public static var getscholarshiplist="getscholarshiplist?"
    public static var Password_pts="Password_pts"
    public static var Email_pts="Email_pts"
    public static var Univercity_pts="Univercity_pts"
    public static var RememberMe_status="RememberMe_status"
    
    
    
    // SF Data
    public static var sf_Token = "Token"
      public static var sf_Name = "Name"
      public static var sf_Email = "Email"
    public static var sf_Status = "Status"
        public static var sf_University_id = "University_id"
      public static var sf_password = "password"
    public static var Token = iOTool.GetPref(Name: ClS.sf_Token)
    public static var University_id = iOTool.GetPref(Name: ClS.sf_University_id)
      
     
    
    
}
