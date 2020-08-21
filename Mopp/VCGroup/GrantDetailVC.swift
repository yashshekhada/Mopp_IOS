//
//  GrantDetailVC.swift
//  Mopp
//
//  Created by mac on 8/4/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD
class GrantDetailVC: UIViewController {

  //  @IBOutlet weak var Descript_txt: UITextView!
   // @IBOutlet weak var Description_lbl: UILabel!
    @IBOutlet weak var Job_name: UILabel!
    @IBOutlet weak var Department_lbl: UILabel!
    @IBOutlet weak var DeadLine_lbl: UILabel!
    @IBOutlet weak var Ammount_lbl: UILabel!
    @IBOutlet weak var Description_lbl: UILabel!
    var Detail = [GrantsModel_Data]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let Grantdata=Detail[0]
        Job_name.text=Grantdata.s_title
        Department_lbl.text=Grantdata.s_department
        DeadLine_lbl.text="Deadline : "+Grantdata.s_enddate!
        Ammount_lbl.text=Grantdata.s_money
       Contact_info_lbl.text=Grantdata.s_contact
        Mailaddresh_lbl.text=Grantdata.s_contact
        Description_lbl.text=Grantdata.s_desc?.html2String
        if Grantdata.isapply != "0"{
            AplayBtnLbl.isEnabled=false
            AplayBtnLbl.setTitle("Applied", for: .normal)
        }
        
        
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var Contact_info_lbl: UILabel!
    
    @IBOutlet weak var Mailaddresh_lbl: UILabel!
    
    @IBOutlet weak var AplayBtnLbl: UIButton!
    @IBAction func Apply_btn(_ sender: Any) {
        applayGrantPost()
    }
    func applayGrantPost() {
                 let hud = JGProgressHUD(style: .light)
                 hud.textLabel.text = "Loading"
                 hud.show(in: self.view)
        let Grantdata=String(Detail[0].id!)
          //   var GetUnivercityData:GetUnivercity
           let parameter:[String:Any]=["session_token":ClS.Token,"univercity_id":ClS.University_id,"student_id":ClS.user_id,"scholarship_id":Grantdata]
                 NetWorkCall.get_Post_Api_Call(completion: { (T: StatusModel2) in
                     hud.dismiss()
                   
                  if (T.statusCode == 1){
                    let alertController = UIAlertController(title: ClS.App_Name, message:
                                                         T.statusMsg  , preferredStyle: .alert)
                                                      alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                                                      self.present(alertController, animated: true, completion: nil)
                    self.AplayBtnLbl.isEnabled=false
                       self.AplayBtnLbl.setTitle("Applied", for: .normal)
                  }
                  else{
                      let alertController = UIAlertController(title: ClS.App_Name, message:
                            T.statusMsg  , preferredStyle: .alert)
                         alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                         self.present(alertController, animated: true, completion: nil)
                   
                  }
                   
                    
                 }, BaseUrl:ClS.baseUrl , ApiName: ClS.scholarshipapply, Prams: parameter)
               
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
        self.navigationController?.popViewController(animated: true)
    }
}
