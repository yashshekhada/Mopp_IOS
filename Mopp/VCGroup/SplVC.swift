//
//  SplVC.swift
//  Mopp
//
//  Created by mac on 7/28/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

import iOTool

class SplVC: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        let status = iOTool.GetPref(Name: ClS.sf_Status)
       if status == "1"
       {
          let story = UIStoryboard(name: "Main", bundle:nil)
           let vc = story.instantiateViewController(withIdentifier: "navHome")
           UIApplication.shared.windows.first?.rootViewController = vc
           UIApplication.shared.windows.first?.makeKeyAndVisible()
       }
        let story = UIStoryboard(name: "Main", bundle:nil)
        UIApplication.shared.windows.first?.makeKeyAndVisible()
                 UIApplication.shared.windows.first?.rootViewController = UINavigationController(rootViewController: MessagesController())
        
      
    }
    
    @IBAction func Next(_ sender: Any) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "LoginVc") as! LoginVc
        navigationController?.pushViewController(view, animated: true)
  
    
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
