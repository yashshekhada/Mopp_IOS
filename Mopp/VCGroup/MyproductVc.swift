//
//  MyproductVc.swift
//  Mopp
//
//  Created by mac on 8/18/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD

class MyproductVc: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate {
var ProductLis_Data=[GetproductModel_Data]()
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return ProductLis_Data.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyproductVc_Cell", for: indexPath) as! MyproductVc_Cell
              //cell.backgroundColor = UIColor.orange
       cell.ProductImage.sd_setImage(with: URL(string: ClS.ImageUrl+ProductLis_Data[indexPath.row].image!), placeholderImage: UIImage(named: "DefaultProductImage"))
       cell.DescLbl.text=ProductLis_Data[indexPath.row].desc!
           cell.TitleLbl.text=ProductLis_Data[indexPath.row].title!
              return cell
   }
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       DispatchQueue.main.async(execute: {
           //var page
           let page = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
           page.datas=[self.ProductLis_Data[indexPath.row]]
           self.navigationController?.pushViewController(page, animated: true)
       })
   }
    let columnLayout = ColumnFlowLayout(
           cellsPerRow: 2,
           minimumInteritemSpacing: 10,
           minimumLineSpacing: 10,
           sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
       )
    func GetProductList() {
                let hud = JGProgressHUD(style: .light)
                hud.textLabel.text = "Loading"
                hud.show(in: self.view)
         //   var GetUnivercityData:GetUnivercity
          let parameter:[String:Any]=["session_token":ClS.Token]
                NetWorkCall.get_Post_Api_Call(completion: { (T: GetproductModel) in
                    hud.dismiss()
                  
                 if (T.statusCode == 1){
                  self.ProductLis_Data=T.data!
                    self.MyproductCollectionview.reloadData()
                 }
                 else{
                    self.ProductLis_Data.removeAll()
                     let alertController = UIAlertController(title: ClS.App_Name, message:
                           T.statusMsg  , preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                        self.present(alertController, animated: true, completion: nil)
                  self.MyproductCollectionview.reloadData()
                 }
                  
                   
                }, BaseUrl:ClS.baseUrl , ApiName: ClS.getmyproduct, Prams: parameter)
              
         }
    @IBOutlet weak var MyproductCollectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GetProductList()
        MyproductCollectionview?.collectionViewLayout = columnLayout
               MyproductCollectionview?.contentInsetAdjustmentBehavior = .always
               MyproductCollectionview?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func PostNewProduct(_ sender: UIButton) {
        let paget = storyboard?.instantiateViewController(withIdentifier: "PostProDuctVC") as! PostProDuctVC
        self.navigationController?.pushViewController(paget, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func BackAction(_ sender: UIButton) {
    }
    
}
class MyproductVc_Cell: UICollectionViewCell {
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var DescLbl: UILabel!
    
    @IBOutlet weak var TitleLbl: UILabel!
}
