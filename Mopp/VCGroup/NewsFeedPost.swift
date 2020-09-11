//
//  NewsFeedPost.swift
//  Mopp
//
//  Created by mac on 8/18/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import ImageSlideshow
import JGProgressHUD
import ImageSlideShowSwift
import OpalImagePicker
import Alamofire
import Photos

class NewsFeedPostx: UIViewController
{
    @IBOutlet weak var SliderView: ImageSlideshow!
    @IBOutlet weak var CommentText: UITextView!
    @IBOutlet weak var BackView: UIImageView!
    @IBOutlet weak var switchAno: UISwitch!
    @IBOutlet weak var DeleteBtn: UIButton!
    
    var Acklogo:(()->())?
    var curruntImageIndex=0
    var ImageResource = [InputSource]()
    var UIImageResource = [UIImage]()
    
    var anonymous:Int = 0
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad()
    {
        super.viewDidLoad()

        SliderView.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        SliderView.contentScaleMode = UIViewContentMode.scaleAspectFill

        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        SliderView.pageIndicator = pageControl

        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        SliderView.activityIndicator = DefaultActivityIndicator()
        SliderView.delegate = self

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(NewsFeedPostx.didTap))
            //SliderView.addGestureRecognizer(recognizer)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        SliderView.addGestureRecognizer(tap)
        self.switchAno.isOn = true
        self.anonymous = 1
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let imagePicker = OpalImagePickerController()

               //Change color of selection overlay to white
               imagePicker.selectionTintColor = UIColor.white.withAlphaComponent(0.7)

               //Change color of image tint to black
               imagePicker.selectionImageTintColor = UIColor.black

               //Change image to X rather than checkmark
               imagePicker.selectionImage = UIImage(named: "x_image")

               //Change status bar style
               imagePicker.statusBarPreference = UIStatusBarStyle.lightContent

               //Limit maximum allowed selections to 5
               imagePicker.maximumSelectionsAllowed = 10

               //Only allow image media type assets
               imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])

               //Change default localized strings displayed to the user
               let configuration = OpalImagePickerConfiguration()
               configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You cannot select that many images!", comment: "")
               imagePicker.configuration = configuration
               presentOpalImagePickerController(imagePicker, animated: true,
                   select: { (assets) in
                       self.ImageResource = self.getAssetThumbnail(asset: assets)
                       self.SliderView.setImageInputs(self.ImageResource)
                       self.UIImageResource = self.getAssetThumbnailUI(assets: assets)
                       self.SliderView.reloadInputViews()
                    
                   imagePicker.dismiss(animated: true, completion: nil)
                   }, cancel: {
                       //Cancel
                   })
    }
    @objc func didTap()
    {
        let fullScreenController = SliderView.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    //MARK: - IBAction Methods
    @IBAction func switchAno(_ sender: UISwitch)
    {
        if switchAno.isOn == true {
            self.anonymous = 1
        } else {
            self.anonymous = 0
        }
    }
    
    @IBAction func DeleteImage(_ sender: UIButton)
    {
   
        ImageResource.remove(at: curruntImageIndex)
        UIImageResource.remove(at: curruntImageIndex)
        if ImageResource.count > 0 {
                     DeleteBtn.isHidden=false
                 }else{
                        DeleteBtn.isHidden=true
                 }
        self.SliderView.setImageInputs(ImageResource)
        self.SliderView.reloadInputViews()
    }
    
    @IBAction func ImagePick(_ sender: UIButton)
    {
       let imagePicker = OpalImagePickerController()

        //Change color of selection overlay to white
        imagePicker.selectionTintColor = UIColor.white.withAlphaComponent(0.7)

        //Change color of image tint to black
        imagePicker.selectionImageTintColor = UIColor.black

        //Change image to X rather than checkmark
        imagePicker.selectionImage = UIImage(named: "x_image")

        //Change status bar style
        imagePicker.statusBarPreference = UIStatusBarStyle.lightContent

        //Limit maximum allowed selections to 5
        imagePicker.maximumSelectionsAllowed = 10

        //Only allow image media type assets
        imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])

        //Change default localized strings displayed to the user
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You cannot select that many images!", comment: "")
        imagePicker.configuration = configuration
        presentOpalImagePickerController(imagePicker, animated: true,
            select: { (assets) in
                self.ImageResource = self.getAssetThumbnail(asset: assets)
                self.SliderView.setImageInputs(self.ImageResource)
                self.UIImageResource = self.getAssetThumbnailUI(assets: assets)
                self.SliderView.reloadInputViews()
             
            imagePicker.dismiss(animated: true, completion: nil)
            }, cancel: {
                //Cancel
            })
    }
    
    @IBAction func BackBtn(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func PostImgeBtnAction(_ sender: UIButton) {
        //postimage()
        self.APICallingAddPost()
    }
    
    //MARK: - Custom Methods
    func getAssetThumbnail(asset: [PHAsset]) -> [InputSource]
    {
        var imganeth = [InputSource]()
        if asset.count > 0 {
            DeleteBtn.isHidden=false
        }else{
               DeleteBtn.isHidden=true
        }
        for point  in asset {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: point, targetSize: CGSize(width: 600, height: 400), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
        })
         var dtast =  ImageSource(image:thumbnail)
            imganeth.append(dtast)
        }
        return imganeth
    }
    
    func getAssetThumbnailUI(assets: [PHAsset]) -> [UIImage]
    {
        var arrayOfImages = [UIImage]()
        for asset in assets {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var image = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                 image = result!
                 arrayOfImages.append(image)
            })
        }
        return arrayOfImages
     }
    
    func randomString(length: Int) -> String
    {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func postimage()
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        //let ImageData = resizeImage(image: self.ImageViewProduct.image!).pngData()
        
        let rendomeKey=randomString(length: 6)
               let parameters = [
                "description" : CommentText.text ?? "",
                   "numberofimages": ImageResource.count,
                   "code":   rendomeKey,
                   "s_id" : ClS.user_id,
                   "u_id":  ClS.University_id,
                   "session_token": ClS.Token,
                "post_images_array":"",
                "id":"",
                "isanonymous":"0"
                   ] as [String : Any]
               let urlString = ClS.baseUrl+ClS.createpost
               let headers: HTTPHeaders =
                   ["Content-type": "multipart/form-data",
                    "Accept": "application/json"]
               AF.upload(
                   multipartFormData: { multipartFormData in
                       for (key, value) in parameters {
                           if let temp = value as? String {
                               multipartFormData.append(temp.data(using: .utf8)!, withName: key)}
                           
                           if let temp = value as? Int {
                               multipartFormData.append("(temp)".data(using: .utf8)!, withName: key)}
                           
                           if let temp = value as? NSArray {
                               temp.forEach({ element in
                                   let keyObj = key + "[]"
                                   if let string = element as? String {
                                       multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                                   } else
                                       if let num = element as? Int {
                                           let value = "(num)"
                                           multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                                   }
                               })
                           }
                       }
                    var count = 1
                    for point in self.UIImageResource{
                          self.BackView.image = point
                    multipartFormData.append(self.UIImageResource[0].pngData()!, withName: "image_"+String(count), fileName: "image_"+String(count)+".png", mimeType: "image/png")
                        count+=1
                    }
               },
                   to: urlString, //URL Here
                   method: .post,
                   headers: headers)
                   .responseJSON { (resp) in
                       defer{
                           hud.dismiss()
                        self.Acklogo?()
                           //self.statusClose!()
                           self.navigationController?.popViewController(animated: true)
                       }
                       print("resp is \(resp)")
               }
    }
    
    //MARK: - AICalling Methods
    func APICallingAddPost()
    {
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        
        let rendomeKey=randomString(length: 6)
        
        let param:NSMutableDictionary = [
                 "session_token":ClS.Token,
                 "u_id":ClS.University_id,
                 "s_id":ClS.user_id,
                 "code":rendomeKey,
                 "description":CommentText.text ?? "",
                 "numberofimages": "\(ImageResource.count)",
            "isanonymous":"\(self.anonymous)"]
        
        for i in 0..<ImageResource.count {
            param["image_\(i + 1)"] = "Need:\(i)"
        }
        print(param)
        
        if Utill.reachable()
        {
            let strUrl = ClS.baseUrl+ClS.createpost
            let strEncoded:String = strUrl
            
            AF.upload(multipartFormData: { (multipartFormData) in
                
                for (key, value) in (param.mutableCopy() as! NSDictionary) {
                    
                    if (((value as? String) != nil)) && (value as! String).hasPrefix("Need:")
                    {
                        let v = (value as! String).dropFirst(5)
                        
                        if Int(v)! >= 0
                        {
                            let img = self.UIImageResource[Int(v)!]
                            multipartFormData.append(img.pngData()!, withName: key as! String, fileName: "picture.png", mimeType: "image/png")
                        }
                    }
                    else
                    {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key as! String)
                    }
                }
                
            },to: strEncoded, usingThreshold: UInt64.init(),
            method: .post,
            headers: nil).response{ response in
            
                hud.dismiss()
                print(response)
                
                if((response.error == nil))
                {
                    do
                    {
                        if let jsonData = response.data
                        {
                            let dict = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                            
                            let statusMsg = dict["statusMsg"] as? String ?? ""
                            print("add_Post : \(statusMsg)")
                            
                            if let statusCode = dict["statusCode"] as? NSNumber
                            {
                                if statusCode == 1
                                {
                                    print(statusMsg)
                                    self.Acklogo?()
                                    self.navigationController?.popViewController(animated: true)
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
                    }
                    catch
                    {
                        print(" encodingError is \(response.error ?? "Error" as! Error)")
                        hud.dismiss()
                    }
                }
                else
                {
                    hud.dismiss()
                }
            }
        }
    }
}

extension NewsFeedPostx: ImageSlideshowDelegate
{
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
        curruntImageIndex=page
    }
}
