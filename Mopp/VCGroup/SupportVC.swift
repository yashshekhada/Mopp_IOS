//
//  SupportVC.swift
//  Mopp
//
//  Created by mac on 9/5/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//
import UIKit
import Foundation
import JGProgressHUD
class SupportVC:  UIViewController {
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    @IBAction func SubmitForm(_ sender: Any) {
        if (FeedbackForm.text != nil && EmailID.text != nil &&  FeedbackForm.text != "" && EmailID.text != ""){
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        //   var GetUnivercityData:GetUnivercity
            let parameter:[String:Any]=["session_token":ClS.Token,
                                    "email":EmailID.text,
            "feedback":FeedbackForm.text]
        NetWorkCall.get_Post_Api_Call(completion: { (T: UserData_m) in
            hud.dismiss()
            
            if (T.statusCode == 1){
              let alertController = UIAlertController(title: ClS.App_Name, message:
                               T.statusMsg  , preferredStyle: .alert)
                           alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                           
                           self.present(alertController, animated: true, completion: nil)
                
            }
            else{
                let alertController = UIAlertController(title: ClS.App_Name, message:
                    T.statusMsg  , preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
            }
            
            
        },  BaseUrl:ClS.baseUrl , ApiName: "feedback", Prams: parameter)
        }else{
            let alertController = UIAlertController(title: ClS.App_Name, message:
                            "Feedback With Email Address Required " , preferredStyle: .alert)
                         alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                         
                         self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func ContactUs(_ sender: UIButton) {
        if let url = NSURL(string: "tel://+919106360169"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    @IBOutlet weak var FeedbackForm: UITextView!
    @IBOutlet weak var EmailID: UITextField!
}
