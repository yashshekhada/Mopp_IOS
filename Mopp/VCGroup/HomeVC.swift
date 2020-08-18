//
//  HomeVC.swift
//  Mopp
//
//  Created by mac on 8/6/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import iOTool
import ImageSlideshow
import JGProgressHUD
import ImageSlideShowSwift


class HomeVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate, ImageSlideshowDelegate {
    var GetNewsFeedArry=[GetNewsFeed_Data]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  GetNewsFeedArry.count
    }
    
    @IBOutlet weak var Searchview: UIView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let page = tableView.dequeueReusableCell(withIdentifier: "NewsFeedPost", for: indexPath) as! NewsFeedPost
        // page.slideshow.slideshowInterval = 5.0
        page.NameLbl.text = GetNewsFeedArry[indexPath.row].name
        page.Description.text = GetNewsFeedArry[indexPath.row].description
        page.slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .customBottom(padding: -40))
        page.slideshow.contentScaleMode = UIViewContentMode.scaleAspectFit
        var PotoArry=[String]();
        if GetNewsFeedArry[indexPath.row].post_images_array != nil{
            PotoArry = GetNewsFeedArry[indexPath.row].post_images_array!.components(separatedBy: ",")
        }
        var alamofireSource = [AlamofireSource]();
        for point in PotoArry {
            alamofireSource.append(AlamofireSource(urlString: ClS.ImageUrl+point.replacingOccurrences(of: " ", with: ""))!)
        }
        let dataPoint = GetNewsFeedArry[indexPath.row].post_images_array?.replacingOccurrences(of: " ", with: "")
        if (dataPoint?.count == 0 || dataPoint == "")
        {
            page.Hightconstraints.constant=0
            page.ImageCounter.isHidden=true
        }
        else if (dataPoint?.count != 0 || dataPoint != "")
        {
            page.Hightconstraints.constant=300
            page.ImageCounter.isHidden=false
        }
        if self.GetNewsFeedArry[indexPath.row].is_like == 0
        {
            page.LikeBtn.setImage(UIImage.init(named: "Thumb_like"), for: .normal)//818181
            page.LikeBtn.setTitleColor(UIColor.init(named: "unselectedTextColor"), for: .normal)
        }
        else{
            
            page.LikeBtn.setImage(UIImage.init(named: "Selectedthumb"), for: .normal)
            page.LikeBtn.setTitleColor(UIColor.init(named: "SelectedColor"), for: .normal)
        }
          page.ImageViewProfile.sd_setImage(with: URL(string: ClS.ImageUrl+GetNewsFeedArry[indexPath.row].image!), placeholderImage: UIImage(named: "user-icon"))
        page.ThumbCount.setTitle(" "+String(self.GetNewsFeedArry[indexPath.row].likes!), for: .normal)
        DispatchQueue.main.async {
            
            page.CommentSug={
                () in
                var page = self.storyboard?.instantiateViewController(withIdentifier: "CommentVC") as! CommentVC
                page.post_id=String(self.GetNewsFeedArry[indexPath.row].id!)
                self.navigationController?.pushViewController(page, animated: true)
            }
            page.likeSug={
                () in
                
                var EventModel=self.GetNewsFeedArry[indexPath.row]
                if self.GetNewsFeedArry[indexPath.row].is_like == 0{
                    
                    
                    self.GetNewsFeedArry[indexPath.row]=GetNewsFeed_Data.init(id: EventModel.id, description: EventModel.description, post_images_array: EventModel.post_images_array, likes: EventModel.likes! + 1, comments: EventModel.comments, numberofimages: EventModel.numberofimages, code: EventModel.code, s_id: EventModel.s_id, u_id: EventModel.u_id, status: EventModel.status, created_by: EventModel.created_by, updated_by: EventModel.updated_by, created_at: EventModel.created_at, updated_at: EventModel.updated_at, name: EventModel.name, image: EventModel.image, is_like: 1)
                    page.ThumbCount.setTitle(" "+String(self.GetNewsFeedArry[indexPath.row].likes!), for: .normal)
                    page.LikeBtn.setImage(UIImage.init(named: "Selectedthumb"), for: .normal)
                    page.LikeBtn.setTitleColor(UIColor.init(named: "SelectedColor"), for: .normal)
                    self.PostLike(post_id: String(EventModel.id!),like: "1")
                }else{
                    self.GetNewsFeedArry[indexPath.row]=GetNewsFeed_Data.init(id: EventModel.id, description: EventModel.description, post_images_array: EventModel.post_images_array, likes: EventModel.likes! - 1, comments: EventModel.comments, numberofimages: EventModel.numberofimages, code: EventModel.code, s_id: EventModel.s_id, u_id: EventModel.u_id, status: EventModel.status, created_by: EventModel.created_by, updated_by: EventModel.updated_by, created_at: EventModel.created_at, updated_at: EventModel.updated_at, name: EventModel.name, image: EventModel.image, is_like: 0)
                    page.ThumbCount.setTitle(" "+String(self.GetNewsFeedArry[indexPath.row].likes!), for: .normal)
                    page.LikeBtn.setImage(UIImage.init(named: "Thumb_like"), for: .normal)//818181
                    page.LikeBtn.setTitleColor(UIColor.init(named: "unselectedTextColor"), for: .normal)
                      self.PostLike(post_id: String(EventModel.id!),like: "0")
                }
            }
            //    let url = URL(string: ClS.ImageUrl+self.GetNewsFeedArry[indexPath.row].image!)
            //             let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            //            page.ImageViewProfile.image = UIImage(data: data!)
        }
        
        // page.ImageViewProfile.image = AlamofireSource(urlString: )
        page.totalImgCount = PotoArry.count
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.pageIndicatorTintColor = UIColor.lightText
        page.slideshow.pageIndicator = pageControl
        
        page.ImageCounter.text=" 1/" + String(page.totalImgCount)+" "
        page.slideshow.activityIndicator = DefaultActivityIndicator()
        page.slideshow.delegate = page
        
        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        page.slideshow.setImageInputs(alamofireSource)
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        page.slideshow.addGestureRecognizer(recognizer)
        return page
    }
    
    
    @IBOutlet weak var MyPortListView: UITableView!
    
    
    var size=0.0
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        
        if(scrollView.panGestureRecognizer.translation(in: scrollView.superview).y > 0)
        {
            print("up")
            Searchview.isHidden=false
            PostBarHight.constant=46
        }
        else
        {
            Searchview.isHidden=true
            PostBarHight.constant=0
            
            
            
            
            
        }
        //  PostBarHight.constant=CGFloat(size)
    }
    func GetPost() {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        //   var GetUnivercityData:GetUnivercity"
        let  University_id = iOTool.GetPref(Name: ClS.sf_University_id)
        let parameter:[String:Any]=["issearch":"0","univercity_id": String(University_id),"session_token":ClS.Token]
        
        NetWorkCall.get_Post_Api_Call(completion: { (T: GetNewsFeed) in
            hud.dismiss()
            
            
            if (T.statusCode == 1){
                self.GetNewsFeedArry=T.data!
                self.MyPortListView.reloadData()
                
            }
            else{
                let alertController = UIAlertController(title: ClS.App_Name, message:
                    T.statusMsg  , preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
                
                iOTool.SavePref(Name: ClS.sf_Status, Value: "0")
                
            }
            
            
        }, BaseUrl:ClS.baseUrl , ApiName: ClS.getpostlist, Prams: parameter)
        
    }
    func PostLike(post_id:String,like:String) {
           let hud = JGProgressHUD(style: .light)
           hud.textLabel.text = "Loading"
          // hud.show(in: self.view)
           //   var GetUnivercityData:GetUnivercity"
           let  University_id = iOTool.GetPref(Name: ClS.sf_University_id)
        let parameter:[String:Any]=["post_id":post_id,"likeby": ClS.user_id,"like":like,"session_token":ClS.Token]
           
           NetWorkCall.get_Post_Api_Call(completion: { (T: StatusModel2) in
            //   hud.dismiss()
               
               
             
               
               
           }, BaseUrl:ClS.baseUrl , ApiName: ClS.postlike, Prams: parameter)
           
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetPost()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var PostBarHight: NSLayoutConstraint!
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @objc func didTap(gesture : UITapGestureRecognizer) {
        //let fullScreenController = self.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        //   fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
        
    }
    
<<<<<<< HEAD
    @IBAction func PosBtnClick(_ sender: UIButton) {
        //let page = self.storyboard?.instantiateViewController(withIdentifier: <#T##String#>)
=======
    @IBAction func btnMsgTapped(_ sender: UIButton)
    {
        let vc = mainStoryBrd.instantiateViewController(withIdentifier: "MessagesVC") as! MessagesVC
        self.navigationController?.pushViewController(vc, animated: true)
>>>>>>> master
    }
}
class NewsFeedPost: UITableViewCell,ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
        ImageCounter.text=" "+String(page+1)+"/"+String(totalImgCount)+" "
        
    }
    var CommentSug:(()->())?
    var likeSug:(()->())?
    var totalImgCount=0
    var totalLike=0
    @IBOutlet weak var slideshow: ImageSlideshow!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var ImageViewProfile: UIImageView!
    
    @IBAction func CkickEventForComment(_ sender: UIButton) {
        CommentSug?()
        
    }
    @IBAction func LikeBtnClick(_ sender: UIButton) {
        likeSug?()
    }
    @IBOutlet weak var LikeBtn: UIButton!
    @IBOutlet weak var ImageCounter: UILabel!
    @IBOutlet weak var Hightconstraints: NSLayoutConstraint!
    
    @IBOutlet weak var ThumbCount: UIButton!
    
}
