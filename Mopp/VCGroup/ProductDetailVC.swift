//
//  ProductDetailVC.swift
//  Mopp
//
//  Created by mac on 8/4/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {
var datas=[GetproductModel_Data]()
    var ChatCommunicateKey = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        Descriptionlbl.text=datas[0].desc
        ProductPrice.text = "$ "+String(datas[0].price!)
        ProductName.text=datas[0].title
        Productimage.sd_setImage(with: URL(string: ClS.ImageUrl+datas[0].image!), placeholderImage: UIImage(named: "DefaultProductDetailPage"))
        ChatCommunicateKey=datas[0].contact_link!    
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var Descriptionlbl: UITextView!
    
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var Productimage: UIImageView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func CommunicateAction(_ sender: UIButton) {
        
      let vc = mainStoryBrd.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
         vc.selectedUSer=ChatCommunicateKey
     self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension String {

    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }

    //Validate Email

    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }

    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    var isValidContact: Bool {
           let phoneNumberRegex = "^[6-9]\\d{9}$"
           let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
           let isValidPhone = phoneTest.evaluate(with: self)
           return isValidPhone
       }
    //validate Password
   
}
