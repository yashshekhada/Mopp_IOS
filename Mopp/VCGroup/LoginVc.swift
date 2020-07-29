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
    override func viewDidLoad() {
        super.viewDidLoad()
        SetStatusofRememberme()
        GetUniverSity()
        self.SelectUniDrp.didSelect{(selectedText , index ,id) in
               self.SelectUniDrp.text = (selectedText)
                //  self.SelectUniDrp.hideList()()
                      //self.SelectUniDrp.hideList()
                   }
    
        // Do any additional setup after loading the view.
    }

    @IBAction func LoginAction(_ sender: UIButton) {
        
        let username=EmailAddreshTxt.text
        let password=PswTxt.text
        LoginApi(username: username!, password: password!, UniversityType:String(GetUnivercityData[SelectUniDrp.selectedIndex!].id) )
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
            self.GetUnivercityData=T.data
            var arraySS=[String]()
            for point in self.GetUnivercityData{
                arraySS.append(point.name)
            }
            self.SelectUniDrp.optionArray=arraySS
          
           
        }, BaseUrl:ClS.baseUrl , ApiName: ClS.getunivercity, Prams: parameter)
     
    }
    func LoginApi(username:String,password:String,UniversityType:String ) {
           let hud = JGProgressHUD(style: .light)
           hud.textLabel.text = "Loading"
           hud.show(in: self.view)
    //   var GetUnivercityData:GetUnivercity
           let parameter:[String:Any]=["":""]
           NetWorkCall.get_Api_Call(completion: { (T: UserData_m) in
               hud.dismiss()
             
            _ =  T
              
             
              
           }, BaseUrl:ClS.baseUrl , ApiName: ClS.login+"logintype=0&university_id="+UniversityType+"&email="+username+"&password="+username, Prams: parameter)
         
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
