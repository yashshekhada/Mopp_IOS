//
//  PostProDuctVC.swift
//  Mopp
//
//  Created by mac on 8/18/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import  Alamofire
class PostProDuctVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        ImageViewProduct.pickImage(self){ image in
//                     //here is the image
//                 }
     
    }
    
    @IBAction func ContactLinkTxt(_ sender: UITextField) {
    }
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
    
      let parameters = [
      "station_id" :        "1000",
      "title":      "Murat Akdeniz",
      "body":        "xxxxxx"]
        
       AF.upload(multipartFormData: { multipart in
            multipart.append(fileData, withName: "payload", fileName: "someFile.jpg", mimeType: "image/jpeg")
            multipart.append("comment".data(using: .utf8)!, withName :"comment")
        }, to: "endPointURL", method: .post, headers: nil) { encodingResult in
            
           switch(encodingResult) {
           case encodingResult.su
            case .failure(let encodingError):
                print("multipart upload encodingError: \(encodingError)")
            }
        }
        
    }
    
     
    @IBAction func PickImage(_ sender: UIButton) {
        DispatchQueue.main.async {
       
        ImagePickerManager().pickImage(self){ image in
                 //here is the image
            self.ImageViewProduct.image=image
             }
        }
       
    }
    @IBAction func myProductback(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
