//
//  DrawerViewController.swift
//  Mopp
//
//  Created by mac on 8/17/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import iOTool
class DrawerViewController: UIViewController
{
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    

    //MARK: - IBAction Methods
    @IBAction func btnLogoutTapped(_ sender: UIButton)
    {
        APICallingLogout()
    }
    
    @IBAction func btnProfileTapped(_ sender: UIButton)
    {
    }
    
    @IBAction func btnMyPostTapped(_ sender: UIButton)
    {
        let page = mainStoryBrd.instantiateViewController(withIdentifier: "MyPostVC") as! MyPostVC
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    @IBAction func Myproduct(_ sender: UIButton)
    {
       let page = storyboard?.instantiateViewController(withIdentifier: "MyproductVc") as! MyproductVc
       self.navigationController?.pushViewController(page, animated: true)
    }
    
    //MARK: - AICalling Methods
    func APICallingLogout()
    {
        let hud = JGProgressHUD(style: .light)
        //hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        if Utill.reachable()
        {
            var param = [String:String]()
            param = ["session_token": ClS.Token]
            
            print(param)
            let apiUrl:String = ClS.baseUrl + "logout"
            let requestOfAPI = AF.request(apiUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
            requestOfAPI.responseJSON { (response) in
                
                hud.dismiss()
                print(response)
                
                switch response.result{
                    
                case .success(let resultData):
                    
                    if let dict = resultData as? Dictionary<String,AnyObject>
                    {
                        let statusMsg = dict["statusMsg"] as? String ?? ""
                        print("logout : \(statusMsg)")
                        
                        if let statusCode = dict["statusCode"] as? NSNumber
                        {
                            if statusCode == 0
                            {
                           //     let vc = mainStoryBrd.instantiateViewController(withIdentifier: "NavLogin") as! NavigationController
                             //   self.navigationController?.pushViewController(vc, animated: true)
                                iOTool.SavePref(Name: ClS.sf_Token, Value: "")
                                              iOTool.SavePref(Name: ClS.sf_Name, Value:"")
                                              iOTool.SavePref(Name: ClS.sf_Email, Value: "")
                                              iOTool.SavePref(Name: ClS.sf_Email, Value:"")
                                                     iOTool.SavePref(Name: ClS.sf_User_id, Value: "")
                                                iOTool.SavePref(Name: ClS.sf_Status, Value: "0")
                                              iOTool.SavePref(Name: ClS.sf_University_id, Value: "")
                                let story = UIStoryboard(name: "Main", bundle:nil)
                                 let vc = story.instantiateViewController(withIdentifier: "NavigationController") as! NavigationController
                                 UIApplication.shared.windows.first?.rootViewController = vc
                                 UIApplication.shared.windows.first?.makeKeyAndVisible()
                            }
                            else
                            {
                                var alertController = UIAlertController()
                                alertController = UIAlertController(title: ClS.App_Name, message: statusMsg, preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                    }
                    
                case .failure(_):
                    let error = "\(response)"
                    print(error)
                }
            }
        }
    }
}
