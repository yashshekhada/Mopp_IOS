//
//  CommentVC.swift
//  Mopp
//
//  Created by mac on 8/16/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD
import iOTool
class CommentVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var  post_id="0"
    var CommentListData = [getcommentModel_Data]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CommentListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        if CommentListData[indexPath.row].name != nil {
        cell.NameOfSender.text=CommentListData[indexPath.row].name
        }
        cell.Descriptionlbl.text = CommentListData[indexPath.row].comment
      if CommentListData[indexPath.row].image != nil {
              cell.Profileimage.sd_setImage(with: URL(string: ClS.ImageUrl+CommentListData[indexPath.row].image!), placeholderImage: UIImage(named: "user-icon"))
        }
        return cell
    }
    
    @IBOutlet weak var CommentTableView: UITableView!
    override func viewDidLoad() {
            super.viewDidLoad()
        GetComment(post_id:post_id)
        
    }
    @IBAction func BackView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func GetComment(post_id:String) {
          let hud = JGProgressHUD(style: .light)
          hud.textLabel.text = "Loading"
          hud.show(in: self.view)
          //   var GetUnivercityData:GetUnivercity"
          let University_id = iOTool.GetPref(Name: ClS.sf_University_id)
        let parameter:[String:Any]=["session_token":ClS.Token,"post_id": String(post_id)]
          
          NetWorkCall.get_Post_Api_Call(completion: { (T: getcommentModel) in
              hud.dismiss()
              
              
              if (T.statusCode == 1){
                  self.CommentListData = T.data!
                  self.CommentTableView.reloadData()
                let indexPath = NSIndexPath(row: self.CommentListData.count-1, section: 0)
                               self.CommentTableView.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
              }
              else{
                  let alertController = UIAlertController(title: ClS.App_Name, message:
                      T.statusMsg  , preferredStyle: .alert)
                  alertController.addAction(UIAlertAction(title: "OK", style: .default))
                  
                  self.present(alertController, animated: true, completion: nil)
                  
               //   iOTool.SavePref(Name: ClS.sf_Status, Value: "0")
                  
              }
              
              
          }, BaseUrl:ClS.baseUrl , ApiName: ClS.getcomment, Prams: parameter)
          
      }
    
    
    @IBOutlet weak var Comment_Txt: UITextField!
    
    @IBAction func SendCommentAction(_ sender: Any) {
        if (Comment_Txt.text != "" || Comment_Txt.text != nil){
            PostComment(post_id: post_id, Comment_string: Comment_Txt.text!)
        }else{
            let alertController = UIAlertController(title: ClS.App_Name, message:
                              "Please Enter Your Comment" , preferredStyle: .alert)
                           alertController.addAction(UIAlertAction(title: "OK", style: .default))
                           
                           self.present(alertController, animated: true, completion: nil)
                           
                          

        }
    }
    func PostComment(post_id:String,Comment_string:String) {
             let hud = JGProgressHUD(style: .light)
             hud.textLabel.text = "Loading"
             hud.show(in: self.view)
             //   var GetUnivercityData:GetUnivercity"
          
        let parameter:[String:Any]=["session_token":ClS.Token,"post_id": String(post_id),"comment":Comment_string,"commentby":ClS.user_id]
             
             NetWorkCall.get_Post_Api_Call(completion: { (T: StatusModel2) in
                 hud.dismiss()
                 
                 
                 if (T.statusCode == 1){
                    self.Comment_Txt.text != ""
                    self.GetComment(post_id:post_id)
                    // self.CommentListData = T.data!
                  //   self.CommentTableView.reloadData()
                 }
                 else{
                     let alertController = UIAlertController(title: ClS.App_Name, message:
                         T.statusMsg  , preferredStyle: .alert)
                     alertController.addAction(UIAlertAction(title: "OK", style: .default))
                     
                     self.present(alertController, animated: true, completion: nil)
                     
                     iOTool.SavePref(Name: ClS.sf_Status, Value: "0")
                     
                 }
                 
                 
             }, BaseUrl:ClS.baseUrl , ApiName: ClS.postcomment, Prams: parameter)
             
         }
       
      
}
class CommentCell: UITableViewCell{
    
    @IBOutlet weak var Profileimage: UIImageView!
    @IBOutlet weak var NameOfSender: UILabel!
    @IBOutlet weak var Descriptionlbl: UILabel!
}
