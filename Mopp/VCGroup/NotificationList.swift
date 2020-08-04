//
//  NotificationList.swift
//  Mopp
//
//  Created by mac on 8/4/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

class NotificationList: UIViewController,  UITableViewDataSource,UITableViewDelegate {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 8
   }
   
    @IBOutlet weak var NotificationList: UITableView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "NotificatioCell", for: indexPath) as! NotificatioCell
       
       return cell
   }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Back(_ sender: Any) {
        self.tabBarController?.selectedIndex=0
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
class NotificatioCell: UITableViewCell {
    
}
