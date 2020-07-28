//
//  NetWorkCall.swift
//  Mopp
//
//  Created by mac on 7/25/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import iOTool
public class NetWorkCall{
    
    
    
    
    public static func get_Api_Call_university (completion: @escaping ([GetUnivercity]) -> ()) {
        
        
        var Array=[GetUnivercity]()
        if Utill.reachable() {
            let url =  URL(string: ClS.baseUrl+ClS.getunivercity)!
            // Utill.showProgress()
            
            
            AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
                //   Utill.dismissProgress()
                switch(response.result) {
                case .success(_):
                    DispatchQueue.main.async {
                        if let dataa = response.value {
                            let json = JSON(dataa)
                            if json["statusCode"].stringValue == "1"  {
                                let Datas = json["data"].array
                                for point in Datas! {
                                    Array.append(GetUnivercity(parameter: point))
                                }
                            
                               
                                //    Utill.showToastWith(json["message"].stringValue)
                            }
                        }
                    }
                case .failure(_):
                    //     Utill.showToastWith("Error")
                    break
                }
            }
             completion(Array)
        }
        
      //  return Array
        
    }
    
}

