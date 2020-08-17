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
    override func viewDidLoad() {
        super.viewDidLoad()

        Descriptionlbl.text=datas[0].desc
        ProductPrice.text = String(datas[0].price!)
        ProductName.text=datas[0].title
        Productimage.sd_setImage(with: URL(string: ClS.ImageUrl+datas[0].image!), placeholderImage: UIImage(named: "DefaultProductDetailPage"))
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
    }
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
