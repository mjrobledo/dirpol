//
//  Utileria.swift
//  Proyecto
//
//  Created by DESAPP-1 on 16/03/17.
//  Copyright © 2017 Lisyx. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

   var activitiyViewController:ActivityViewController? = nil


@objc protocol barDelegate {
    
    @objc optional func bntOK()
    @objc optional func getDate(strFecha: String, fechaDate: Date )
    @objc optional func setCantidad(strCantidad:String)
}



class Util: NSObject {
    /*! @brief Delegado de la clase. */
    var delegateUtil:barDelegate?
    
    var datePickerView:UIDatePicker = UIDatePicker()
    
    /** Metodo para enviar alerta
     - parameter viewController: A controlador donde se visualiza la alerta
     - parameter mensaje: A mensaje a mostrar en la alerta si el mensaje es vacio por default muestra Cargando...*/
    static  func abrirAlerta(viewControler : UIViewController, mensaje:String){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var msg = ""
        if(mensaje != ""){
            msg = mensaje
        }
        
        activitiyViewController = ActivityViewController(message: msg)
        viewControler.present(activitiyViewController!, animated: true, completion: nil)
    }
    
    static  func cerrarAlerta(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        activitiyViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    static func closeAlert(completion:@escaping () -> ()){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        activitiyViewController?.dismiss(animated: true, completion:{ () in
            DispatchQueue.main.async {
                completion()
            }
        }
        )
    }
    
    class func getDays(startDate: Date, endDate: Date) -> Int? {
        let calendar = NSCalendar.current
        let date1 = calendar.startOfDay(for: startDate)
        let date2 = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day
    }
    
    static func llamar(tel:String, viewController: UIViewController){
        if let url = URL(string: "telprompt://\(tel)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }else{
            Util().enviarAlerta(mensaje: "Número de teléfono no válido", titulo: "Alerta", controller: viewController)
        }
    }
    
    static func openWhatsapp(number : String) {
    
        let phoneNumber =  number // you need to change this number
        if let appURL = URL(string: "https://api.whatsapp.com/send?phone=\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(appURL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(appURL)
                }
            } else {
                // WhatsApp is not installed
            }
        } else {
            print("URL not valid")
        }
    
    }
    
    static func openFB(idFacebook: String) {
        if let url = URL(string: "fb://profile/\(idFacebook)") {
            let application = UIApplication.shared
            // Check if the facebook App is installed
            if application.canOpenURL(url) {
                application.open(url)
            } else {
                // If Facebook App is not installed, open Safari with Facebook Link
                application.open(URL(string: "https://de-de.facebook.com/apple")!)
            }
        } else {
            print("URL not valid")
        }
    }
    
    /******* Fin Metodo para enviar alerta  ********/
    
    
    /* Random */
    static func getRandom(num:Int)->Int{
        let randomNum:UInt32 = arc4random_uniform(UInt32(num)) // range is 0 to 99
        
        // convert the UInt32 to some other  types
        
        //let randomTime:TimeInterval = TimeInterval(randomNum)
        
        let random:Int = Int(randomNum)
        return random
        //let someString:String = String(randomNum) //string works too
    }

    /****************************************************************************
     *                Metodo TextField subVistas                                *
     ****************************************************************************/
    /**
     Agregar una barra de herramientas al teclado.
     @param UITextField
     @return
     */
     func agregarBarraTeclado(txt_aux: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 1/255, green: 104/255, blue: 61/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "LISTO", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.listo))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        txt_aux.inputAccessoryView = toolBar;
    }
    
    @objc func listo()  {
        self.delegateUtil?.bntOK?()
    }
    
     func agregarPickerFecha(txt_aux: UITextField){
        
        datePickerView.datePickerMode = UIDatePicker.Mode.date
       
        // datePickerView.minimumDate = Date()
        
        txt_aux.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
    }
    
    
    func agregarFechaHoraPicker(txt_aux: UITextField){
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.dateAndTime
        
        datePickerView.minimumDate = Date()
        
        txt_aux.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(self.retornaFechaHoraPicker(sender:)), for: UIControl.Event.valueChanged)
    }
    
     @objc func retornaFechaHoraPicker(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy hh:mm"
        let fecha = dateFormatter.string(from: sender.date)
        self.delegateUtil?.getDate?(strFecha: fecha, fechaDate: sender.date)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let fecha = dateFormatter.string(from: sender.date)
        self.delegateUtil?.getDate!(strFecha: fecha, fechaDate: sender.date)
    }
    
    func getFechaDefaultPicker()-> (strFecha:String, dateFecha:Date){
        let d = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let fecha = dateFormatter.string(from: d)
        return (fecha, d)
    }
    
    /*********************Termina Delegate Picker *********************************************/
    

    /** Retorna la Fecha en formato dd MMMM yyyy 
        - Parameter fechaD:  Formato Date */
    func getFechaString(fechaD:Date) -> String{
        TimeZone.ReferenceType.default = TimeZone(abbreviation: "UTC")!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let fecha = dateFormatter.string(from: fechaD)
        return fecha
    }
    
    
    func getFechaHoraString(fechaD:Date) -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh:mm"
        let fecha = dateFormatter.string(from: fechaD)
        return fecha
    }
    
    func getFechaHoraDate(fechaD:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy hh:mm:ss"
        let fecha = dateFormatter.string(from: fechaD)
        return fecha
    }
    
    
    
    func getFechaFormatDate(fecha:String) -> Date{
       // let string = "2016-10-18 22:06:20 +0000"
        
        let formatter1 = DateFormatter()
        formatter1.locale = Locale(identifier: "en_US_POSIX") // if this string was from web service or a database, you should set the locale
        formatter1.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        guard let date = formatter1.date(from: fecha) else {
            fatalError("Couldn't parse original date string")
        }
        return date
    }
    
    func getFechaCorta(fecha:String) -> Date{
        // let string = "2016-10-18 22:06:20 +0000"
        
        let formatter1 = DateFormatter()
        formatter1.locale = Locale(identifier: "en_US_POSIX") // if this string was from web service or a database, you should set the locale
        formatter1.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter1.date(from: fecha) else {
            return Date()
        
        }
        return date
    }
    
    func getStrFechaCorta(fecha:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateObj = dateFormatter.string(from:fecha as Date)

       // print("Dateobj: \(dateFormatter.string(from: dateObj))")
        return dateObj 
    }
    
    func restarFechas(fechaDe:String) -> String{
        let endDate:Date = self.getFechaCorta(fecha: fechaDe)
        
        let now = Date()
        //let endDate = now.addingTimeInterval(24 * 3600 * 17)
        
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.day]
        formatter.unitsStyle = .full
        let string = formatter.string(from: endDate, to:now )!
        print(string) // 2 weeks, 3 days
        
        return string
        
    }
    
    func escalaGris(image:UIImage) -> UIImage {
        let filter = CIFilter(name: "CIPhotoEffectMono")
        // convert UIImage to CIImage and set as input
        let ciInput = CIImage(image: image)
        filter?.setValue(ciInput, forKey: "inputImage")
        
        // get output CIImage, render as CGImage first to retain proper UIImage scale
        
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        
        return UIImage(cgImage: cgImage!)
    }
    
    func imagenOFF(image:UIImage) -> UIImage {
        
        
        let coreImage = CIImage.init(cgImage: image.cgImage!)
        //CIHighlightShadowAdjust    CISepiaTone
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(coreImage, forKey: kCIInputImageKey)
        filter?.setValue(0.9, forKey: kCIInputIntensityKey)
        
        if let output = filter?.value(forKey: kCIOutputImageKey) as? CIImage {
            let filteredImage = UIImage.init(ciImage: output)
            return filteredImage
        }else {
            print("image filtering failed")
            return image
        }
    }
    
    func brillo(image:UIImage) -> UIImage{
        
        let aCGImage = image.cgImage
        let aCIImage = CIImage.init(cgImage:  aCGImage!)
        
        var outputImage = CIImage();
        let context = CIContext(options: nil);
        
        let brightnessFilter = CIFilter(name: "CIColorControls");
        brightnessFilter?.setValue(aCIImage, forKey: "inputImage")
        
        brightnessFilter?.setValue(NSNumber(value: 0.0), forKey: "inputBrightness");
        brightnessFilter?.setValue(NSNumber(value: 0.231915), forKey: "inputSaturation");
        brightnessFilter?.setValue(NSNumber(value: 0.359574), forKey: "inputContrast");
        
        outputImage = (brightnessFilter?.outputImage!)!;
        let imageRef = context.createCGImage(outputImage, from: outputImage.extent)
        let newUIImage = UIImage.init(cgImage: imageRef!)
        return newUIImage;
        
    }

    
    func getNumeroPorcentaje(valor:Double) -> String{
        return String(format: "%.2f",valor)
    }
    
    
    func getAudioBase64(urlImage:URL) -> String{
        do {
            
            let fileData = try Data.init(contentsOf: urlImage)
            let fileStream:String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
            return fileStream
        } catch {
            //handle error
            print(error)
            return ""
            
        }
    }
    
    func getImagenBase64(imagen:UIImage) -> String{
        //Now use image to create into NSData format
        let imageData:NSData = imagen.pngData()! as NSData
        
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        print(strBase64)
        return strBase64
    }
    
    func decodificaImagen(strImagen:String) -> UIImage {
        let dataDecoded : Data = Data(base64Encoded: strImagen, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        return decodedimage!
    }
    
    
    func convierteMinutos(minutos:Int) -> String{
        if minutos < 60{
            return "\(minutos) min"
        }
        
        if minutos < 1440  {
            return "\(Int(minutos / 60)) h"
        }else{
            return "\(Int(minutos / 1440)) d"
        }
    }
    
     func enviarAlerta(mensaje:String, titulo:String, controller:UIViewController){
        let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: .Enterado, style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
    
    
    /****************  Verifica conexión a Internet  ***************************/
    static func conexionInternet() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}


/****************************************************************************
 *                Clases para view Cargando                                 *
 ****************************************************************************/

class ActivityViewController: UIViewController {
    
    private let activityView = ActivityView()
    
    init(message: String) {
        super.init(nibName: nil, bundle: nil)
        modalTransitionStyle = .crossDissolve
        modalPresentationStyle = .overFullScreen
        activityView.messageLabel.text = message
        view = activityView
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class ActivityView: UIView {
    
    let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    let boundingBoxView = UIView(frame: CGRect.zero)
    let messageLabel = UILabel(frame: CGRect.zero)
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        
        boundingBoxView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        boundingBoxView.layer.cornerRadius = 12.0
        
        activityIndicatorView.startAnimating()
        
        messageLabel.font = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
        messageLabel.textColor = UIColor.white
        messageLabel.textAlignment = .center
        messageLabel.shadowColor = UIColor.black
        messageLabel.shadowOffset = CGSize(width:0.0, height:1.0)
        messageLabel.numberOfLines = 0
        
        addSubview(boundingBoxView)
        addSubview(activityIndicatorView)
        addSubview(messageLabel)
}
    override func layoutSubviews() {
        super.layoutSubviews()
        
        boundingBoxView.frame.size.width = 160.0
        boundingBoxView.frame.size.height = 160.0
        boundingBoxView.frame.origin.x = ceil((bounds.width / 2.0) - (boundingBoxView.frame.width / 2.0))
        boundingBoxView.frame.origin.y = ceil((bounds.height / 2.0) - (boundingBoxView.frame.height / 2.0))
        
        activityIndicatorView.frame.origin.x = ceil((bounds.width / 2.0) - (activityIndicatorView.frame.width / 2.0))
        activityIndicatorView.frame.origin.y = ceil((bounds.height / 2.0) - (activityIndicatorView.frame.height / 2.0))
        
        let messageLabelSize = messageLabel.sizeThatFits(CGSize(width:160.0 - 20.0 * 2.0, height:CGFloat.greatestFiniteMagnitude))
        messageLabel.frame.size.width = messageLabelSize.width
        messageLabel.frame.size.height = messageLabelSize.height
        messageLabel.frame.origin.x = ceil((bounds.width / 2.0) - (messageLabel.frame.width / 2.0))
        messageLabel.frame.origin.y = ceil(activityIndicatorView.frame.origin.y + activityIndicatorView.frame.size.height + ((boundingBoxView.frame.height - activityIndicatorView.frame.height) / 4.0) - (messageLabel.frame.height / 2.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/****************************************************************************
 *               Fin Clases para view Cargando                              *
 ****************************************************************************/


 



