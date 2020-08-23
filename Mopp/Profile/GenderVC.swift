//
//  GenderVC.swift
//  Mopp
//
//  Created by APPLE on 23/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit

protocol GenderVCDelegate : class
{
    func didUpdateGender(strGender:String)
}

class GenderVC: UIViewController
{
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    
    weak var genderDelegate: GenderVCDelegate?
    var gender:String = ""
    
    //MARK: - LifeCyle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.btnMale.setImage(UIImage(named: "circle"), for: .normal)
        self.btnFemale.setImage(UIImage(named: "circle"), for: .normal)
    }
    
    //MARK: - IBAction Methods
    @IBAction func btnMaleFemaleTapped(_ sender: UIButton)
    {
        if sender.tag == 101 {
            self.btnMale.setImage(UIImage(named: "check_circle_filled"), for: .normal)
            self.btnFemale.setImage(UIImage(named: "circle"), for: .normal)
            self.gender = "Male"
        } else {
            self.btnFemale.setImage(UIImage(named: "check_circle_filled"), for: .normal)
            self.btnMale.setImage(UIImage(named: "circle"), for: .normal)
            self.gender = "Female"
        }
    }
    
    @IBAction func btnCancelTapped(_ sender: UIButton)
    {
        self.presentingPopin()?.dismissCurrentPopinController(animated: true)
    }
    
    @IBAction func btnUpdateTapped(_ sender: UIButton)
    {
        if self.genderDelegate != nil && self.gender != ""{
            self.presentingPopin()?.dismissCurrentPopinController(animated: true, completion: {
                self.genderDelegate?.didUpdateGender(strGender: self.gender)
            })
        }
        else{
            self.view.makeToast("Please Select Gender")
        }
    }
}
