//
//  ConversationsController.swift
//  Mopp
//
//  Created by mac on 7/30/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ConvesetionalCel"
class ConversationsController:UIViewController,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    private let tavleView = UITableView()
    override func viewDidLoad(){
    
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    func ConfigureTableView(){
        tavleView.backgroundColor = .white
        tavleView.rowHeight=80
        tavleView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tavleView.tableFooterView = UIView()
        view.addSubview(tavleView)
        tavleView.frame=view.frame
    }
}
class ConversationsCell: UITableViewCell {
    
}
