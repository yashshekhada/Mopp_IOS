//
//  MessagesVC.swift
//  Mopp
//
//  Created by apple on 17/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

class MessagesVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource,  UICollectionViewDelegate
{
    @IBOutlet weak var cvSegment: UICollectionView!
    @IBOutlet weak var tvMsgList: UITableView!
    
    var arrMsgs:NSMutableArray = []
    
    var arrSegment:NSMutableArray = [["name":"Chat","isSelect":1],["name":"Request","isSelect":0],["name":"Find","isSelect":0]]
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.cvSegment.dataSource = self
        self.cvSegment.delegate = self
        
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
    }
    
    //MARK: - UITableViewDelegate & UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10//self.arrMsgs.count
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
        let vc = mainStoryBrd.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        collectionViewSize.width = (collectionViewSize.width/3.01)
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
