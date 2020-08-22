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
    
    
    
    
    public static func get_Api_Call<T:Decodable>(completion: @escaping (T) -> (),BaseUrl:String, ApiName: String, Prams: [String:Any]) {
        
        
        //   var Array=[GetUnivercity]()
        if Utill.reachable() {
            let url =  URL(string: ClS.baseUrl+ApiName)!
            // Utill.showProgress()
        
            AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
                //   Utill.dismissProgress()
                switch(response.result) {
                case .success(_):
                    if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                        
                        guard let data = response.data else {
                            
                            print("Error: No data to decode")
                            
                            return
                            
                        }
                        
                        guard let blog = try? JSONDecoder().decode(T.self, from: data) else {
                            
                            print("Errors: Couldn't decode data into Blog")
                            return
                            
                        }
                      //  completion(blog)
                      
                        completion(blog)
                      //  blo
                        
                        
                    }
                        
                    else if response.response?.statusCode == 0{
                        
                    }
                        
                    else  {
                        
                        if let _ = response.value as? Error {
                            
                        }
                        
                    }
                    
                case .failure(_):
                    //     Utill.showToastWith("Error")
                    break
                }
            }
            //completion(Array)
        }
        
        //  return Array
        
    }
    public static func get_Post_Api_Call<T:Decodable>(completion: @escaping (T) -> (),BaseUrl:String, ApiName: String, Prams: [String:Any]) {
   
        if Utill.reachable() {
              let url =  URL(string: ClS.baseUrl+ApiName)!
              //0.
          //  Utill.showProgress()
          let headers = ["Content-Type": "application/json"]
       
          if let data = try? JSONSerialization.data(withJSONObject: Prams, options: .prettyPrinted),
              
              let str = String(data: data, encoding: .utf8) {
          
          }
          
              AF.request(url, method: .post,parameters: Prams, encoding: JSONEncoding.default).responseJSON { (response) -> Void in
                  //   Utill.dismissProgress()
                  switch(response.result) {
                  case .success(_):
                      if response.response?.statusCode == 200 || response.response?.statusCode == 201 {
                          
                          guard let data = response.data else {
                              
                              print("Error: No data to decode")
                              
                              return
                              
                          }
                          
                          guard let blog = try? JSONDecoder().decode(T.self, from: data) else {
                              
                              print("Errors: Couldn't decode data into Blog")
                              return
                              
                          }
                        //  completion(blog)
                        
                          completion(blog)
                        //  blo
                          
                          
                      }
                          
                      else if response.response?.statusCode == 0{
                          
                      }
                          
                      else  {
                          
                          if let _ = response.value as? Error {
                              
                          }
                          
                      }
                      
                  case .failure(_):
                      //     Utill.showToastWith("Error")
                      break
                  }
              }
              //completion(Array)
          }
          
          //  return Array
          
      }
}

