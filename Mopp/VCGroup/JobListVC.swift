//
//  JobListVC.swift
//  Mopp
//
//  Created by mac on 8/3/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD

class JobListVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
   // var CurruntJob
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JonCell", for: indexPath) as! JonCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async(execute: {
            //var page
            let page = self.storyboard?.instantiateViewController(withIdentifier: "JobDetailVC") as! JobDetailVC
            self.navigationController?.pushViewController(page, animated: true)
        })
    }
    
    @IBOutlet weak var JobList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
   // func GetJobList() {
//           let hud = JGProgressHUD(style: .light)
//           hud.textLabel.text = "Loading"
//           hud.show(in: self.view)
//    //   var GetUnivercityData:GetUnivercity
//           let parameter:[String:Any]=["":""]
//           NetWorkCall.get_Api_Call(completion: { (T: GetUnivercity) in
//               hud.dismiss()
//             //  VerifyLoginApiData = T;
//               //var views = self.storyboard?.instantiateViewController(identifier: "TabbWindow") as? UITabBarController
//               // self.navigationController?.pu(views, animated: true)
////               self.GetUnivercityData=T.data!
////               var arraySS=[String]()
////               for point in self.GetUnivercityData{
////                   arraySS.append(point.name!)
////               }
////               self.SelectUniDrp.optionArray=arraySS
//
//
//           }, BaseUrl:ClS.baseUrl , ApiName: ClS.getunivercity, Prams: parameter)
//
//       }
    /*
     
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func Back(_ sender: Any) {
        self.tabBarController?.selectedIndex=0
    }
    
    @IBOutlet weak var HightConstraint: NSLayoutConstraint!
    @IBOutlet weak var HightConstraint2: NSLayoutConstraint!
    @IBAction func SwichSearchViewAction(_ sender: UIButton) {
        if HightConstraint.constant == 0
        {
            HightConstraint.constant=50
            HightConstraint2.constant=38
        }
        else if HightConstraint.constant == 50
        {
            HightConstraint.constant=0
             HightConstraint2.constant=0
        }
        
        
    }
}
class JonCell: UITableViewCell {
    
}
