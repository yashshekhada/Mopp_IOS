//
//  GrantsList.swift
//  Mopp
//
//  Created by mac on 8/3/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD

class GrantsList: UIViewController,UITableViewDataSource, UITableViewDelegate {
  var GrantValue = [GrantsModel_Data]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return   self.GrantValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GrantCell", for: indexPath) as! GrantCell
        let Value=GrantValue[indexPath.row]
        cell.Amount_lbl.text=Value.s_money
         cell.EnddateLbl.text=Value.s_enddate
        cell.Descrition_lbl.text=Value.s_desc?.html2String
        cell.department_lbl.text="  "+Value.s_department!+"    "
         cell.name_lbl.text=Value.s_title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async(execute: {
            //var page
            let page = self.storyboard?.instantiateViewController(withIdentifier: "GrantDetailVC") as! GrantDetailVC
             
            page.Detail=[self.GrantValue[indexPath.row]]
            self.navigationController?.pushViewController(page, animated: true)
        })
    }
    @IBOutlet weak var GrantList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetGrants()
        
        // Do any additional setup after loading the view.
    }
    
    func GetGrants() {
           let hud = JGProgressHUD(style: .light)
           hud.textLabel.text = "Loading"
           hud.show(in: self.view)
    //   var GetUnivercityData:GetUnivercity
        let parameter:[String:Any]=["session_token":ClS.Token,"univercity_id":ClS.University_id]
           NetWorkCall.get_Post_Api_Call(completion: { (T: GrantsModel) in
               hud.dismiss()
             
            if (T.statusCode == 1){
                self.GrantValue=T.GrantsModel_data!
                self.GrantList.reloadData()
            }
            else{
                let alertController = UIAlertController(title: ClS.App_Name, message:
                      T.statusMsg  , preferredStyle: .alert)
                   alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                   self.present(alertController, animated: true, completion: nil)
            }
             
              
           }, BaseUrl:ClS.baseUrl , ApiName: ClS.getscholarshiplist+"session_token="+ClS.Token+"&univercity_id="+ClS.University_id, Prams: parameter)
         
    }
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

}
class GrantCell:UITableViewCell
{
    @IBOutlet weak var name_lbl: UILabel!
    
    @IBOutlet weak var department_lbl: UILabel!
    @IBOutlet weak var Descrition_lbl: UILabel!
    @IBOutlet weak var Amount_lbl: UILabel!
    @IBOutlet weak var EnddateLbl: UILabel!
}
