//
//  HomeVC.swift
//  Mopp
//
//  Created by mac on 8/6/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import iOTool
import JGProgressHUD

class HomeVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate {
   var GetNewsFeedArry=[GetNewsFeed_Data]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  GetNewsFeedArry.count
    }
    
    @IBOutlet weak var Searchview: UIView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let page = tableView.dequeueReusableCell(withIdentifier: "NewsFeedPost", for: indexPath) as! NewsFeedPost
        return page
    }
    
    
    @IBOutlet weak var MyPortListView: UITableView!
    
    
    var size=0.0
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        
        if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0)
        {
            print("up")
            Searchview.isHidden=false
            PostBarHight.constant=46
        }
        else
        {
            Searchview.isHidden=true
            PostBarHight.constant=0
            
             
            
            
            
        }
      //  PostBarHight.constant=CGFloat(size)
    }
    func GetPost() {
              let hud = JGProgressHUD(style: .light)
              hud.textLabel.text = "Loading"
              hud.show(in: self.view)
       //   var GetUnivercityData:GetUnivercity"
        let  University_id = iOTool.GetPref(Name: ClS.sf_University_id)
        let parameter:[String:Any]=["issearch":"0","univercity_id": String(University_id),"session_token":ClS.Token]
        
              NetWorkCall.get_Post_Api_Call(completion: { (T: GetNewsFeed) in
                  hud.dismiss()
             
               
               if (T.statusCode == 1){
                self.GetNewsFeedArry=T.data!
                self.MyPortListView.reloadData()
               }
               else{
                   let alertController = UIAlertController(title: ClS.App_Name, message:
                         T.statusMsg  , preferredStyle: .alert)
                      alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                      self.present(alertController, animated: true, completion: nil)
               }
                
                 
              }, BaseUrl:ClS.baseUrl , ApiName: ClS.getpostlist, Prams: parameter)
            
          }
          
    override func viewDidLoad() {
        super.viewDidLoad()
        GetPost()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var PostBarHight: NSLayoutConstraint!
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
class NewsFeedPost: UITableViewCell {
    
}
