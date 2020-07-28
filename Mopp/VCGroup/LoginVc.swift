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
    
    @IBOutlet weak var RememberMeBtn: UIButton!
    @IBOutlet weak var SelectUniDrp: DropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetStatusofRememberme()
        GetUniverSity()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func LoginAction(_ sender: UIButton) {
        
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
    func GetUniverSity() {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        NetWorkCall.getApiCall { (<#[GetUnivercity]#>) in
            <#code#>
        }
            hud.dismiss()
          //  VerifyLoginApiData = T;
            //var views = self.storyboard?.instantiateViewController(identifier: "TabbWindow") as? UITabBarController
            // self.navigationController?.pu(views, animated: true)
            var arraySS=[String]()
            for point in datas{
                arraySS.append(point.name)
            }
        SelectUniDrp.optionArray=arraySS
         SelectUniDrp.didSelect{(selectedText , index ,id) in
         self.SelectUniDrp.text = "Selected String: \(selectedText) \n index: \(index)"
            self.SelectUniDrp.showList()
             }
         
            
            //self.viewControllers = controllers
        //}, BaseUrl:ClS.baseUrl , ApiName: ClS.getunivercity, Prams: parameter)
    }
    
    @IBAction func Selected_Univercity(_ sender: DropDown)
    {
         SelectUniDrp.showList()
    }
    
    
}
