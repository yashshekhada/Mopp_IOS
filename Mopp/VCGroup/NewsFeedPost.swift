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
class NewsFeedPostx: UIViewController {
var curruntImageIndex=0
    var ImageResource = [InputSource]()
       var UIImageResource = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    //SliderView.slideshowInterval = 5.0
             SliderView.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        SliderView.contentScaleMode = UIViewContentMode.scaleAspectFit

             let pageControl = UIPageControl()
             pageControl.currentPageIndicatorTintColor = UIColor.lightGray
             pageControl.pageIndicatorTintColor = UIColor.black
             SliderView.pageIndicator = pageControl

             // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
             SliderView.activityIndicator = DefaultActivityIndicator()
             SliderView.delegate = self

             
          
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(NewsFeedPostx.didTap))
             //SliderView.addGestureRecognizer(recognizer)
         }

         @objc func didTap() {
             let fullScreenController = SliderView.presentFullScreenController(from: self)
             // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
             fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
         }

 
    @IBAction func DeleteImage(_ sender: UIButton) {
        ImageResource.remove(at: curruntImageIndex)
        UIImageResource.remove(at: curruntImageIndex)
        self.SliderView.setImageInputs(ImageResource)
                       self.SliderView.reloadInputViews()
    }
    @IBOutlet weak var SliderView: ImageSlideshow!
    @IBAction func ImagePick(_ sender: UIButton) {
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
                self.UIImageResource = self.getAssetUIimage(asset: assets)
                self.SliderView.reloadInputViews()

            imagePicker.dismiss(animated: true, completion: nil)
            }, cancel: {
                //Cancel
            })
    }
    func getAssetThumbnail(asset: [PHAsset]) -> [InputSource] {
      var imganeth = [InputSource]()
        for point  in asset {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: point, targetSize: CGSize(width: 100.0, height: 100.0), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                thumbnail = result!
        })
         var dtast =  ImageSource(image:thumbnail)
            imganeth.append(dtast)
        }
        return imganeth
    }
    func getAssetUIimage(asset: [PHAsset]) -> [UIImage] {
        var imganeth = [UIImage]()
          for point  in asset {
          let manager = PHImageManager.default()
          let option = PHImageRequestOptions()
          var thumbnail = UIImage()
          option.isSynchronous = true
          manager.requestImage(for: point, targetSize: CGSize(width: 512, height: 512), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                  thumbnail = result!
          })
           
              imganeth.append(thumbnail)
          }
          return imganeth
      }
    @IBAction func BackBtn(_ sender: UIButton) {
    }
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    @IBOutlet weak var CommentText: UITextView!
    func postimage(){
        let hud = JGProgressHUD(style: .light)
               hud.textLabel.text = "Loading"
               hud.show(in: self.view)
               //let ImageData = resizeImage(image: self.ImageViewProduct.image!).pngData()
        var rendomeKey=randomString(length: 6)
               let parameters = [
                "description" : CommentText.text,
                   "numberofimages": ImageResource.count,
                   "code":   rendomeKey,
                   "s_id" : ClS.user_id,
                   "u_id":  ClS.University_id,
                   "session_token": ClS.Token,
                   
                   ] as [String : Any]
               let timestamp = NSDate().timeIntervalSince1970
               let url =  URL(string: ClS.baseUrl+ClS.createpost)!
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
                    var count = 0
                    for point in self.UIImageResource{
                        multipartFormData.append(point.pngData()!, withName: "image_", fileName: String(timestamp)+".png", mimeType: "image/png")
                    }
               },
                   to: urlString, //URL Here
                   method: .post,
                   headers: headers)
                   .responseJSON { (resp) in
                       defer{
                           hud.dismiss()
                           //self.statusClose!()
                           self.navigationController?.popViewController(animated: true)
                       }
                       print("resp is \(resp)")
               }
    }
}
extension NewsFeedPostx: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
        curruntImageIndex=page
    }
}
