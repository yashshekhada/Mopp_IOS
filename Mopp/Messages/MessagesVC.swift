//
//  MessagesVC.swift
//  Mopp
//
//  Created by apple on 17/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

class MessagesVC: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet weak var tvMsgList: UITableView!
    
    var arrMsgs:NSMutableArray = []
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()

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
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
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
