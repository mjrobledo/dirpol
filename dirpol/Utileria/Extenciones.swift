//
//  Extenciones.swift
//  Proyecto
//
//  Created by DESAPP-1 on 15/03/17.
//  Copyright © 2017 Miguel Robledo. All rights reserved.
//

import UIKit
import ObjectMapper

extension Double {
    var moneda:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        //formatter.currencyGroupingSeparator!
        formatter.minimumFractionDigits = 0
        formatter.locale = Locale.current
        return formatter.string(for: self)!
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func redondear(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


extension String{
    func contieneNumero() -> Bool{
        let newString = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        if(newString.characters.count > 0){
            return true
        }
        return false
    }
    
    func contieneCaracterEspecial() -> Bool{
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789")
        
        if self.rangeOfCharacter(from: characterset.inverted) != nil {
            return true
        }
        return false
    }
    
    func contieneMayusculas() -> Bool{
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let mayus = texttest.evaluate(with: self)
        if(mayus){
            return true
        }
        return false
    }
    
    func estaVacio() -> Bool {
        if(self.trimmingCharacters(in: .whitespacesAndNewlines)  == ""){
            return true
        }
        return false
    }
    
    func validaCorreo() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}



/** Calcula el tamaño de un texto**/
/*
extension String {
    
    func anchoDeTexto(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size
    }
    
    func altoDeTexto(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.height
    }
}
*/
extension Formatter {
    static let month: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        return formatter
    }()
    static let month2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LL"
        return formatter
    }()
    static let año: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    static let dia: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
}
extension Date {
    var mes: String  { return Formatter.month.string(from: self)    }
    var mesNum: String  { return Formatter.month2.string(from: self)    }
    var año:  String  { return Formatter.año.string(from: self)   }
    var dia: String { return Formatter.dia.string(from: self) }
}

extension UIProgressView {
    @IBInspectable var barHeight : CGFloat {
        get {
            return transform.d * 2.0
        }
        set {
            // 2.0 Refers to the default height of 2
            let heightScale = newValue / 2.0
            let c = center
            transform = CGAffineTransform(scaleX: 1.0, y: heightScale)
            center = c
        }
    }
}




extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
 
extension UIView
{
    func copiarView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}

 
extension Bundle {
    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
            return view
        }        
        fatalError("Could not load view with type " + String(describing: type))
    }
}

/* Colores */
extension UIColor {
    /* Retorna un color al azar */
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
    
    /** Mark Convierte n Color HEX a RGB y lo aplcia
     uso: let color2 = UIColor(hex: "ff0000")
     */
    convenience init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIImage {
    func resizeImage(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}


extension Date {
    /**  parcea la fecha JSON /Date(12345676) */
    init?(jsonDate: String) {
        
        let prefix = "/Date("
        let suffix = ")/"
        
        // Check for correct format:
        guard jsonDate.hasPrefix(prefix) && jsonDate.hasSuffix(suffix) else { return nil }
        
        // Extract the number as a string:
        let from = jsonDate.index(jsonDate.startIndex, offsetBy: prefix.characters.count)
        let to = jsonDate.index(jsonDate.endIndex, offsetBy: -suffix.characters.count)
        
        // Convert milliseconds to double
        guard let milliSeconds = Double(jsonDate[from ..< to]) else { return nil }
        
        // Create NSDate with this UNIX timestamp
        self.init(timeIntervalSince1970: milliSeconds/1000.0)
    }
}

extension UIImageView {
    public func imageFromServerURL(urlString: String, defaultImage : UIImage?) {
        if let di = defaultImage {
            self.image = di
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
 
/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 :::       AGREGA EL EFECTO DE SELCCIÓN UTILIZADA EN LA MAYORIA DE LOS FILTROS  :::
 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 */
extension UIButton {
    @IBInspectable var efecto: Bool   {
        get {
            return false
        }
        set {
            if newValue {
                self.setBackgroundColor(color: UIColor.cSecundarioV3(), forState: .selected)
                self.setBackgroundColor(color: UIColor.cSecundarioG81(), forState: .normal)
                
                self.setTitleColor(UIColor.white, for: .normal)
                self.setTitleColor(UIColor.white, for: .selected)
            }
        }
    }
    
    @IBInspectable var TextPrimaryColor: Bool   {
        get {
            return false
        }
        set {
            if newValue {
                self.setTitleColor(UIColor.cPrincipal()  , for: .normal)
                self.setTitleColor(UIColor.cPrincipal(), for: .selected)
            }
        }
    }
}

extension UILabel {
    @IBInspectable var LblPrimaryColor: Bool   {
        get {
            return false
        }
        set {
            if newValue {
                self.textColor = UIColor.cPrincipal()
            }
        }
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }}


extension UIView {
    func pintaRojo(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.cSecundarioR1().cgColor
    }
    
    func pintaNormal(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.cSecundarioG3().cgColor
    }
    
}

/*:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :::       Agregar sombra y esquinas redondeadas a cualquier View              :::
  :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
 */

extension UITextField{
        @IBInspectable var placeHolderColor: UIColor? {
            get {
                return self.placeHolderColor
            }
            set {
                self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
            }
        }
}


extension UIView {
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var colorCorner: UIColor   {
        get {
            return UIColor.clear
        }
        set {
            self.layer.masksToBounds = true
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {        
        get {
            return self.layer.borderWidth
        }set {
            self.layer.masksToBounds = true
            self.layer.borderWidth = newValue
            self.layer.borderColor = UIColor.cPrincipal().cgColor
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.cSecundarioN4().cgColor,
                   shadowOffset: CGSize = CGSize(width: 2.0, height: 2.0),
                   shadowOpacity: Float = 0.7,
                   shadowRadius: CGFloat = 2) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    @IBInspectable var primaryColor: Bool   {
        get {
            return false
        }
        set {
            if newValue {
                self.backgroundColor = UIColor.cPrincipal()
            }
        }
    }
}

extension UIImageView {
    @IBInspectable var ImgPrimaryColor: Bool   {
        get {
            return false
        }
        set {
            if newValue {
                self.image = self.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                self.tintColor = UIColor.cPrincipal()
            }
        }
    }
}

extension UIImageView {
@IBDesignable class TintedImageView: UIImageView {
    override func prepareForInterfaceBuilder() {
        self.configure()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.configure()
    }

    @IBInspectable override var tintColor: UIColor! {
        didSet {
            self.configure()
        }
    }
    
    private func configure() {
        self.image = self.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    }
     
}
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        tintColorDidChange()
    }    
}

/*_________________________________________________________________________________________*/


extension String {
    var dateFromISO8601: Date? {
        guard let parsedDate = Date.FormatterISO.iso8601.date(from: self) else {
            return nil
        }
        
        var preliminaryDate = Date(timeIntervalSinceReferenceDate: floor(parsedDate.timeIntervalSinceReferenceDate))
        
        if let fractionStart = self.range(of: "."),
            let fractionEnd = self.index(fractionStart.lowerBound, offsetBy: 7, limitedBy: self.endIndex) {
            let fractionRange = fractionStart.lowerBound..<fractionEnd
            let fractionStr = self.substring(with: fractionRange)
            
            if var fraction = Double(fractionStr) {
                fraction = Double(floor(1000000*fraction)/1000000)
                preliminaryDate.addTimeInterval(fraction)
            }
        }
        return preliminaryDate
    }
}


extension Date {
    struct FormatterISO {
        static let iso8601: DateFormatter = {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "es_MX_POSIX")
            formatter.timeZone = TimeZone(identifier: "UTC")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSXXXXX"
            return formatter
        }()
    }
    
    var iso8601: String {
        var data = FormatterISO.iso8601.string(from: self)
        if let fractionStart = data.range(of: "."),
            let fractionEnd = data.index(fractionStart.lowerBound, offsetBy: 7, limitedBy: data.endIndex) {
            let fractionRange = fractionStart.lowerBound..<fractionEnd
            let intVal = Int64(1000000 * self.timeIntervalSince1970)
            let newFraction = String(format: ".%06d", intVal % 1000000)
            data.replaceSubrange(fractionRange, with: newFraction)
        }
        return data
    }
}
