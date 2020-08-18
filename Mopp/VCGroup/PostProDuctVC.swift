//
//  PostProDuctVC.swift
//  Mopp
//
//  Created by mac on 8/18/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import  Alamofire
import JGProgressHUD
class PostProDuctVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        ImageViewProduct.pickImage(self){ image in
//                     //here is the image
//                 }
     
    }
    @IBOutlet weak var ContactLinkTxt: UITextField!
    
  
    @IBOutlet weak var DescriptionTxt: UITextField!
    @IBOutlet weak var nametxt: UITextField!
    
    @IBOutlet weak var PriceTxt: UITextField!
    /*
    // MARK: - Navigation

     @IBOutlet weak var ImageviewPick: UIImageView!
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
       */
    @IBOutlet weak var ImageViewProduct: UIImageView!
    @IBAction func AddProduct(_ sender: Any) {
        let hud = JGProgressHUD(style: .light)
           hud.textLabel.text = "Loading"
           hud.show(in: self.view)
        let ImageData = self.ImageViewProduct.image!.pngData()
      let parameters = [
        "title" :        nametxt.text,
      "price":      PriceTxt.text,
      "desc":        DescriptionTxt.text,
      "s_id" :       ClS.user_id,
      "u_id":      ClS.University_id,
      "session_token":         ClS.Token,
      "contact_link" :        ContactLinkTxt.text,
        ] as [String : Any]
        let timestamp = NSDate().timeIntervalSince1970
        let url =  URL(string: ClS.baseUrl+ClS.createproduct)!
        let urlString = ClS.baseUrl+ClS.createproduct
           let headers: HTTPHeaders =
               ["Content-type": "multipart/form-data",
               "Accept": "application/json"]
           AF.upload(
               multipartFormData: { multipartFormData in
                   for (key, value) in parameters {
                       if let temp = value as? String {
               multipartFormData.append(temp.data(using: .utf8)!, withName: key)}

           if let temp = value as? Int {
           multipartFormData.append("(temp)".data(using: .utf8)!, withName: key)}

           if let temp = value as? NSArray {
               temp.forEach({ element in
                   let keyObj = key + "[]"
                   if let string = element as? String {
                       multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                   } else
                       if let num = element as? Int {
                           let value = "(num)"
                           multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                   }
               })
           }
       }
                  

                multipartFormData.append(ImageData!, withName: "image", fileName: String(timestamp)+".png", mimeType: "image/png")
           },
               to: urlString, //URL Here
               method: .post,
               headers: headers)
               .responseJSON { (resp) in
                   defer{
                    hud.dismiss()
                    
                    
                }
                   print("resp is \(resp)")
           }
        
    }
    
     
    @IBAction func PickImage(_ sender: UIButton) {
        DispatchQueue.main.async {
       
        ImagePickerManager().pickImage(self){ image in
                 //here is the image
           // image.url
            self.ImageViewProduct.image=image
             }
        }
       
    }
    @IBAction func myProductback(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
