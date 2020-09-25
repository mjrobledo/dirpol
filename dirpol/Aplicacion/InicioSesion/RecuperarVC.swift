//
//  RecuperarVC.swift
//  dirpol
//
//  Created by macbook on 17/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire

class RecuperarVC: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var lblNotRemember: UILabel!
    
    @IBOutlet weak var lblPregunta: UILabel!
    //@IBOutlet weak var lblMensaje: UILabel!
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewForm: UIView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    
    @IBOutlet weak var viewTel: UIView!
    @IBOutlet weak var viewWs: UIView!
    @IBOutlet weak var viewFb: UIView!
    
    var texto = ""
    var RecuperaPasswordUsuario = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.colorBack()
        lblPregunta.text = texto
        // Do any additional setup after loading the view.
        if texto == .NoRecueraTuPassword {
            self.navigationItem.title = "Contraseña"
            //lblMensaje.text = .MensajePassword
            RecuperaPasswordUsuario = structServicio.RecuperaPassword
        }else{
            //lblMensaje.text = .MensajeUsuario
            self.navigationItem.title = "Usuario"
            RecuperaPasswordUsuario = structServicio.RecuperaUsuario
        }
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        self.viewForm.addGestureRecognizer(tap1)
        self.configScreen()
        self.getBusiness()
    }
    
    private func configScreen(){
        switch Api.config_app {
        case .Colombia:
            imgBackground.isHidden = true
            viewTel.roundView(porsion: 2)
            viewWs.roundView(porsion: 2)
            viewFb.roundView(porsion: 2)
            lblNotRemember.isHidden = true
            lblPregunta.font = UIFont().MontserratRegular(size: 17)
            if texto == .NoRecueraTuPassword {
                let main_string = "¿No recuerdas tu contraseña?"
                let string_to_color = "contraseña?"
                let attributedWithTextColor: NSAttributedString = main_string.attributedStringWithColor([string_to_color], color: UIColor.cPrincipal())
                lblPregunta.attributedText = attributedWithTextColor
            } else {
                
                let attributedWithTextColor: NSAttributedString = "¿No recuerdas tu usuario?".attributedStringWithColor(["usuario?"], color: UIColor.cPrincipal())
                
                lblPregunta.attributedText = attributedWithTextColor
               
            }
        case .Peru:
            imgBackground.image = UIImage(named: "menu_screen-1")
            viewTel.roundView(porsion: 3)
            viewWs.roundView(porsion: 3)
            viewFb.roundView(porsion: 3)
            
        case .Mexico:
            imgBackground.image = UIImage(named: "menu_screen-1")
        }
    }
    
    private func getBusiness() {
        SVProgressHUD.show()
        Singleton.instance.services.getBussiness(method: .get, header: nil, completion: { (response) in
            SVProgressHUD.dismiss()
            if response != nil {
                if let b = response?.data?.first {
                    Singleton.instance.business = b
                }
            } else {
                Util().enviarAlerta(mensaje: "Error al descargar configuración de la empresa", titulo: "Intenta más tarde", controller: self)
            }
        })
    }
    
    @objc func hideKeyBoard(){
        self.view.endEditing(true)
    }
    
     @IBAction func call(_ sender: Any) {
        if let tel = Singleton.instance.business.telefono {
            Util.llamar(tel: tel, viewController: self)
        }
     }
         
     @IBAction func whatsapp(_ sender: Any) {
        if let wsp = Singleton.instance.business.whatsapp {
            Util.openWhatsapp(number: wsp)
        }
     }
     
     @IBAction func facebook(_ sender: Any) {
        if let facebook = Singleton.instance.business.whatsapp {
            Util.openFB(idFacebook: facebook)
        }
     }

    @IBAction func volver(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func recuperarCuenta(_ sender: Any) {
        if (txtCorreo.text?.trim().estaVacio())! {
            Util().enviarAlerta(mensaje: .DebesAgregarUnCorreo, titulo: .Alerta, controller: self)
            return
        }
        if !(txtCorreo.text?.trim().validaCorreo())!{
            Util().enviarAlerta(mensaje: .FormatoCorreoInvalido, titulo: .Alerta, controller: self)
            return
        }
        
        self.hideKeyBoard()
        if Util.conexionInternet(){
            DispatchQueue.global(qos: .userInitiated).async {
            SVProgressHUD.show()
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if self.texto == .NoRecueraTuPassword {
                        self.recovery(type: "password")
                    } else {
                        self.recovery(type: "user")
                    }
                }
            }
        }else{
           Util().enviarAlerta(mensaje:  .DebesTenerConexionInternet, titulo: .Alerta, controller: self)
        }
    }
    
    private func recovery(type: String) {
        let email : String = (txtCorreo.text?.trim())!
        Singleton.instance.services.recoveryUser(email: email, type: type) { (response) in
            SVProgressHUD.dismiss()
            if response != nil && !(response?.message.isEmpty)! {
                Util().enviarAlerta(mensaje:  response!.message, titulo: .Alerta, controller: self)
            } else {
                if response == nil {
                    Util().enviarAlerta(mensaje:  .ErrorEnElServicio, titulo: .Alerta, controller: self)
                } else if response?.errors?.email != nil {
                    Util().enviarAlerta(mensaje:  (response?.errors?.email.first)!, titulo: .Alerta, controller: self)
                }
            }
        }
    }
    
    
    
    
    
    // MARK: - Scroll
    override func viewWillAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue )?.cgRectValue else{
                return
        }
        let contentInfo = UIEdgeInsets(top: 0, left: 0, bottom: frame.height     , right: 0)
        
        scrollView.contentInset = contentInfo;
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


struct structCodigo{
    static let Correcto = "200"
    
    //Variable para validar el inicio de sesión
    static let UsuarioNoExiste = "501"
    static let PasswordErronea = "502"
    static let CuentaBloqueada = "503"
    
    static let Error = "500"
    
}


extension  UIView {
    func roundView(porsion: Int) {
        self.layer.cornerRadius = self.frame.width / CGFloat(porsion)
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.cPrincipal().cgColor
        
        self.layer.borderWidth = 1
    }
}

extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont().MontserratBold(size: 18), range: range)
            
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}
