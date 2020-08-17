//
//  MarketList.swift
//  Mopp
//
//  Created by mac on 8/4/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD
class MarketList: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
 var ProductLis_Data=[GetproductModel_Data]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductLis_Data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as!ProductCell
               //cell.backgroundColor = UIColor.orange
               return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async(execute: {
            //var page
            let page = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
            self.navigationController?.pushViewController(page, animated: true)
        })
    }
    func GetProductList() {
              let hud = JGProgressHUD(style: .light)
              hud.textLabel.text = "Loading"
              hud.show(in: self.view)
       //   var GetUnivercityData:GetUnivercity
           let parameter:[String:Any]=["session_token":ClS.Token,"univercity_id":ClS.University_id]
              NetWorkCall.get_Post_Api_Call(completion: { (T: GetproductModel) in
                  hud.dismiss()
                
               if (T.statusCode == 1){
               // self.ProductLis_Data=T.data
              //      self.GrantList.reloadData()
               }
               else{
                   let alertController = UIAlertController(title: ClS.App_Name, message:
                         T.statusMsg  , preferredStyle: .alert)
                      alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                      self.present(alertController, animated: true, completion: nil)
               }
                
                 
              }, BaseUrl:ClS.baseUrl , ApiName: ClS.getproduct, Prams: parameter)
            
       }
    @IBOutlet weak var ProductList: UICollectionView!
    
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 2,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        ProductList?.collectionViewLayout = columnLayout
        ProductList?.contentInsetAdjustmentBehavior = .always
        ProductList?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }

   



   @IBAction func Back(_ sender: Any) {
    self.tabBarController?.selectedIndex=0
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
class  ProductCell: UICollectionViewCell {
    
}
