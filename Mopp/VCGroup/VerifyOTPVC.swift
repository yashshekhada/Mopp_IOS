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
import FirebaseAuth
import FirebaseDatabase
import iOTool
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
                
             //   hud.dismiss()
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
                             //   Auth.auth().signIn(withEmail:   SignUpVC.dataCompose["email"] as! String, password:   SignUpVC.dataCompose["password"] as! String) {
                                Auth.auth().createUser(withEmail: SignUpVC.dataCompose["email"] as! String, password:   SignUpVC.dataCompose["password"] as! String) { authResult, error in
                                  if let error = error as? NSError {
                                    switch AuthErrorCode(rawValue: error.code) {
                                    case .operationNotAllowed: break
                                      // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                                    case .emailAlreadyInUse: break
                                      // Error: The email address is already in use by another account.
                                    case .invalidEmail: break
                                      // Error: The email address is badly formatted.
                                    case .weakPassword: break
                                      // Error: The password must be 6 characters long or more.
                                    default:
                                        print("Error: \(error.localizedDescription)")
                                    }
                                  } else {
                                    print("User signs up successfully")
                                    let UIDS = Auth.auth().currentUser?.uid
                                    let data : [String : Any] =
                                        ["email": SignUpVC.dataCompose["email"] as! String,
                                         "last_name": SignUpVC.dataCompose["l_name"] as! String,
                                         "name": SignUpVC.dataCompose["f_name"] as! String,
                                         "online": true,
                                           "uni_id": SignUpVC.dataCompose["university_id"] as! String,
                                         "photo": ""]
                                    
                                    //   ref1.setValue(Mail)
                                    ClS.Uid=UIDS!
                                    Database.database().reference().child("Students").child(ClS.Uid).setValue(data)
                                    self.LoginApi(username: SignUpVC.dataCompose["email"] as! String, password: SignUpVC.dataCompose["password"] as! String, UniversityType: SignUpVC.dataCompose["university_id"] as! String)
                                  }
                                }
                               // self.APICallingLogin()
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
    func LoginApi(username:String,password:String,UniversityType:String ) {
           let hud = JGProgressHUD(style: .light)
           hud.textLabel.text = "Loading"
           hud.show(in: self.view)
           //   var GetUnivercityData:GetUnivercity
           let parameter:[String:Any]=["logintype":"0",
                                       "university_id":UniversityType,
                                       "email":username,
                                       "password":password,
                                       "device_token":ClS.FCMtoken]
           NetWorkCall.get_Post_Api_Call(completion: { (T: UserData_m) in
               hud.dismiss()
               
               if (T.statusCode == 1){
                   Auth.auth().signIn(withEmail: username, password: password, completion: { (authResult, error) in
                       if error == nil {
                           if let user = authResult?.user {
                               
                               let uisd = user.uid
                               iOTool.SavePref(Name: ClS.sf_Uid, Value: uisd)
                               iOTool.SavePref(Name: ClS.sf_Token, Value: T.data!.api_token!)
                               iOTool.SavePref(Name: ClS.sf_Name, Value: T.data!.name!)
                               iOTool.SavePref(Name: ClS.sf_Email, Value: T.data!.email!)
                               iOTool.SavePref(Name: ClS.sf_Email, Value: T.data!.email!)
                               iOTool.SavePref(Name: ClS.sf_User_id, Value: String(T.data!.id!))
                               iOTool.SavePref(Name: ClS.sf_Status, Value: "1")
                               iOTool.SavePref(Name: ClS.sf_University_id, Value: String(T.data!.univercity_id!))
                               ClS.Uid=user.uid
                            ClS.Token = iOTool.GetPref(Name: ClS.sf_Token)
                               ud.set(String(T.data!.univercity_id!), forKey: "uni_id")
                                                           
                               let dict:NSDictionary = ["id":T.data!.id!,"image":T.data!.image!,"name":T.data!.name!,"l_name":T.data!.l_name!,"username":T.data!.username!,"univercity_id":T.data!.univercity_id!,"univercity_name":T.data!.univercity_name!,"email":T.data!.email!,"dob":T.data!.dob!,"gender":T.data!.gender!,"qualification":T.data!.qualification!,"country":T.data!.country!,"city":T.data!.city!,"phone_number":T.data!.phone_number!]
                               ud.set(dict, forKey: "LoginData")
                               ud.synchronize()
                               
                               Database.database().reference().child("Tokens").child(user.uid).setValue(["device_token":ClS.FCMtoken])//("online")
                               print(ud.value(forKey: "LoginData") as! NSDictionary)
                              
                           }
                           print("Email user authenticated with firebase")
                           
                           self.dismiss(animated: true, completion: nil)
                        //let mainViewController = HomeNavBar()
                                                      let story = UIStoryboard(name: "Main", bundle:nil)
                                                      let vc = story.instantiateViewController(withIdentifier: "DrawerControllers")
                                                      UIApplication.shared.windows.first?.rootViewController = vc
                                                      UIApplication.shared.windows.first?.makeKeyAndVisible()
                       }else {
                           
                       }
                   })
                   
               }
               else{
                   let alertController = UIAlertController(title: ClS.App_Name, message:
                       T.statusMsg  , preferredStyle: .alert)
                   alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                   
                   self.present(alertController, animated: true, completion: nil)
               }
               
               
           },  BaseUrl:ClS.baseUrl , ApiName: ClS.login, Prams: parameter)
           
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
