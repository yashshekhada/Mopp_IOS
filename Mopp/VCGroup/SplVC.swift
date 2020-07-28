//
//  SplVC.swift
//  Mopp
//
//  Created by mac on 7/28/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit



class SplVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
