//
//  TestCV.swift
//  Mopp
//
//  Created by mac on 7/25/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

class TestCV: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valueArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "test_cell", for: indexPath) as! test_cell
        cell.lbl.text=valueArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let alert = UIAlertController(title: "My his", message: valueArray[indexPath.row], preferredStyle: UIAlertController.Style.alert)

               // add an action (button)
               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

               // show the alert
               self.present(alert, animated: true, completion: nil)
    }

    var valueArray=["yash"," chirag ","bansi budhi vagarani "]
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
  

    @IBOutlet weak var test_t: UITableView!
    
    
    
}
class test_cell:UITableViewCell
{
    @IBOutlet weak var lbl: UILabel!
    
}
