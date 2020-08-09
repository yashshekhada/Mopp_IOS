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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GrantCell", for: indexPath) as! GrantCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async(execute: {
            //var page
            let page = self.storyboard?.instantiateViewController(withIdentifier: "GrantDetailVC") as! GrantDetailVC
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
           let parameter:[String:Any]=["":""]
           NetWorkCall.get_Api_Call(completion: { (T: GrantsModel) in
               hud.dismiss()
             
            if (T.statusCode == 1){
            
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
    
}
