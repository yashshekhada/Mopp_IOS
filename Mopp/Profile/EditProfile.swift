//
//  EditProfile.swift
//  Mopp
//
//  Created by APPLE on 23/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD
import YYCalendar
import Alamofire
import iOTool

class EditProfile: UIViewController,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,GenderVCDelegate
{
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtFNm: UITextField!
    @IBOutlet weak var txtLNm: UITextField!
    @IBOutlet weak var txtUnm: UITextField!
    @IBOutlet weak var txtSelectUniversity: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtQualification: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtPhoneNo: UITextField!
    
    @IBOutlet weak var btnBrithDt: UIButton!
    @IBOutlet weak var btnGender: UIButton!
    
    @IBOutlet weak var bgViewCorner: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var editedimage = UIImage()
    var imagepicker = UIImagePickerController()
    var remove_photo:Int = 0
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        self.setData()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.bgViewCorner.round(corners: [.topLeft,.topRight], cornerRadius: 28)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    override func viewDidAppear(_ animated: Bool)
    {
        self.editedimage = self.imgProfile.image!
    }
    
    //MARK: - Custome Methods
    func setData()
    {
        if ud.value(forKey: "LoginData") != nil
        {
            self.txtSelectUniversity.isUserInteractionEnabled = false
            self.txtEmail.isUserInteractionEnabled = false
            
            let dict = ud.value(forKey: "LoginData") as! NSDictionary
            self.txtFNm.text = dict["name"] as? String
            self.txtLNm.text = dict["l_name"] as? String
            self.txtUnm.text = dict["username"] as? String
            self.txtSelectUniversity.text = dict["univercity_name"] as? String
            self.txtEmail.text = dict["email"] as? String
            self.btnBrithDt.setTitle(dict["dob"] as? String, for: .normal)
            self.btnGender.setTitle(dict["gender"] as? String, for: .normal)
            self.txtQualification.text = dict["qualification"] as? String
            self.txtCountry.text = dict["country"] as? String
            self.txtCity.text = dict["city"] as? String
            self.txtPhoneNo.text = dict["phone_number"] as? String
            
            self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.height / 2
            self.imgProfile.layer.masksToBounds = true
            
            let imgUrl = dict["image"] as? String ?? ""
            self.imgProfile.sd_setImage(with: URL(string: ClS.ImageUrl+imgUrl), placeholderImage: UIImage(named: "user-icon"))
        }
    }
    
    //MARK: - GenderVCDelegate Methods
    func didUpdateGender(strGender: String)
    {
        self.btnGender.setTitle(strGender, for: .normal)
    }
    
    //MARK: - UIScrollViewDelegate Methods
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        if scrollView.contentOffset.x != 0 {
            scrollView.contentOffset.x = 0
        }
    }
    
    //MARK: - UIImagePickerControllerDelegate Method
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagepicker.sourceType = UIImagePickerController.SourceType.camera
            imagepicker.allowsEditing = true
            self.present(imagepicker, animated: true, completion: nil)
        }
        else
        {
            createAlertViewController(title: ClS.App_Name, message: "Camera is not supported in this device", viewController: self)
        }
    }
    func openGallery()
    {
        imagepicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagepicker.allowsEditing = true
        imagepicker.mediaTypes = ["public.image"]
        self.present(imagepicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let mediatype = info[UIImagePickerController.InfoKey.mediaType] as? String
        {
            if mediatype == "public.image" {
                
                print("its Image")
                let pickedimage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
                self.imgProfile.image = pickedimage
                editedimage = pickedimage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - IBAction Methods
    @IBAction func btnBackTapped(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCameraTapped(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image From", message: nil, preferredStyle: UIAlertController.Style.alert)
        let cameraAction = UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        let galleryAction = UIAlertAction(title: "Camera/Capture", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let removeAction = UIAlertAction(title: "Remove Profile", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.remove_photo = 1
            self.editedimage = UIImage()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(removeAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnBirthDateTapped(_ sender: UIButton)
    {
        self.view.endEditing(true)
        
        DispatchQueue.main.async {
        let date = Date()
        let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let result = formatter.string(from: date)
        let calendar = YYCalendar(normalCalendarLangType: .ENG, date: result, format: "dd-MM-yyyy") { date in
            self.btnBrithDt.setTitle(date, for: .normal)
        }
            calendar.headerViewBackgroundColor = UIColor.init(named: "TitleColor")!
        calendar.show()
        }
    }
    
    @IBAction func btnGenderTapped(_ sender: UIButton)
    {
        self.view.endEditing(true)
        let alrtMsg = GenderVC(nibName: "GenderVC", bundle: nil)
        alrtMsg.setPopinOptions(.disableAutoDismiss)
        alrtMsg.setPopinTransitionStyle(.slide)
        alrtMsg.setPopinAlignment(.centered)
        alrtMsg.genderDelegate = self
        self.presentPopinController(alrtMsg, animated: true, completion: nil)
    }
    
    @IBAction func btnUpdateTapped(_ sender: UIButton)
    {
        self.view.endEditing(true)
        APICallingUpdateProfile()
    }
    
    //MARK: - AICalling Methods
    func APICallingUpdateProfile()
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
       
        let  University_id = iOTool.GetPref(Name: ClS.sf_University_id)
        let param:NSMutableDictionary = [
                 "session_token":ClS.Token,
                 "f_name":self.txtFNm.text!,
                 "l_name":self.txtLNm.text!,
                 "email":self.txtEmail.text!,
                 "username":self.txtUnm.text!,
                 "university_id":University_id,
                 "dob":btnBrithDt.currentTitle!,
                 "phone_number":self.txtPhoneNo.text!,
                 "qualification":self.txtQualification.text!,
                 "gender":self.btnGender.currentTitle!,
                 "city":self.txtCity.text!,
                 "country":self.txtCountry.text!,
                 "image":"Need",
                 "remove_photo":"\(self.remove_photo)"]//0:display - 1: remove
        
        print(param)
        if Utill.reachable()
        {
            let strUrl = ClS.baseUrl + ClS.updateprofile
            let strEncoded:String = strUrl
           
            AF.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in (param.mutableCopy() as! NSDictionary) {
                    
                    if (((value as? String) != nil)) && (value as! String).hasPrefix("Need")
                    {
                        let v = (value as! String).dropFirst(4)                        
                        if Int(v)! >= 0
                        {
                            multipartFormData.append(self.editedimage.pngData()!, withName: key as! String, fileName: "picture.png", mimeType: "image/png")
                        }
                    }
                    else
                    {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key as! String)
                    }
                }
                
            },to: strEncoded, usingThreshold: UInt64.init(),
            method: .post,
            headers: nil).response{ response in
            
                hud.dismiss()
                print(response)
                
                if((response.error == nil))
                {
                    do
                    {
                        if let jsonData = response.data
                        {
                            let dict = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                            
                            let statusMsg = dict["statusMsg"] as? String ?? ""
                            print("Update Profile : \(statusMsg)")
                            
                            if let statusCode = dict["statusCode"] as? NSNumber
                            {
                                if statusCode == 1
                                {
                                    print(statusMsg)
                                    self.navigationController?.popViewController(animated: true)
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
                    }
                    catch
                    {
                        print(" encodingError is \(response.error ?? "Error" as! Error)")
                        hud.dismiss()
                    }
                }
                else
                {
                    hud.dismiss()
                }
            }
        }
        
    }
}
