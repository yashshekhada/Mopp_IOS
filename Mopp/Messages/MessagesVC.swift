//
//  MessagesVC.swift
//  Mopp
//
//  Created by apple on 17/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import JGProgressHUD
import FirebaseDatabase
class MessagesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource,  UICollectionViewDelegate
{
    @IBOutlet weak var MainViewFrag: UIView!
    @IBOutlet weak var cvSegment: UICollectionView!
    @IBOutlet weak var tvMsgList: UITableView!
    var MessagesDict = [String: Messagesx]()
    var MyFraend=[Messagesx]()
    var arrMsgs:NSMutableArray = []
    
    var arrSegment:NSMutableArray = [["name":"Chat","isSelect":1],["name":"Find","isSelect":0]]
    var ref: DatabaseReference!
    
    var SelectedFragment = 0
    //MARK: - LifeCycle Methods
    var FindUser = [Messagesx]()
    @IBOutlet weak var Nodataimageview: UIImageView!
    
    func Gifloader(){
        let jeremyGif = UIImage.gifImageWithName("Nodata")
        Nodataimageview.image = jeremyGif
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.cvSegment.dataSource = self
        self.cvSegment.delegate = self
        // Gifloader()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        cvSegment.collectionViewLayout = layout
        
        cvSegment.layer.cornerRadius = cvSegment.frame.height / 2
        cvSegment.layer.borderWidth = 2
        cvSegment.layer.borderColor = UIColor.init(red: 61/255, green: 97/255, blue: 156/255, alpha: 1).cgColor
        
        self.tvMsgList.delegate = self
        self.tvMsgList.dataSource = self
        self.tvMsgList.estimatedRowHeight = 55
        self.tvMsgList.rowHeight = UITableView.automaticDimension
        self.tvMsgList.tableFooterView = UIView()
        self.tvMsgList.backgroundColor = .clear
        observeUserMessages(value : 0)
    }
    func observeUserMessages(value : Int) {
        
        self.FindUser=[Messagesx]()
        
        self.tvMsgList.reloadData()
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        
        if value == 1{
            let ref = Database.database().reference().child("Students")
            let query = ref.queryOrdered(byChild: "uni_id").queryEqual(toValue: ClS.University_id)
            query.observe(.value, with: { (snapshot) in
                
                
                if let dict = snapshot.value as? [String: AnyObject] {
                    
                    for point in dict{
                        
                        var msg = Messagesx()
                        // let TypingAndCount=Database.database().reference().child("Chats").child(ClS.Uid).child(snapshot.key)
                        msg.email = String(point.value["email"] as! String)
                        msg.online = (point.value["online"] as? Bool)!
                        msg.uni_id = String(point.value["uni_id"] as! String)
                        msg.name = String(point.value["name"] as! String)
                        msg.last_name = String(point.value["last_name"] as! String)
                        msg.photo = String(point.value["photo"] as! String)
                        msg.Key_ID = point.key
                        self.FindUser.append(msg)
                        self.FindUser=self.FindUser.unique()
                      
                        self.tvMsgList.reloadData()
                    }
                    if self.FindUser.count == 0{
                        self.Nodataimageview.isHidden = false
                    }
                }
                hud.dismiss()
            })
            // self.FindUser.append(msg)
            
        }
        else if value == 0{
            
            let ref2 = Database.database().reference().child("FriendRequests").child(ClS.Uid)
            let query2 = ref2.queryOrdered(byChild: "request_type").queryEqual(toValue: "accepted")
            query2.observe(.value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject] {
                    self.FindUser=[Messagesx]()
                    self.tvMsgList.reloadData()
                    for point in dict{
                        let ChatStudent = Database.database().reference().child("Students").child(point.key)
                        
                        
                        ChatStudent.observe(.value, with: { (snapshot) in
                            let StudentData = snapshot.value as? [String:AnyObject]
                            
                            // for studPoint in StudentData{
                            var msg = Messagesx()
                            msg.email = StudentData!["email"] as! String
                            msg.online = StudentData!["online"] as? Bool
                            msg.uni_id = StudentData!["uni_id"] as! String
                            msg.name = StudentData!["name"] as! String
                            msg.last_name = StudentData!["last_name"] as! String
                            msg.photo = StudentData!["photo"] as! String
                            msg.Key_ID = point.key
                            self.FindUser.append(msg)
                            self.FindUser=self.FindUser.unique()
                         
                            self.tvMsgList.reloadData()
                            //     }
                            
                        })
                        
                    }
                    
                    if ( self.FindUser.count == 0)
                                             {
                                                 self.Nodataimageview.isHidden=false
                                             }else{
                                                 self.Nodataimageview.isHidden=true
                                             }
                }
                hud.dismiss()
                
            })
            
            
            // self.tvMsgList.reloadData()
        }
    }
    
    
    
    
    
    
    //MARK: - UITableViewDelegate & UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  self.FindUser.count///self.arrMsgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let imgProfile = cell.viewWithTag(101) as! UIImageView
        let vwDot = cell.viewWithTag(102)!
        let lblGreenDot = cell.viewWithTag(103) as! UILabel
        let lblName = cell.viewWithTag(104) as! UILabel
        let lblMsg = cell.viewWithTag(105) as! UILabel
        let lblTime = cell.viewWithTag(106) as! UILabel
        let lblCounter = cell.viewWithTag(107) as! UILabel
        //let dict = arrSegment[2] as! NSDictionary
        
        
        //  let isSelected = dict["isSelect"] as! Int
        //  if isSelected == 1
        //   {//
        lblName.text=self.FindUser[indexPath.row].name
        if self.FindUser[indexPath.row].online == false{
            lblGreenDot.backgroundColor = UIColor.gray
            lblTime.text=""
        }
        // }
        imgProfile.layer.cornerRadius = imgProfile.frame.size.height / 2
        imgProfile.layer.masksToBounds = true
        
        vwDot.layer.cornerRadius = vwDot.frame.size.height / 2
        vwDot.layer.masksToBounds = true
        
        lblGreenDot.layer.cornerRadius = lblGreenDot.frame.size.height / 2
        lblGreenDot.layer.masksToBounds = true
        
        lblCounter.layer.cornerRadius = lblCounter.frame.size.height / 2
        lblCounter.layer.masksToBounds = true
        
        cell.contentView.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if SelectedFragment == 0{
            let vc = mainStoryBrd.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
            vc.selectedUSer=self.FindUser[indexPath.row].Key_ID!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            
            let StudentData = ["request_type":"accepted"]
            //Database.database().reference().child("FriendRequests").setValue(ClS.Uid)
            // Database.database().reference().child("FriendRequests").child(ClS.Uid).setValue( self.FindUser[indexPath.row].Key_ID)
            Database.database().reference().child("FriendRequests").child(ClS.Uid).child(self.FindUser[indexPath.row].Key_ID!).setValue(StudentData)
            
            
            let dict = arrSegment[0] as! NSDictionary
            let name = dict["name"] as! String
            
            for i in 0..<arrSegment.count
            {
                let dictInner = arrSegment[i] as! NSDictionary
                let innerName = dictInner["name"] as! String
                let updatedInnerDict = dictInner.mutableCopy() as! NSMutableDictionary
                
                if name == innerName
                {
                    updatedInnerDict["isSelect"] = 1
                }
                else
                {
                    updatedInnerDict["isSelect"] = 0
                }
                arrSegment.replaceObject(at: i, with: updatedInnerDict.mutableCopy() as! NSDictionary)
            }
            SelectedFragment=0
            observeUserMessages(value:0)
            //             let selectedIndexPath = IndexPath(item: 0, section: 0)
            //                                cvSegment.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .left)
            cvSegment.reloadData()
            
            
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    //MARK: - UICollectionView DataSource and Delegate Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.arrSegment.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let img = cell.viewWithTag(101) as! UIImageView
        let lblName = cell.viewWithTag(102) as! UILabel
        
        img.layer.cornerRadius = img.frame.height / 2
        img.layer.masksToBounds = true
        
        let dict = arrSegment[indexPath.row] as! NSDictionary
        lblName.text = dict["name"] as? String
        
        let isSelected = dict["isSelect"] as! Int
        lblName.textColor = .black
        img.image = .none
        img.contentMode = .scaleAspectFill
        
        if isSelected == 1 {
            lblName.textColor = .white
            img.image = #imageLiteral(resourceName: "BtNBackGround")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let dict = arrSegment[indexPath.row] as! NSDictionary
        let name = dict["name"] as! String
        
        for i in 0..<arrSegment.count
        {
            let dictInner = arrSegment[i] as! NSDictionary
            let innerName = dictInner["name"] as! String
            let updatedInnerDict = dictInner.mutableCopy() as! NSMutableDictionary
            
            if name == innerName
            {
                updatedInnerDict["isSelect"] = 1
            }
            else
            {
                updatedInnerDict["isSelect"] = 0
            }
            arrSegment.replaceObject(at: i, with: updatedInnerDict.mutableCopy() as! NSDictionary)
        }
        //print(indexPath.row)
        SelectedFragment=indexPath.row
        observeUserMessages(value:indexPath.row)
        self.cvSegment.reloadData()
    }
    
    //MARK: - IBAction Meyhods
    @IBAction func btnBackTapped(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSearchTapped(_ sender: UIButton)
    {
        
    }
    
    //MARK: - APICalling For Messages
    
}

extension MessagesVC : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        var collectionViewSize = UIScreen.main.bounds.size
        
        collectionViewSize.width = (collectionViewSize.width/2.01)
        collectionViewSize.height = 45
        return collectionViewSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
}


extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
