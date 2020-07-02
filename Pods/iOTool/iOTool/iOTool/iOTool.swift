//
//  iOTool.swift
//  iOTool
//
//  Created by JDeviO. on 19/03/20.
//  Copyright © 2020 J Dev iO. All rights reserved.
//

import Foundation

import UIKit


class RUExtension {
    
}
let IPHONE6_WIDTH       = 375.0
let IPHONE6_HEIGHT      = 667.0
let IPHONE6_PLUS_WIDTH  = 414.0
let Screen = UIScreen.main.bounds.size
let UserKey                          = "UserKey"

private let characterEntities : [ Substring : Character ] = [
    // XML predefined entities:
    "&quot;"    : "\"",
    "&amp;"     : "&",
    "&apos;"    : "'",
    "&lt;"      : "<",
    "&gt;"      : ">",
    
    // HTML character entity references:
    "&nbsp;"    : "\u{00a0}",
    // ...
    "&diams;"   : "♦",
]



extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
extension UIImageView{
    func addBlackGradientLayer(frame: CGRect){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor.clear.cgColor, UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor]
        gradient.locations = [0.0, 1.0]
        self.layer.addSublayer(gradient)
    }
}
extension UIStoryboard {
    static var login: UIStoryboard {
        return UIStoryboard(name: "Login", bundle: nil)
    }
    static var contact: UIStoryboard {
        return UIStoryboard(name: "Contact", bundle: nil)
    }
    static var storyboardMain: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    static var menu: UIStoryboard {
        return UIStoryboard(name: "Menu", bundle: nil)
    }
    static var booking: UIStoryboard {
        return UIStoryboard(name: "Booking", bundle: nil)
    }
    static var myBooking: UIStoryboard {
        return UIStoryboard(name: "MyBooking", bundle: nil)
    }
    static var popup: UIStoryboard {
        return UIStoryboard(name: "PopUp", bundle: nil)
    }
    
    /// Get view controller from storyboard by its class type
    /// Usage: let profileVC = storyboard!.get(ProfileViewController) /* profileVC is of type ProfileViewController */
    /// Warning: identifier should match storyboard ID in storyboard of identifier class
    public func get<T:UIViewController>(_ identifier: T.Type) -> T? {
        let storyboardID = String(describing: identifier)
        
        guard let viewController = instantiateViewController(withIdentifier: storyboardID) as? T else {
            return nil
        }
        
        return viewController
    }
}

extension Double {
    /// Returns propotional height according to device height
    var propotionalHeight: CGFloat {
        return Screen.height / CGFloat(IPHONE6_HEIGHT) * CGFloat(self)
    }
    
    /// Returns propotional width according to device width
    var propotional: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGFloat(IPHONE6_PLUS_WIDTH) / CGFloat(IPHONE6_WIDTH) * CGFloat(self)
        }
        return CGFloat(Screen.width) / CGFloat(IPHONE6_WIDTH) * CGFloat(self)
    }
    
    /// Returns rounded value for passed places
    ///
    /// - parameter places: Pass number of digit for rounded value off after decimal
    ///
    /// - returns: Returns rounded value with passed places
    func roundTo(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension CGFloat {
    /// Returns propotional height according to device height
    var propotionalHeight: CGFloat {
        return Screen.height / CGFloat(IPHONE6_HEIGHT) * CGFloat(self)
    }
    
    /// Returns propotional width according to device width
    var propotional: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return CGFloat(IPHONE6_PLUS_WIDTH) / CGFloat(IPHONE6_WIDTH) * CGFloat(self)
        }
        return CGFloat(Screen.width) / CGFloat(IPHONE6_WIDTH) * CGFloat(self)
    }
    
    
}

extension String {
    
    var htmlDecoded: NSAttributedString {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil)
        
        return decoded!
    }
    
    func getContactAttributed() -> NSAttributedString {
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 17.0)] as [NSAttributedString.Key : Any]
        let underlineAttributedString = NSAttributedString(string: self, attributes: underlineAttribute)
        return underlineAttributedString
    }
    
    func convertHtml() -> NSAttributedString{
        //     var valx=UIColor.init(named: "WhiteBg")
        let htmlCSSString = "<style> body {background-color:\((UIColor.init(named: "WhiteBg")?.toHexString())!); color: \((UIColor.init(named: "txtcolorblack")?.toHexString())!) }</style> \(self)"
        
        print("htmlCSSString"+htmlCSSString)
        // let data = htmlCSSString.data(using: .utf8) else { return NSAttributedString() }
        guard let data = htmlCSSString.data(using: .utf8) else { return NSAttributedString() }
        do{
            
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,  .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            
        }catch{
            return NSAttributedString()
        }
        //        guard let data = data(using: .utf8) else { return NSAttributedString() }
        //        do{
        //            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue ], documentAttributes: nil)
        //        }catch{
        //            return NSAttributedString()
        //        }
    }
    
    
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    func height(constrainedBy width: CGFloat, with font: UIFont) -> CGFloat {
        let constraintSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
        
        return boundingBox.height
    }
    
    func width(constrainedBy height: CGFloat, with font: UIFont) -> CGFloat {
        let constrainedSize = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constrainedSize, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
        
        return boundingBox.width
    }
    
    func estimatedHeightOfLabel(width:CGFloat) -> CGFloat {
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let attributes = [kCTFontAttributeName: UIFont.boldSystemFont(ofSize: 14.0.propotional)]
        
        let rectangleHeight = self.boundingRect(with: size, options: options, attributes: attributes as [NSAttributedString.Key : Any], context: nil).height
        
        return rectangleHeight
    }
    
    /// Returns trim string
    var trimmed: String{
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    var boolValue: Bool {
        return NSString(string: self).boolValue
    }
    var cardFormatted: String {
        var output = ""
        self.replacingOccurrences(of: " ", with: "").enumerated().forEach { index, c in
            if index % 4 == 0 && index > 0 {
                output += " "
            }
            output.append(c)
        }
        return output
    }
    
    var cardDateFormatted: String {
        var output = ""
        self.replacingOccurrences(of: "/", with: "").enumerated().forEach { index, c in
            if index % 2 == 0 && index > 0 {
                output += "/"
            }
            output.append(c)
        }
        return output
    }
    
    /// Returns length of string
    var length: Int{
        return self.count
    }
    
    /// Returns length of string after trim it
    var trimmedLength: Int{
        return self.trimmed.length
    }
    func hexStringToUIColor () -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
extension UserDefaults {
    public subscript(key: String) -> Any? {
        get {
            return object(forKey: key) as Any?
        }
        set {
            set(newValue, forKey: key)
            synchronize()
        }
    }
    
    public static func contains(_ key: String) -> Bool {
        return self.standard.contains(key)
    }
    
    public func contains(_ key: String) -> Bool {
        return self.dictionaryRepresentation().keys.contains(key)
    }
    
    public func reset() {
        UserDefaults.standard.removeObject(forKey: UserKey)
        synchronize()
    }
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension Date {
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}

extension UIView {
    @IBInspectable var proRadius : CGFloat {
        get {
            return layer.cornerRadius
        }set {
            layer.cornerRadius = newValue.propotional
        }
    }
    @IBInspectable var customRadius : CGFloat {
        get {
            return layer.cornerRadius
        }set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable var customBorderWidth : CGFloat {
        get {
            return layer.borderWidth
        }set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var customBorderColor : UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }set {
            layer.borderColor = newValue.cgColor
        }
    }
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
extension UILabel {
    @IBInspectable var propotionalFontSize : CGFloat {
        get {
            return font.pointSize
        }set {
            font = UIFont(name: font.fontName, size: newValue.propotional)
            
        }
    }
}
private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    
    @IBInspectable var propotionalFontSize : CGFloat {
        get {
            return font!.pointSize
        }set {
            font = UIFont(name: (font?.fontName)!, size: newValue.propotional)
            
        }
    }
}
extension UITextView:UITextViewDelegate {
    @IBInspectable var propotionalFontSize : CGFloat {
        get {
            return font!.pointSize
        }set {
            font = UIFont(name: (font?.fontName)!, size: newValue.propotional)
            
        }
    }
    
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}
extension Notification.Name {
    static let userLoggedInOut = Notification.Name(
        rawValue: "userLoggedInOut")
}
extension UIButton {
    @IBInspectable var propotionalFontSize : CGFloat {
        get {
            return titleLabel!.font.pointSize
        }set {
            titleLabel!.font = UIFont(name: titleLabel!.font.fontName, size: newValue.propotional)
            
        }
    }
    //    func setBackgroundColor(color: UIColor, forState: UIControlState) {
    //        UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
    //        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
    //        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 100, height: 100))
    //        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
    //        UIGraphicsEndImageContext()
    //        self.setBackgroundImage(colorImage, for: forState)
    //    }
}
extension UIImage {
    // MARK: - UIImage+Resize
    func compressTo(_ expectedSizeInMb:Double) -> Data? {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 0.5
        while (needCompress) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue) {
                if Double(data.count) < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }
        return imgData
    }
}
public enum PanDirection: Int {
    case up,
    down,
    left,
    right
    
    public var isX: Bool {
        return self == .left || self == .right
    }
    
    public var isY: Bool {
        return !isX
    }
}
extension UIImage {
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
extension UIPanGestureRecognizer {
    var direction: PanDirection? {
        let velocity = self.velocity(in: view)
        let vertical = fabs(velocity.y) > fabs(velocity.x)
        switch (vertical, velocity.x, velocity.y) {
        case (true, _, let y):
            return y < 0 ? .up : .down
            
        case (false, let x, _):
            return x > 0 ? .right : .left
        }
    }
}

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get {
            
            return layer.cornerRadius
            
        }
        
        set {
            
            layer.cornerRadius = newValue
            
            layer.masksToBounds = newValue > 0
            
        }
        
    }
    
    
    
    @IBInspectable var borderWidth: CGFloat {
        
        get {
            
            return layer.borderWidth
            
        }
        
        set {
            
            layer.borderWidth = newValue
            
        }
        
    }
    
    
    
    @IBInspectable var borderColor: UIColor? {
        
        get {
            
            return UIColor(cgColor: layer.borderColor!)
            
        }
        
        set {
            
            layer.borderColor = newValue?.cgColor
            
        }
        
    }
    
    
    
    @IBInspectable
    
    var shadowRadius: CGFloat {
        
        get {
            
            return layer.shadowRadius
            
        }
        
        set {
            
            layer.masksToBounds = false
            
            layer.shadowRadius = newValue
            
        }
        
    }
    
    
    
    @IBInspectable
    
    var shadowOpacity: Float {
        
        get {
            
            return layer.shadowOpacity
            
        }
        
        set {
            
            layer.masksToBounds = false
            
            layer.shadowOpacity = newValue
            
        }
        
    }
    
    
    
    @IBInspectable
    
    var shadowOffset: CGSize {
        
        get {
            
            return layer.shadowOffset
            
        }
        
        set {
            
            layer.masksToBounds = false
            
            layer.shadowOffset = newValue
            
        }
        
    }
    
    
    
    @IBInspectable
    
    var shadowColor: UIColor? {
        
        get {
            
            if let color = layer.shadowColor {
                
                return UIColor(cgColor: color)
                
            }
            
            return nil
            
        }
        
        set {
            
            if let color = newValue {
                
                layer.shadowColor = color.cgColor
                
            } else {
                
                layer.shadowColor = nil
                
            }
            
        }
        
    }
}
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}


public  func GetJsonModelByString<T: Decodable>( completion: @escaping (T) -> (),BaseUrl: String,ApiName: String, Prams: String)
{
    let url = URL(string: BaseUrl+ApiName)!
    var request = URLRequest(url: url)
    
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let Api_action:String=Prams
    
    let postString = Api_action;
    //                       print("SendPanicCallMessage" +  ClS.baseUrl+ClS.SendPanicCallMessageTag+"?"+postString)
    request.httpBody = postString.data(using: .utf8)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
        guard let data = data else {
            print("Error: No data to decode")
            return
        }
        
        //                        let myStruct = try? decodableTypes.init(jsonData: data) {
        //                        print(myStruct)
        print("SendPanicCallMessage Responce string "+String(decoding: data, as: UTF8.self))
        guard let blog = try? JSONDecoder().decode(T.self, from: data) else {
            print("Errors: Couldn't decode data into Blog")
            return
        }
        completion(blog)
        
    }
    task.resume()
    
}

public func GetJsonModelByDictionary<T: Decodable>( completion: @escaping (T) -> (),BaseUrl: String,ApiName: String, Prams: [String: Any]) {
    
    
    
    let url = URL(string: BaseUrl+ApiName)!
    
    var request = URLRequest(url: url)
    
    var params = Prams
    
    
    
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    
    
    request.httpMethod = "POST"
    
    
    request.httpBody = params.percentEscaped().data(using: .utf8)
    
    //print("SendPanicCallMessage Url string  \(params.percentEscaped())")
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
        
        
        guard let data = data else {
            
            print("Error: No data to decode")
            
            return
            
        }
        
        
        guard let blog = try? JSONDecoder().decode(T.self, from: data) else {
            
            print("Errors: Couldn't decode data into Blog")
            
            return
            
        }
        
        completion(blog)
        
    }
    
    task.resume()
    
}


public func SavePref(Name: String ,Value: String) {
    //print(Value)
    let preferences = UserDefaults.standard
    let currentLevelKey = Name
    preferences.set(Value, forKey: currentLevelKey)
    preferences.synchronize()
}

public func SavePrefIndexpath(Name: String ,Value: [IndexPath]) {
    //print(Value)
    let preferences = UserDefaults.standard
    
    let currentLevelKey = Name
    
    let data = NSKeyedArchiver.archivedData(withRootObject: Value)
    preferences.set(data, forKey: currentLevelKey)
    preferences.synchronize()
}

public func GetPref(Name:String)->String {
    var data: String=""
    let preferences = UserDefaults.standard
    let currentLevelKey = Name
    
    if preferences.object(forKey: currentLevelKey) == nil {
        //  Doesn't exist
        data=""
    } else {
        data=preferences.string(forKey:currentLevelKey)!
    }
    return data
}
public   func  GetPrefIndexpath(Name:String)->[IndexPath] {
    var data = [IndexPath]()
    let preferences = UserDefaults.standard
    let currentLevelKey = Name
    
    if preferences.object(forKey: currentLevelKey) == nil {
        //  Doesn't exist
        data=[IndexPath]()
    } else {
        let data1 = UserDefaults.standard.object(forKey: currentLevelKey) as? Data
        data = NSKeyedUnarchiver.unarchiveObject(with: data1!) as! [IndexPath]
    }
    return data
}

public  func getDateFormatter(string: String) -> String {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd-MM-yyyy"
    let date: Date? = dateFormatterGet.date(from: string)
    return dateFormatterPrint.string(from: date!);
}



extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
