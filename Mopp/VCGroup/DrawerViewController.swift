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

class DrawerViewController: UIViewController
{
    var reachability:Reachability?
    
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
        
        let reachbility = Reachability.init()
        self.reachability = reachbility
        
        if ((reachability?.isReachable) != nil)
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
                            if statusCode == 1
                            {
                                let vc = mainStoryBrd.instantiateViewController(withIdentifier: "LoginVc") as! LoginVc
                                self.navigationController?.pushViewController(vc, animated: true)
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
