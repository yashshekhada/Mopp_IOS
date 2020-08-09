//
//  SignUpVC.swift
//  Mopp
//
//  Created by mac on 7/31/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import iOTool
import YYCalendar
import JGProgressHUD
import iOSDropDown
class SignUpVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GetUniverSity()
        self.SelectUniDrp.didSelect{(selectedText , index ,id) in
                      self.SelectUniDrp.text = (selectedText)
                       //  self.SelectUniDrp.hideList()()
                             //self.SelectUniDrp.hideList()
                          }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var CheckBox_btn: UIButton!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var SelectUniDrp: DropDown!
    var GetUnivercityData=[GetUnivercity_Data]()
       func GetUniverSity() {
           let hud = JGProgressHUD(style: .light)
           hud.textLabel.text = "Loading"
           hud.show(in: self.view)
    //   var GetUnivercityData:GetUnivercity
           let parameter:[String:Any]=["":""]
           NetWorkCall.get_Api_Call(completion: { (T: GetUnivercity) in
               hud.dismiss()
       
               self.GetUnivercityData = T.data!
               var arraySS=[String]()
               var arraySSid = [String]()
               for point in self.GetUnivercityData{
                   arraySS.append(point.name!)
                    arraySSid.append(point.name!)
               }
               self.SelectUniDrp.optionArray=arraySS
             
              
           }, BaseUrl:ClS.baseUrl , ApiName: ClS.getunivercity, Prams: parameter)
        
       }
    @IBOutlet weak var Birthdat_Txt: UITextField!
    @IBAction func SelectDate(_ sender: Any) {
        
        DispatchQueue.main.async {
        let date = Date()
        let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yyyy"
            let result = formatter.string(from: date)
        let calendar = YYCalendar(normalCalendarLangType: .ENG, date: result, format: "MM/dd/yyyy") { date in
            self.Birthdat_Txt.text=date
        }
            calendar.headerViewBackgroundColor = UIColor.init(named: "TitleColor")!
        calendar.show()
        }
    }
    @IBAction func BackEvent(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func EventAgree(_ sender: UIButton) {
        SetStatusofRememberme()
    }
    func SetStatusofRememberme(){
           let status = iOTool.GetPref(Name:  ClS.RememberMe_status)
           if (status == "0" || status == "") {
               iOTool.SavePref(Name:  ClS.RememberMe_status, Value: "1")
               CheckBox_btn.setImage(#imageLiteral(resourceName: "check-box"), for: .normal)
               
           }
           
           if status == "1" {
               iOTool.SavePref(Name:  ClS.RememberMe_status, Value: "0")
               CheckBox_btn.setImage(#imageLiteral(resourceName: "checkbox"), for: .normal)
               
               //  RememberMeBtn.setImage(uiima, for: .normal)
               
           }
       }
}
