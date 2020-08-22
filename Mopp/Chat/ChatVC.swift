//
//  ChatVC.swift
//  Mopp
//
//  Created by APPLE on 20/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD
import FirebaseDatabase
class ChatVC: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var btnImgProfile: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var tvChat: UITableView!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    var selectedUSer=""
    var  MsgDaata=[Messages]()
    //MARK: - LifeCycle Methods
    
    @IBAction func SendBtnAction(_ sender: UIButton) {
         //   let ref1 = Database.database().reference().child("Messages").child(ClS.Uid).child(selectedUSer)
        //let ref2 = Database.database().reference().child("Messages").child(selectedUSer).child(ClS.Uid)
  
       // ref2.setValue(dic)
       
        let id = Database.database().reference().childByAutoId().key
        let data : [String : Any] =
            ["messageFrom": ClS.Uid,
             "messageId": id,
             "messageTime": ServerValue.timestamp(),
             "messageType": "text",
             "message": txtMessage.text]
        
     //   ref1.setValue(Mail)
        Database.database().reference().child("Messages").child(ClS.Uid).child(selectedUSer).child(id!).setValue(data)
       //     Database.database().reference().child("Messages").child(ClS.Uid).child(selectedUSer).setValue(Mail)
        Database.database().reference().child("Messages").child(selectedUSer).child(ClS.Uid).child(id!).setValue(data)
              
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tvChat.delegate = self
        tvChat.dataSource = self
        self.tvChat.tableFooterView = UIView(frame: .zero)
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let ref2 = Database.database().reference().child("Messages").child(ClS.Uid).child(selectedUSer)
        let timeorderBy=ref2.queryOrdered(byChild: "messageTime")
        timeorderBy.observe(.value, with: { (snapshot) in
            if let dict = snapshot.value as? [String: AnyObject] {
                self.MsgDaata=[Messages]()
                
                for point in dict{
                    
                    //                               let StudentData = snapshot.value as? [String:AnyObject]
                    //
                    //                           // for studPoint in StudentData{
                    let msg = Messages()
                    msg.message = (point.value["message"] as! String)
                    msg.messageFrom = (point.value["messageFrom"] as! String)
                    msg.messageId = (point.value["messageId"] as! String)
                    msg.messageTime = (point.value["messageTime"] as! Int)
                    msg.messageType = point.value["messageType"] as! String
                    
                    
                    self.MsgDaata.append(msg)
                 //   self.MsgDaata.sort{String($0.messageTime) < String($1.messageTime)}
                     self.MsgDaata.sort(by: {String($0.messageTime!) < String($1.messageTime!) })
                    
                    self.tvChat.reloadData()
                    if  self.MsgDaata.count > 0{
                        let indexPath = NSIndexPath(row: self.MsgDaata.count-1, section: 0)
                        self.tvChat.scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
                        
                    }
                    //     }
                    
                    
                }
                
                
            }
            hud.dismiss()
            
        })
    }
    
    //MARK: - IBAction Methods
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UITableView DataSource and Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return MsgDaata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //   var cell = UITableViewCell()
        if self.MsgDaata[indexPath.row].messageFrom == ClS.Uid{
            var    Lcell = tableView.dequeueReusableCell(withIdentifier: "Sender", for: indexPath) as! Sender
            //        cell.imgBubbleSender.tintColor = UIColor.init(hexString: "F6356F")
            Lcell.SenderSms.text=MsgDaata[indexPath.row].message
            Lcell.SenderTime.text=""//MsgDaata[indexPath.row].messageTime
            return Lcell
        }else{
            var  Rcell = tableView.dequeueReusableCell(withIdentifier: "Rechiver", for: indexPath) as! Rechiver
            Rcell.ReciverMsg.text=MsgDaata[indexPath.row].message
            Rcell.RechiverTime.text=""//MsgDaata[indexPath.row].messageTime
            return Rcell
        }
        //  return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
}
class Sender: UITableViewCell
{
    
    
    @IBOutlet weak var SenderSms: UILabel!
    @IBOutlet weak var SenderTime: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
class Rechiver: UITableViewCell
{
    
    @IBOutlet weak var RechiverTime: UILabel!
    @IBOutlet weak var ReciverMsg: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
