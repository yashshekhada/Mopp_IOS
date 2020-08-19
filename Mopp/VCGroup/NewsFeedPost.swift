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

import Photos
class NewsFeedPostx: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    SliderView.slideshowInterval = 5.0
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
         }

         @objc func didTap() {
             let fullScreenController = SliderView.presentFullScreenController(from: self)
             // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
             fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
         }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
        imagePicker.maximumSelectionsAllowed = 5

        //Only allow image media type assets
        imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])

        //Change default localized strings displayed to the user
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You cannot select that many images!", comment: "")
        imagePicker.configuration = configuration
        presentOpalImagePickerController(imagePicker, animated: true,
            select: { (assets) in
                var data = self.getAssetThumbnail(asset: assets)
                self.SliderView.setImageInputs(data)
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
    @IBAction func BackBtn(_ sender: UIButton) {
    }
}
extension NewsFeedPostx: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
}
