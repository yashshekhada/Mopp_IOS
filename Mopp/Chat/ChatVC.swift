//
//  ChatVC.swift
//  Mopp
//
//  Created by APPLE on 20/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var btnImgProfile: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var tvChat: UITableView!
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    //MARK: - LifeCycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tvChat.delegate = self
        tvChat.dataSource = self
        self.tvChat.tableFooterView = UIView(frame: .zero)
    }
    
    //MARK: - IBAction Methods
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - UITableView DataSource and Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTVSenderCell", for: indexPath) as! ChatCell
//        cell.imgBubbleSender.tintColor = UIColor.init(hexString: "F6356F")
        cell.imgBubbleSender.image = #imageLiteral(resourceName: "bubble_sent").resizableImage(withCapInsets:UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),                                                               resizingMode: .stretch).withRenderingMode(.alwaysTemplate)
        return cell
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
