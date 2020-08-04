//
//  MarketList.swift
//  Mopp
//
//  Created by mac on 8/4/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

class MarketList: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 59
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
