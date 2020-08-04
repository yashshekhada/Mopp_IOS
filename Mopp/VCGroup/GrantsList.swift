//
//  GrantsList.swift
//  Mopp
//
//  Created by mac on 8/3/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

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
        
        // Do any additional setup after loading the view.
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
