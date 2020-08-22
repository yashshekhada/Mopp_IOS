//
//  VerifyOTPVC.swift
//  Mopp
//
//  Created by apple on 17/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD
import Alamofire

class VerifyOTPVC: UIViewController
{
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var txtEnterOTP: UITextField!
    @IBOutlet weak var btnReSendVerify: UIButton!
    
    var timeRemaining:Int = 120
    var timerOTP = Timer()
    
    var dictRegData:NSDictionary?
    
    //MARK: - LifeCycle Method
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if #available(iOS 12.0, *) {
            self.txtEnterOTP.textContentType = .oneTimeCode
        } else {
            // Fallback on earlier versions
        }
        self.timerOTP = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning(timer:)), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        self.timerOTP.invalidate()
    }
    
    //MARK: - Selector Methods
    @objc func timerRunning(timer:Timer)
    {
        timeRemaining -= 1
        
        if timeRemaining >= 0
        {
            let minutesLeft = Int(timeRemaining) / 60 % 60
            let secondsLeft = Int(timeRemaining) % 60
            let time =  String(format:"%02i:%02i",minutesLeft,secondsLeft)
            self.lblTimer.text = time
            self.btnReSendVerify.setTitle("Verify", for: .normal)
        }
        else
        {
            self.timerOTP.invalidate()
            self.btnReSendVerify.setTitle("Resend", for: .normal)
            //timeRemaining = 120
        }
    }
    
    //MARK: - IBAction Methods
    @IBAction func btnReSendVerifyTapped(_ sender: UIButton)
    {
        if sender.currentTitle == "Verify"
        {
            if self.txtEnterOTP.text != "" {
                APICallingOTPVarification()
            }
        } else {
            timeRemaining = 120
            self.timerOTP = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning(timer:)), userInfo: nil, repeats: true)
            APICallingReSendEmail()
        }
    }
    
    //MARK: - AICalling Methods
    func APICallingOTPVarification()
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        if Utill.reachable()
        {
            var param = [String:String]()
            let email = self.dictRegData!["email"] as? String ?? ""
            param = ["email":email,"otp":self.txtEnterOTP.text!]
            
            print(param)
            let apiUrl:String = ClS.baseUrl + "otpvarification"
            let requestOfAPI = AF.request(apiUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
            requestOfAPI.responseJSON { (response) in
                
                hud.dismiss()
                print(response)
                
                switch response.result{
                    
                case .success(let resultData):
                    
                    if let dict = resultData as? Dictionary<String,AnyObject>
                    {
                        let statusMsg = dict["statusMsg"] as? String ?? ""
                        print("otpvarification : \(statusMsg)")
                        
                        if let statusCode = dict["statusCode"] as? NSNumber
                        {
                            if statusCode == 1
                            {
                                self.APICallingLogin()
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
    
    func APICallingReSendEmail()
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        if Utill.reachable()
        {
            var param = [String:String]()
            let email = self.dictRegData!["email"] as? String ?? ""
            param = ["email":email]
            
            print(param)
            let apiUrl:String = ClS.baseUrl + "resendemail"
            let requestOfAPI = AF.request(apiUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
            requestOfAPI.responseJSON { (response) in
                
                hud.dismiss()
                print(response)
                
                switch response.result{
                    
                case .success(let resultData):
                    
                    if let dict = resultData as? Dictionary<String,AnyObject>
                    {
                        let statusMsg = dict["statusMsg"] as? String ?? ""
                        print("resendemail : \(statusMsg)")
                        
                        if let statusCode = dict["statusCode"] as? NSNumber
                        {
                            if statusCode == 1
                            {
                                print("statusMsg: \(statusMsg)")
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
    
    func APICallingLogin()
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        if Utill.reachable()
        {
            var param = [String:String]()
            param = self.dictRegData! as! [String : String]
            
            print(param)
            let apiUrl:String = ClS.baseUrl + "login"
            let requestOfAPI = AF.request(apiUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
            requestOfAPI.responseJSON { (response) in
                
                hud.dismiss()
                print(response)
                
                switch response.result{
                    
                case .success(let resultData):
                    
                    if let dict = resultData as? Dictionary<String,AnyObject>
                    {
                        let statusMsg = dict["statusMsg"] as? String ?? ""
                        print("login : \(statusMsg)")
                        
                        if let statusCode = dict["statusCode"] as? NSNumber
                        {
                            if statusCode == 1
                            {
                                //let mainViewController = HomeNavBar()
                                let story = UIStoryboard(name: "Main", bundle:nil)
                                let vc = story.instantiateViewController(withIdentifier: "DrawerControllers")
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
