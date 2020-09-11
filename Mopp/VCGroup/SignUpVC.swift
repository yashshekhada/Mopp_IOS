//
//  SignUpVC.swift
//  Mopp
//
//  Created by mac on 7/31/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import iOTool
import YYCalendar
import JGProgressHUD
import iOSDropDown
import Alamofire

class SignUpVC: UIViewController
{
    @IBOutlet weak var CheckBox_btn: UIButton!
    @IBOutlet weak var SelectUniDrp: DropDown!
    @IBOutlet weak var Birthdat_Txt: UITextField!
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    var GetUnivercityData=[GetUnivercity_Data]()
   
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.txtPassword.isSecureTextEntry = true
        self.txtConfirmPassword.isSecureTextEntry = true
        CheckBox_btn.setImage(#imageLiteral(resourceName: "check-box"), for: .normal)
        
        GetUniverSity()
        self.SelectUniDrp.didSelect{(selectedText , index ,id) in
            self.SelectUniDrp.text = (selectedText)
        }
    }
    
    //MARK: - Custom Methods
    func GetUniverSity()
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
    //   var GetUnivercityData:GetUnivercity
        let parameter:[String:Any]=["":""]
        NetWorkCall.get_Api_Call(completion: { (T: GetUnivercity) in
            hud.dismiss()
       
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
    
    func SetStatusofRememberme()
    {
        let status = iOTool.GetPref(Name:  ClS.RememberMe_status)
        if (status == "0" || status == "") {
            iOTool.SavePref(Name:  ClS.RememberMe_status, Value: "1")
            CheckBox_btn.setImage(#imageLiteral(resourceName: "check-box"), for: .normal)
            
        }
        
        if status == "1" {
            iOTool.SavePref(Name:  ClS.RememberMe_status, Value: "0")
            CheckBox_btn.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
            
            //  RememberMeBtn.setImage(uiima, for: .normal)
            
        }
    }
    
    //MARK: - Validation Method
    func checkAllField() -> Bool
    {
        var isAllFill = true
        
        if (self.txtFirstName.text?.isEmpty)!
        {
            setValidationOnTextfield(placeholderString: "Enter First Name*", textfiled: txtFirstName)
            isAllFill = false
        }
        if (self.txtLastName.text?.isEmpty)!
        {
            setValidationOnTextfield(placeholderString: "Enter Last Name*", textfiled: txtLastName)
            isAllFill = false
        }
        if (self.txtUserName.text?.isEmpty)!
        {
            setValidationOnTextfield(placeholderString: "Enter User Name*", textfiled: txtUserName)
            isAllFill = false
        }
        if (self.SelectUniDrp.text?.isEmpty)!
        {
            setValidationOnTextfield(placeholderString: "Select Your University / College*", textfiled: self.SelectUniDrp)
            isAllFill = false
        }
        if (self.txtEmailAddress.text?.isEmpty)!
        {
            setValidationOnTextfield(placeholderString: "Enter Your Email Address*", textfiled: txtEmailAddress)
            isAllFill = false
        }
        if (self.Birthdat_Txt.text?.isEmpty)!
        {
            setValidationOnTextfield(placeholderString: "Enter Your Birth Date*", textfiled: Birthdat_Txt)
            isAllFill = false
        }
        if (self.txtPassword.text?.isEmpty)!
        {
            setValidationOnTextfield(placeholderString: "Enter Password*", textfiled: txtPassword)
            isAllFill = false
        }
        if (self.txtConfirmPassword.text?.isEmpty)!
        {
            setValidationOnTextfield(placeholderString: "Enter Confirm Password*", textfiled: txtConfirmPassword)
            isAllFill = false
        }
        return isAllFill
    }
    
    //MARK: - IBAction Methods
    @IBAction func SelectDate(_ sender: Any)
    {
        DispatchQueue.main.async {
        let date = Date()
        let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            let result = formatter.string(from: date)
        let calendar = YYCalendar(normalCalendarLangType: .ENG, date: result, format: "MM/dd/yyyy") { date in
            self.Birthdat_Txt.text=date
        }
            calendar.headerViewBackgroundColor = UIColor.init(named: "TitleColor")!
        calendar.show()
        }
    }
    
    @IBAction func BackEvent(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func EventAgree(_ sender: UIButton)
    {
        self.view.endEditing(true)
        SetStatusofRememberme()
    }
    
    @IBAction func btnPasswordShowHideTapped(_ sender: UIButton)
    {
        if sender.tag == 1001 {
            if self.txtPassword.isSecureTextEntry {
                self.txtPassword.isSecureTextEntry = false
                sender.setImage(#imageLiteral(resourceName: "eye"), for: .normal)
            } else {
                self.txtPassword.isSecureTextEntry = true
                sender.setImage(#imageLiteral(resourceName: "hide"), for: .normal)
            }
        } else {
            if self.txtConfirmPassword.isSecureTextEntry {
                self.txtConfirmPassword.isSecureTextEntry = false
                sender.setImage(#imageLiteral(resourceName: "eye"), for: .normal)
            } else {
                self.txtConfirmPassword.isSecureTextEntry = true
                sender.setImage(#imageLiteral(resourceName: "hide"), for: .normal)
            }
        }
    }
    
    @IBAction func btnSignUpTapped(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        let isallfill = checkAllField()
        if isallfill
        {
            let isEmailAddressValid = isValidEmailAddress(emailAddressString: self.txtEmailAddress.text!)
            if isEmailAddressValid
            {
                print("Email address is valid")
            } else {
                self.view.makeToast("Email address is not valid")
            }
            
            if self.txtPassword.text == self.txtConfirmPassword.text {
                if self.CheckBox_btn.currentImage == #imageLiteral(resourceName: "check-box") {
                    let postFix = GetUnivercityData[SelectUniDrp.selectedIndex!].postfix!
                    if self.txtEmailAddress.text!.hasSuffix(postFix){
                        self.APICallingRegister()
                    } else {
                        self.view.makeToast("Please enter university registered email")
                    }
                } else {
                    self.view.makeToast("Please Check Terms & Conditions")
                }
            }
            else{
                self.view.makeToast("The Password confirmation does not match..")
            }
        }
        else
        {
            self.view.makeToast("Please Fill All Mandatory fields..")
        }
    }
    public static var dataCompose = [String : Any]()
    //MARK: - AICalling Methods
    func APICallingRegister()
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        if Utill.reachable()
        {
            var param = [String:String]()
            param = ["f_name":self.txtFirstName.text!,
                     "l_name":self.txtLastName.text!,
                     "email":self.txtEmailAddress.text!,
                     "password":self.txtPassword.text!,
                     "username":self.txtUserName.text!,
                     "university_id":String(GetUnivercityData[SelectUniDrp.selectedIndex!].id!),
                     "dob":self.Birthdat_Txt.text!,
                     "device_token":ud.value(forKey: "deviceToken") as? String ?? ""]
            SignUpVC.dataCompose = param
            
            print(param)
            let apiUrl:String = ClS.baseUrl + "register"
            let requestOfAPI = AF.request(apiUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
            requestOfAPI.responseJSON { (response) in
                
                hud.dismiss()
                print(response)
                
                switch response.result{
                    
                case .success(let resultData):
                    
                    if let dict = resultData as? Dictionary<String,AnyObject>
                    {
                        let statusMsg = dict["statusMsg"] as? String ?? ""
                        print("register : \(statusMsg)")
                        
                        if let statusCode = dict["statusCode"] as? NSNumber
                        {
                            if statusCode == 1
                            {
                                let dictData:NSDictionary = ["logintype":"0",      "university_id":String(self.GetUnivercityData[self.SelectUniDrp.selectedIndex!].id!),
                                "email":self.txtEmailAddress.text!,
                                "password":self.txtPassword.text!,
                                "device_token":ud.value(forKey: "deviceToken") as? String ?? ""]
                                let vc = mainStoryBrd.instantiateViewController(withIdentifier: "VerifyOTPVC") as! VerifyOTPVC
                                vc.dictRegData = dictData
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
