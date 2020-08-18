//
//  LoginVc.swift
//  Mopp
//
//  Created by mac on 7/28/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import iOTool
import Alamofire
import iOSDropDown
import JGProgressHUD
class LoginVc: UIViewController {
    
    @IBOutlet weak var EmailAddreshTxt: UITextField!
    @IBOutlet weak var PswTxt: UITextField!
   //
    @IBOutlet weak var ForgotPasw_Btn: UIButton!
    @IBOutlet weak var RememberMeBtn: UIButton!
    @IBOutlet weak var SelectUniDrp: DropDown!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        SetStatusofRememberme()
        GetUniverSity()
        self.SelectUniDrp.didSelect{(selectedText , index ,id) in
               self.SelectUniDrp.text = (selectedText)
                //  self.SelectUniDrp.hideList()()
                      //self.SelectUniDrp.hideList()
                   }
    
        // Do any additional setup after loading the view.
        
        self.PswTxt.isSecureTextEntry = true
        
    }

    
    @IBAction func btnPasswordShowHideTapped(_ sender: UIButton)
    {
        if self.PswTxt.isSecureTextEntry {
            self.PswTxt.isSecureTextEntry = false
            sender.setImage(#imageLiteral(resourceName: "eye"), for: .normal)
        } else {
            self.PswTxt.isSecureTextEntry = true
            sender.setImage(#imageLiteral(resourceName: "hide"), for: .normal)
        }
    }
    
    @IBAction func LoginAction(_ sender: UIButton) {
        
        if EmailAddreshTxt.text != "" && PswTxt.text != ""
        {
            let username=EmailAddreshTxt.text
            let password=PswTxt.text
            LoginApi(username: username!, password: password!, UniversityType:String(GetUnivercityData[SelectUniDrp.selectedIndex!].id!) )
        }
        else
        {
            self.view.makeToast("Please Enter Email & Password")
        }
    }
    @IBAction func SelectRmemberMe(_ sender: Any) {
        
        SetStatusofRememberme()
    }
    
    func SetStatusofRememberme(){
        let status = iOTool.GetPref(Name:  ClS.RememberMe_status)
        if (status == "0" || status == "") {
            iOTool.SavePref(Name:  ClS.RememberMe_status, Value: "1")
            RememberMeBtn.setImage(#imageLiteral(resourceName: "check-box"), for: .normal)
            
        }
        
        if status == "1" {
            iOTool.SavePref(Name:  ClS.RememberMe_status, Value: "0")
            RememberMeBtn.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
            
            //  RememberMeBtn.setImage(uiima, for: .normal)
            
        }
    }
    var GetUnivercityData=[GetUnivercity_Data]()
    func GetUniverSity() {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
 //   var GetUnivercityData:GetUnivercity
        let parameter:[String:Any]=["":""]
        NetWorkCall.get_Api_Call(completion: { (T: GetUnivercity) in
            hud.dismiss()
          //  VerifyLoginApiData = T;
            //var views = self.storyboard?.instantiateViewController(identifier: "TabbWindow") as? UITabBarController
            // self.navigationController?.pu(views, animated: true)
            self.GetUnivercityData = T.data!
            var arraySS=[String]()
            var arraySSid = [String]()
            for point in self.GetUnivercityData{
                arraySS.append(point.name!)
                 arraySSid.append(point.name!)
            }
            self.SelectUniDrp.optionArray=arraySS
          
           
        }, BaseUrl:ClS.baseUrl , ApiName: ClS.getunivercity, Prams: parameter)
     
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
        "device_token":ud.value(forKey: "deviceToken") as? String ?? ""]
           NetWorkCall.get_Post_Api_Call(completion: { (T: UserData_m) in
               hud.dismiss()
             
            if (T.statusCode == 1){
                iOTool.SavePref(Name: ClS.sf_Token, Value: T.data!.api_token!)
                iOTool.SavePref(Name: ClS.sf_Name, Value: T.data!.name!)
                iOTool.SavePref(Name: ClS.sf_Email, Value: T.data!.email!)
                iOTool.SavePref(Name: ClS.sf_Email, Value: T.data!.email!)
                       iOTool.SavePref(Name: ClS.sf_User_id, Value: String(T.data!.id!))
                  iOTool.SavePref(Name: ClS.sf_Status, Value: "1")
                iOTool.SavePref(Name: ClS.sf_University_id, Value: String(T.data!.univercity_id!))
                if self.RememberMeBtn.currentImage == #imageLiteral(resourceName: "check-box"){
                    iOTool.SavePref(Name: ClS.sf_password, Value: password)
                
                    /*let vc = mainStoryBrd.instantiateViewController(withIdentifier: "HomeNavBar")
                    UIApplication.shared.windows.first?.rootViewController = vc
                    UIApplication.shared.windows.first?.makeKeyAndVisible()*/
                    let mainViewController = HomeNavBar()
                    let story = UIStoryboard(name: "Main", bundle:nil)
                    let vc = story.instantiateViewController(withIdentifier: "DrawerControllers")
                    UIApplication.shared.windows.first?.rootViewController = vc
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                }
            }
            else{
                let alertController = UIAlertController(title: ClS.App_Name, message:
                      T.statusMsg  , preferredStyle: .alert)
                   alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                   self.present(alertController, animated: true, completion: nil)
            }
             
              
           },  BaseUrl:ClS.baseUrl , ApiName: ClS.login, Prams: parameter)
         
       }
       
    @IBAction func SinupPage(_ sender: UIButton) {
        let page = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(page, animated: true)
    }
    
    @IBAction func Selected_Univercity(_ sender: DropDown)
    {
        // SelectUniDrp.hideList()()
    }
    
    @IBAction func MovetoForgotPsw(_ sender: Any) {
        let page = storyboard?.instantiateViewController(withIdentifier: "ForgotPassword") as! ForgotPassword
        self.navigationController?.pushViewController(page, animated: true)
    }
    
}
