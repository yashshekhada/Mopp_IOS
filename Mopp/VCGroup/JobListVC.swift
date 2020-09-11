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
        if JoblValue.count > 0{
               Nodataimageview.isHidden=true
        }else{
               Nodataimageview.isHidden=false
        }
        return JoblValue.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
        Count+=1
                  GetJobList(searchby:SearchTxt.text!)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JonCell", for: indexPath) as! JonCell
        let Value=JoblValue[indexPath.row]
              cell.Amount_lbl.text=Value.jobhoursalary
               cell.EnddateLbl.text=Value.jobenddate
              cell.Descrition_lbl.text=Value.jobdesc?.html2String
        if Value.jobdepartment != nil{
        cell.department_lbl.text="  "+(Value.jobdepartment!)
        }
               cell.name_lbl.text=Value.jobtitle
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async(execute: {
            //var page
            let page = self.storyboard?.instantiateViewController(withIdentifier: "JobDetailVC") as! JobDetailVC
            page.Job_Data=[self.JoblValue[indexPath.row]]
            self.navigationController?.pushViewController(page, animated: true)
        })
    }
    var JoblValue = [JoblistModel_Data]()
    @IBOutlet weak var JobList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    //    LoginApi()
        var datasdas=ClS.Token
        ClS.Token=ClS.Token
         GetJobList(searchby:"")
        Gifloader()
        // Do any additional setup after loading the view.
    }
    
 @IBOutlet weak var Nodataimageview: UIImageView!
 func Gifloader(){
          let jeremyGif = UIImage.gifImageWithName("Nodata")
          Nodataimageview.image = jeremyGif
          
      }
   
       var Count=1
        func GetJobList(searchby:String) {
               let hud = JGProgressHUD(style: .light)
               hud.textLabel.text = "Loading"
               hud.show(in: self.view)
        //   var GetUnivercityData:GetUnivercity
            let parameter:[String:Any]=["session_token":ClS.Token,"univercity_id":ClS.University_id,"issearch":"1","page":String(Count),"paginate":String(ClS.PageSize),"searchby":searchby]
               NetWorkCall.get_Post_Api_Call(completion: { (T: JoblistModel) in
                   hud.dismiss()
                 
                if (T.statusCode == 1){
                    self.JoblValue+=T.JoblistModel_Datas!
                    self.JobList.reloadData()
                }
                else{
    //                let alertController = UIAlertController(title: ClS.App_Name, message:
    //                      T.statusMsg  , preferredStyle: .alert)
    //                   alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
    //
    //                   self.present(alertController, animated: true, completion: nil)
                }
                 
                  
               }, BaseUrl:ClS.baseUrl , ApiName: ClS.campusjob, Prams: parameter)
             
        }
    @IBAction func SearchActionBtn(_ sender: UIButton) {
        Count=1
        self.JoblValue.removeAll()
        self.JobList.reloadData()
        GetJobList(searchby:SearchTxt.text!)
       
    }
    @IBOutlet weak var SearchTxt: UITextField!
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
    @IBOutlet weak var name_lbl: UILabel!
    
    @IBOutlet weak var department_lbl: UILabel!
    @IBOutlet weak var Descrition_lbl: UILabel!
    @IBOutlet weak var Amount_lbl: UILabel!
    @IBOutlet weak var EnddateLbl: UILabel!
}
