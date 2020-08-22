//
//  MyPostVC.swift
//  Mopp
//
//  Created by APPLE on 21/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import iOTool
import JGProgressHUD
import Alamofire
import ImageSlideShowSwift
import ImageSlideshow

class MyPostVC: UIViewController, UITableViewDataSource, UITableViewDelegate,ImageSlideshowDelegate
{
    @IBOutlet weak var tvMyPost: UITableView!
    @IBOutlet weak var bgViewCorner: UIView!
    
    var size=0.0
    var CurruntPage=1
    var arrPost:NSMutableArray = []
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        
        self.SetLayout()
        self.APICallingGetPost(page: CurruntPage)
    }

    override func viewWillAppear(_ animated: Bool)
    {
        self.bgViewCorner.round(corners: [.topLeft,.topRight], cornerRadius: 28)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    //MARK: - Custome Methods
    func SetLayout()
    {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.gray
        
        self.tvMyPost.scrollsToTop = true
        self.tvMyPost.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            
            DispatchQueue.global(qos: .background).async {
                
                DispatchQueue.main.async {
                   
                    self?.APICallingGetPost(page: self!.CurruntPage)
                    self?.tvMyPost.dg_stopLoading()
                    
                }
            }
            
            }, loadingView: loadingView)
        
        self.tvMyPost.dg_setPullToRefreshFillColor(UIColor.clear)
        self.tvMyPost.dg_setPullToRefreshBackgroundColor(self.tvMyPost.backgroundColor!)

        self.tvMyPost.alwaysBounceVertical = true
        self.tvMyPost.bounces  = true
        
    }
    
    //MARK: - IBAction Methods
    @IBAction func btnBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMore(_ sender: UIButton)
    {
        let alert:UIAlertController=UIAlertController(title: "", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            //Delete
            let id = (self.arrPost[sender.tag] as! NSDictionary)["id"] as? Int ?? 0
            self.APICallingDeletePost(id: id, row: sender.tag)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        // Present the actionsheet
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = sender ;
            presenter.sourceRect = ((sender).bounds);
        }
        self.present(alert, animated: true, completion: nil)
    }
       
    @IBAction func btnLike(_ sender: UIButton)
    {
        var like = 0
        if sender.accessibilityHint == "0" {
            like = 1
        }
        let post_id = (self.arrPost[sender.tag] as! NSDictionary)["id"] as? Int ?? 0
        self.APICallingPostLikeUnlike(post_id: post_id, row: sender.tag, like: like)
    }
        
    @IBAction func btnComment(_ sender: UIButton)
    {
        let vc = mainStoryBrd.instantiateViewController(withIdentifier: "CommentVC") as! CommentVC
        vc.post_id=String((self.arrPost[sender.tag] as! NSDictionary)["id"] as? Int ?? 0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - UITableView DataSource and Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyPostTVCell
        
        cell.btnMore.tag = indexPath.row
        
        let dict = self.arrPost[indexPath.row] as! NSDictionary
        cell.lblDescription.text = dict["description"] as? String ?? ""
               
        //SlidShow Images
        cell.slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: -40))
        cell.slideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
                
        var PotoArry=[String]();
        if ((dict["post_images_array"] != nil) && (dict["post_images_array"]) as? String ?? "" != "") {
            PotoArry = (dict["post_images_array"] as! String).components(separatedBy: ",")
        }
        var alamofireSource = [AlamofireSource]();
        for point in PotoArry {
            alamofireSource.append(AlamofireSource(urlString: ClS.ImageUrl+point.replacingOccurrences(of: " ", with: ""))!)
        }
        let dataPoint = (dict["post_images_array"] as? String ?? "").replacingOccurrences(of: " ", with: "")
        if (dataPoint.count == 0 || dataPoint == "")
        {
            cell.slideshowHightconstraints.constant=0
            cell.lblImgCounter.isHidden=true
        }
        else if (dataPoint.count != 0 || dataPoint != "")
        {
            cell.slideshowHightconstraints.constant=300
            cell.lblImgCounter.isHidden=false
        }
        
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.pageIndicatorTintColor = UIColor.lightText
        cell.slideshow.pageIndicator = pageControl
        
        cell.lblImgCounter.text=" 1/" + String(PotoArry.count)+" "
        cell.slideshow.activityIndicator = DefaultActivityIndicator()
        cell.slideshow.delegate = self
        cell.slideshow.setImageInputs(alamofireSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        cell.slideshow.addGestureRecognizer(recognizer)
        
        //BtnLike
        cell.btnLike.tag=indexPath.row
        cell.btnLike.accessibilityHint="\(dict["is_like"] as? Int ?? 0)"
        if dict["is_like"] as? Int ?? 0 == 0
        {
            cell.btnLike.setImage(UIImage(named: "Thumb_like"), for: .normal)
            cell.btnLike.setTitleColor(UIColor(named: "unselectedTextColor"), for: .normal)
        }
        else{            
            cell.btnLike.setImage(UIImage(named: "Selectedthumb"), for: .normal)
            cell.btnLike.setTitleColor(UIColor(named: "SelectedColor"), for: .normal)
        }
        cell.btnLikeCount.setTitle(" \(dict["likes"] as? Int ?? 0)", for: .normal)
        
        //Profile
        cell.imgUserProfile.layer.cornerRadius = cell.imgUserProfile.frame.size.height / 2
        cell.imgUserProfile.layer.masksToBounds = true
        cell.lblSingleLater.layer.cornerRadius = cell.lblSingleLater.frame.size.height / 2
        cell.lblSingleLater.layer.masksToBounds = true
        
        let isanonymous = dict["isanonymous"] as? Int ?? 0
        if isanonymous == 0 {
            let imgUrl = dict["image"] as? String ?? ""
            cell.imgUserProfile.sd_setImage(with: URL(string: ClS.ImageUrl+imgUrl), placeholderImage: UIImage(named: "user-icon"))
            cell.lblName.text = dict["name"] as? String ?? ""
            cell.lblSingleLater.isHidden = true
            cell.imgUserProfile.isHidden = false
        }
        else {
            cell.lblName.text = "Anonymous"
            let nm = dict["name"] as! String
            cell.lblSingleLater.text = String((nm.first!).uppercased())
            cell.lblSingleLater.backgroundColor = .systemBlue
            cell.lblSingleLater.isHidden = false
            cell.imgUserProfile.isHidden = true
        }
        
        //Comment
        cell.btnComment.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        /*if self.arrPost.count > 0
        {
            let lastElement = (self.arrPost.count) - 1
            
            if indexPath.row == lastElement{
                
                CurruntPage+=1
                APICallingGetPost(page: CurruntPage)
            }
        }*/
    }
    
    //MARK: - Selector Methods
    @objc func didTap(gesture : UITapGestureRecognizer)
    {
        //let fullScreenController = self.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        //   fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
        
    }
    
    //MARK: - AICalling Methods
    func APICallingGetPost(page:Int)
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
       
        if Utill.reachable()
        {
            let  University_id = iOTool.GetPref(Name: ClS.sf_University_id)
              
            var param = [String:String]()
            param = ["session_token":ClS.Token,
                     "univercity_id":University_id,
                     "paginate":"\(ClS.PageSize)",
                     "page":"\(page)",
                     "issearch":"0",
                     "searchby":""]
            
            print(param)
            let apiUrl:String = ClS.baseUrl + ClS.getpostlist
            let requestOfAPI = AF.request(apiUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
            requestOfAPI.responseJSON { (response) in
                
                hud.dismiss()
                print(response)
                
                switch response.result{
                    
                case .success(let resultData):
                    
                    if let dict = resultData as? Dictionary<String,AnyObject>
                    {
                        let statusMsg = dict["statusMsg"] as? String ?? ""
                        print("GetPost : \(statusMsg)")
                        
                        if let statusCode = dict["statusCode"] as? NSNumber
                        {
                            if statusCode == 1
                            {
                                self.arrPost = []
                                self.arrPost = NSMutableArray(array: dict["data"] as? NSArray ?? [])
                                self.tvMyPost.reloadData()
                            }
                            else
                            {
                                var alertController = UIAlertController()
                                alertController = UIAlertController(title: ClS.App_Name, message: statusMsg, preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                    }
                    
                case .failure(_):
                    let error = "\(response)"
                    print(error)
                }
            }
        }
        
    }
    
    func APICallingDeletePost(id:Int,row:Int)
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        if Utill.reachable()
        {
            var param = [String:String]()
            param = ["session_token":ClS.Token,
                     "id":"\(id)"]
            
            print(param)
            let apiUrl:String = ClS.baseUrl + ClS.postdelete
            let requestOfAPI = AF.request(apiUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
            requestOfAPI.responseJSON { (response) in
                
                hud.dismiss()
                print(response)
                
                switch response.result{
                    
                case .success(let resultData):
                    
                    if let dict = resultData as? Dictionary<String,AnyObject>
                    {
                        let statusMsg = dict["statusMsg"] as? String ?? ""
                        print("DeletePost : \(statusMsg)")
                        
                        if let statusCode = dict["statusCode"] as? NSNumber
                        {
                            if statusCode == 1
                            {
                                self.arrPost.removeObject(at: row)
                                self.tvMyPost.deleteRows(at: [IndexPath(row: row, section: 0)], with: .none)
                                self.tvMyPost.reloadData()
                            }
                            else
                            {
                                var alertController = UIAlertController()
                                alertController = UIAlertController(title: ClS.App_Name, message: statusMsg, preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                    }
                    
                case .failure(_):
                    let error = "\(response)"
                    print(error)
                }
            }
        }
    }
    
    func APICallingPostLikeUnlike(post_id:Int,row:Int,like:Int)
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        if Utill.reachable()
        {
            var param = [String:String]()
            param = ["session_token":ClS.Token,
                     "post_id":"\(post_id)",
                    "likeby": ClS.user_id,"like":"\(like)"]
            
            print(param)
            let apiUrl:String = ClS.baseUrl + ClS.postlike
            let requestOfAPI = AF.request(apiUrl, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil, interceptor: nil)
            requestOfAPI.responseJSON { (response) in
                
                hud.dismiss()
                print(response)
                
                switch response.result{
                    
                case .success(let resultData):
                    
                    if let dict = resultData as? Dictionary<String,AnyObject>
                    {
                        let statusMsg = dict["statusMsg"] as? String ?? ""
                        print("DeletePost : \(statusMsg)")
                        
                        if let statusCode = dict["statusCode"] as? NSNumber
                        {
                            if statusCode == 1
                            {
                                let dict = self.arrPost[row] as! NSDictionary
                                let updatedDict = dict.mutableCopy() as! NSMutableDictionary
                                updatedDict["is_like"] = like
                                if like == 1 {
                                    updatedDict["likes"] = (dict["likes"] as! Int)+1
                                } else {
                                    updatedDict["likes"] = (dict["likes"] as! Int)-1
                                }
                                self.arrPost.replaceObject(at: row, with: updatedDict.mutableCopy() as! NSDictionary)
                                self.tvMyPost.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
                            }
                            else
                            {
                                var alertController = UIAlertController()
                                alertController = UIAlertController(title: ClS.App_Name, message: statusMsg, preferredStyle: .alert)
                                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

                                self.present(alertController, animated: true, completion: nil)
                            }
                        }
                    }
                    
                case .failure(_):
                    let error = "\(response)"
                    print(error)
                }
            }
        }
    }
}
