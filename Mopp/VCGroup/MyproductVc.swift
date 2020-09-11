//
//  MyproductVc.swift
//  Mopp
//
//  Created by mac on 8/18/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD
import iOTool

class MyproductVc: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate {
    var ProductLis_Data=[GetproductModel_Data]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ProductLis_Data.count > 0{
             Nodataimageview.isHidden=true
        }else{
            Nodataimageview.isHidden=false
        }
        return ProductLis_Data.count
    }
    
    @IBOutlet weak var Nodataimageview: UIImageView!
          func Gifloader(){
                   let jeremyGif = UIImage.gifImageWithName("Nodata")
                   Nodataimageview.image = jeremyGif
                   
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
//        GetProductList()
//        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(longPressGR:)))
//        longPressGR.minimumPressDuration = 0.5
//        longPressGR.delaysTouchesBegan = true
//        self.MyproductCollectionview.addGestureRecognizer(longPressGR)
//        MyproductCollectionview?.collectionViewLayout = columnLayout
//        MyproductCollectionview?.contentInsetAdjustmentBehavior = .always
//        MyproductCollectionview?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//        // Do any additional setup after loading the view.
//        Gifloader()
    }
    override func viewDidAppear(_ animated: Bool) {
         GetProductList()
               let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(longPressGR:)))
               longPressGR.minimumPressDuration = 0.5
               longPressGR.delaysTouchesBegan = true
               self.MyproductCollectionview.addGestureRecognizer(longPressGR)
               MyproductCollectionview?.collectionViewLayout = columnLayout
               MyproductCollectionview?.contentInsetAdjustmentBehavior = .always
               MyproductCollectionview?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
               // Do any additional setup after loading the view.
               Gifloader()
    }
    
    @IBAction func PostNewProduct(_ sender: UIButton) {
        let paget = storyboard?.instantiateViewController(withIdentifier: "PostProDuctVC") as! PostProDuctVC
        paget.statusClose={
            () in
            self.GetProductList() 
        }
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
        self.navigationController?.popViewController(animated: true)
    }
    @objc
    func handleLongPress(longPressGR: UILongPressGestureRecognizer) {
        if longPressGR.state != .ended {
            return
        }
        
        let point = longPressGR.location(in: self.MyproductCollectionview)
        let indexPath = self.MyproductCollectionview.indexPathForItem(at: point)
        
        if let indexPath = indexPath {
            _ = self.MyproductCollectionview.cellForItem(at: indexPath)
            
            
            
            let alertController = UIAlertController(title: "Warning!", message: "You're about to delete this product right now.", preferredStyle: .alert)
            let delete = UIAlertAction(title: "Do it.", style: .destructive, handler: { action in
              //   let indexPath = IndexPath(row: index, section: 0)
                self.ProductLis_Data.remove(at: indexPath.row)
                self.MyproductCollectionview.performBatchUpdates({
                      self.MyproductCollectionview.deleteItems(at: [indexPath])
                    
                  }, completion: {
                      (finished: Bool) in
                      self.MyproductCollectionview.reloadItems(at: self.MyproductCollectionview.indexPathsForVisibleItems)
                 
                          let  University_id = iOTool.GetPref(Name: ClS.sf_University_id)
                    let parameter:[String:Any]=["id":self.ProductLis_Data[indexPath.row].id,"session_token":ClS.Token]
                          
                          NetWorkCall.get_Post_Api_Call(completion: { (T: StatusModel2) in
                           
                          }, BaseUrl:ClS.baseUrl , ApiName: ClS.deleteproduct, Prams: parameter)
                  })
               // MyproductCollectionview.endUpdates()
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                
                //this is optional, it makes the delete button go away on the cell
               
            })
            
            alertController.addAction(delete)
            alertController.addAction(cancel)
            present(alertController, animated: true, completion: nil)
    
            print(indexPath.row)
    } else {
    print("Could not find index path")
    }
}


}
class MyproductVc_Cell: UICollectionViewCell {
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var DescLbl: UILabel!
    
    @IBOutlet weak var TitleLbl: UILabel!
}
