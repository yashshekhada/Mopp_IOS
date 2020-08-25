//
//  Util.swift
//  Mopp
//
//  Created by apple on 17/08/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import Foundation
import UIKit

let mainStoryBrd = UIStoryboard(name: "Main", bundle:nil)
let ud = UserDefaults.standard

//MARK: - Validation Method
func setValidationOnTextfield(placeholderString:String,textfiled:UITextField)
{
    let str: NSString = placeholderString as NSString
    let range1 = (str).range(of: "*")
    let attribute = NSMutableAttributedString.init(string: str as String)
    attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range1)
    textfiled.attributedPlaceholder = attribute
}

func isValidEmailAddress(emailAddressString: String) -> Bool
{
    var returnValue = true
    let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
    
    do {
        let regex = try NSRegularExpression(pattern: emailRegEx)
        let nsString = emailAddressString as NSString
        let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
        
        if results.count == 0
        {
            returnValue = false
        }
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        returnValue = false
    }
    
    return  returnValue
}

//MARK: - ALert
func createAlertViewController(title:String, message: String, viewController: UIViewController)
{
    let alert = UIAlertController(title: title, message: message,
                                  preferredStyle: UIAlertController.Style.alert)

    let okAction = UIAlertAction(title: "OK", style:
        UIAlertAction.Style.default, handler: nil)

    alert.addAction(okAction)

    viewController.present(alert, animated: true, completion: nil)
}

//MARK: - UIView cornerRadius
extension UIView
{
    func round(corners: UIRectCorner, cornerRadius: Double)
    {
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let bezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.layer.mask = shapeLayer
    }
}

//MARK: - ScreenShot Method
func takeScreenshot(_ shouldSave: Bool = false) -> UIImage?
{
    var screenshotImage :UIImage?
    let layer = UIApplication.shared.keyWindow!.layer
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
    guard let context = UIGraphicsGetCurrentContext() else {return nil}
    layer.render(in:context)
    screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return screenshotImage
}
