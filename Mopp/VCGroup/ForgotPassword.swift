//
//  ForgotPassword.swift
//  Mopp
//
//  Created by mac on 7/29/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD

class ForgotPassword: UIViewController {

    @IBOutlet weak var mailText: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Forgetsendmail(_ sender: UIButton) {
        ForgotPasswordApi()
        
    }
    func ForgotPasswordApi() {
              let hud = JGProgressHUD(style: .light)
              hud.textLabel.text = "Loading"
              hud.show(in: self.view)
       //   var GetUnivercityData:GetUnivercity
              let parameter:[String:Any]=["":""]
              NetWorkCall.get_Api_Call(completion: { (T: StatusModel) in
                  hud.dismiss()
                
                  let  dataP =  T
                let alert = UIAlertController(title: "MOPP", message: dataP.statusMsg , preferredStyle: .alert)

                 alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    if (dataP.statusCode == 1)
                    {
                        self.navigationController?.popViewController(animated: true)
                    }
                 }))
                 alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

                 self.present(alert, animated: true)
                
                 
              }, BaseUrl:ClS.baseUrl , ApiName: ClS.login+"email="+mailText.text!, Prams: parameter)
            
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
