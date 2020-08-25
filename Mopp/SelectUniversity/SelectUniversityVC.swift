//
//  SelectUniversityVC.swift
//  Mopp
//
//  Created by apple on 24/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

protocol selectUniversity
{
    func btnConfirm(dict:NSDictionary)
}
class SelectUniversityVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate
{
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var tvList: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var ObjConfirmDelegate:selectUniversity?
    var arrData:NSMutableArray = []
    var arrTemp:NSMutableArray = []
    var strSelectedNm:String = ""
    var selectedDict:NSDictionary?
    var ssImage:UIImage?
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.backImg.image = ssImage
        self.searchBar.delegate = self
        self.tvList.delegate = self
        self.tvList.dataSource = self
        self.tvList.tableFooterView = UIView(frame: .zero)
    }

    //MARK: - IBAction Methods
    @IBAction func btnCancel(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnConfirm(_ sender: UIButton)
    {
        if self.ObjConfirmDelegate != nil && self.selectedDict != nil {
            self.ObjConfirmDelegate?.btnConfirm(dict: self.selectedDict!)
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    //MARK: - UISearchBarDelegate Methods
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.arrTemp = []
        self.arrTemp = self.arrData
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.arrData = []
        self.arrData = self.arrTemp
        self.arrTemp = []
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.tvList.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.searchBar.text!.isEmpty {
            self.arrData = []
            self.arrData = self.arrTemp
            self.tvList.reloadData()
        }
        else
        {
            self.arrData = []
            for i in 0..<self.arrTemp.count {
                let dict : NSDictionary = self.arrTemp[i] as! NSDictionary
                let listItem = dict["title"] as! String
                if listItem.lowercased().range(of: self.searchBar.text!.lowercased()) != nil {
                    if listItem.lowercased().hasPrefix(searchText.lowercased()) {
                        self.arrData.add(dict)
                    }
                }
            }
            tvList.reloadData()
        }
    }
    
    //MARK: - UITableView DataSource and Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let lblTitle = cell?.viewWithTag(101) as! UILabel
        let dict = self.arrData[indexPath.row] as! NSDictionary
        lblTitle.text = dict["title"] as? String ?? ""
        
        cell?.accessoryType = .none
        cell?.tintColor = .black
        if self.strSelectedNm == dict["title"] as? String ?? ""
        {
            cell?.accessoryType = .checkmark
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.tintColor = .black
        self.strSelectedNm = (self.arrData[indexPath.row] as! NSDictionary)["title"] as! String
        self.selectedDict = self.arrData[indexPath.row] as? NSDictionary
        self.tvList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
}
