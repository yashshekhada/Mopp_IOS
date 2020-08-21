//
//  JobDetailVC.swift
//  Mopp
//
//  Created by mac on 8/4/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD
class JobDetailVC: UIViewController {
var Job_Data=[JoblistModel_Data]()
    override func viewDidLoad() {
        super.viewDidLoad()
var Model = Job_Data[0]
        // Do any additional setup after loading the view.
        DeoartmentLbl.text=Model.jobdepartment
         EndDatelbl.text=Model.jobweekhour
        PriceLbl.text = "$"+Model.jobhoursalary!
         DescLBL.text=Model.jobdesc
         Qualificationlbl.text=Model.jobqualification
        TitleLbl.text=Model.jobtitle
          ContactLbl.text=Model.jobcontact
          DeadLinelbl.text=Model.jobenddate
        if Model.acceptbystudent != "0"{
                   ApplyeBtn.isEnabled=false
                   ApplyeBtn.setTitle("Applied", for: .normal)
               }
               
         // DeoartmentLbl.text=Model.jobdepartment
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func applayJobPost() {
             let hud = JGProgressHUD(style: .light)
             hud.textLabel.text = "Loading"
             hud.show(in: self.view)
    let jobid=String(Job_Data[0].jobid!)
      //   var GetUnivercityData:GetUnivercity
       let parameter:[String:Any]=["session_token":ClS.Token,"univercity_id":ClS.University_id,"student_id":ClS.user_id,"job_id":jobid]
             NetWorkCall.get_Post_Api_Call(completion: { (T: StatusModel2) in
                 hud.dismiss()
               
              if (T.statusCode == 1){
                let alertController = UIAlertController(title: ClS.App_Name, message:
                                       T.statusMsg  , preferredStyle: .alert)
                                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                                    self.present(alertController, animated: true, completion: nil)
                self.ApplyeBtn.isEnabled=false
                   self.ApplyeBtn.setTitle("Applied", for: .normal)
              }
              else{
                  let alertController = UIAlertController(title: ClS.App_Name, message:
                        T.statusMsg  , preferredStyle: .alert)
                     alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                     self.present(alertController, animated: true, completion: nil)
               
              }
               
                
             }, BaseUrl:ClS.baseUrl , ApiName: ClS.jobapply, Prams: parameter)
           
      }
    @IBOutlet weak var ApplyeBtn: UIButton!
    @IBOutlet weak var DescLBL: UILabel!
    @IBOutlet weak var EndDatelbl: UILabel!
    @IBOutlet weak var PriceLbl: UILabel!
    @IBOutlet weak var Qualificationlbl: UILabel!
    @IBOutlet weak var ContactLbl: UILabel!
    @IBOutlet weak var DeoartmentLbl: UILabel!
    @IBOutlet weak var DeadLinelbl: UILabel!
    
    @IBOutlet weak var TitleLbl: UILabel!
    @IBAction func Back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func Applyetn(_ sender: Any) {
        applayJobPost()
    }
}
