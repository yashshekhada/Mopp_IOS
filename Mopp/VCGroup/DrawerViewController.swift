//
//  DrawerViewController.swift
//  Mopp
//
//  Created by mac on 8/17/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
 */
     @IBAction func Myproduct(_ sender: UIButton) {
        let page = storyboard?.instantiateViewController(withIdentifier: "MyproductVc") as! MyproductVc
        self.navigationController?.pushViewController(page, animated: true)
     }
    
    @IBAction func LogoutBtnAction(_ sender: Any) {
        let story = UIStoryboard(name: "Main", bundle:nil)
        let vc = story.instantiateViewController(withIdentifier: "NavLogin")
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}
