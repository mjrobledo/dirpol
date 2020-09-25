//
//  IniciarSesionVC.swift
//  dirpol
//
//  Created by macbook on 17/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

class IniciarSesionVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imgBackground: UIImageView!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var imgRemember: UIImageView!
    
    @IBOutlet weak var btnIniciaSesion: UIButton!
    @IBOutlet weak var btnRemember: UIButton!
    @IBOutlet weak var lblLine: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configScreen()
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(OcultarTeclado))
        tap1.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap1)
    
        //txtNombre.text = "29478"
        //txtPassword.text = "usuario2018"
        
        txtNombre.text = "earlene83"
        txtPassword.text = "password"
        
        
    }
    
    private func configScreen(){
        switch Api.config_app {
        case .Colombia:
            imgBackground.image = #imageLiteral(resourceName: "img_bacground_co")
            lblLine.isHidden = true
            txtNombre.borderWidth = 0.5
            txtNombre.colorCorner = UIColor.darkGray
            txtNombre.cornerRadius = 24
            txtPassword.borderWidth = 0.5
            txtPassword.colorCorner = UIColor.darkGray
            txtPassword.cornerRadius = 24
        case .Peru:
            imgBackground.image = UIImage(named: "img_login")
        case .Mexico:
            imgBackground.image = UIImage(named: "img_login")
        }
    }
    
    @objc private func OcultarTeclado(){
        self.view.endEditing(true)
    }
    
    private func limpiarTextos(){
        txtNombre.text = ""
        txtPassword.text = ""
    }
    
    private func validaCampos() -> Bool {
        var continua = true
        if txtPassword.text?.trim() == ""{
            continua = false
        }
        
        if txtNombre.text?.trim() == ""{
            continua = false
        }
        
        return continua
    }
    
    
    @IBAction func iniciarSesion(_ sender: Any) {
        let usuario = (txtNombre.text?.trim())!
        let password = (txtPassword.text?.trim())!
        var reqLogin : RequestLogin = RequestLogin()
        reqLogin.usuario = usuario
        reqLogin.password = password
        reqLogin.remember_me = btnRemember.tag
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            reqLogin.imei = uuid
        }
        
        if validaCampos(){
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Iniciando sesión")
                self.btnIniciaSesion.isEnabled = false
                self.OcultarTeclado()
                //self.performSegue(withIdentifier: "segueInicio", sender: nil)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                self.btnIniciaSesion.isEnabled = true
                
                //Variables.Perfil = Usuario().getUsuarioPrueba()
               
                Singleton.instance.services.login(user: reqLogin) { (response) in
                    if response != nil && !(response?.access_token.isEmpty)! {
                        Singleton.instance.services.getUser { (response) in
                            if response != nil {
                                SVProgressHUD.dismiss()
                                Singleton.instance.user = response?.usuario
                                Singleton.instance.codeAcred = (response?.codigoAcreditado)!
                                Singleton.instance.imgCredential = (response?.dirpolUrlCredential)!
                                Singleton.instance.avatar = (response?.avatar)!
                                self.getBusiness()
                            } else {
                                Util().enviarAlerta(mensaje:  .ErrorEnElServicio, titulo: .Alerta, controller: self)
                            }
                        }
                    } else {
                        SVProgressHUD.dismiss()
                        if response != nil {
                            Util().enviarAlerta(mensaje: (response?.message)!, titulo: .Alerta, controller: self)
                            
                        } else {
                             Util().enviarAlerta(mensaje:  .ErrorEnElServicio, titulo: .Alerta, controller: self)
                        }
                    }
                }
                
                /*Servicios().inicioSesion(usuario: reqLogin, completion: { respuesta  in
                    SVProgressHUD.dismiss()
                    if respuesta != nil {
                        switch respuesta?.Codigo {
                        case structCodigo.Correcto :
                            Variables.Perfil = (respuesta?.Usuario)!
                            Variables.Perfil.Password = (self.txtPassword.text?.trim())!
                                self.performSegue(withIdentifier: "segueInicio", sender: nil)
                        
                        case structCodigo.UsuarioNoExiste :
                                Util().enviarAlerta(mensaje: "Error de autenticación", titulo: .Alerta, controller: self)
                        
                        case structCodigo.PasswordErronea :
                            self.controlIntentos()
                            Variables.IntentosDeLogin = Variables.IntentosDeLogin + 1
                        
                        case structCodigo.CuentaBloqueada :
                            Util().enviarAlerta(mensaje: "Por seguridad su cuenta a sido bloqueada", titulo: .Alerta, controller: self)
                            
                        default:
                            print("No hay opciones login")
                        }
                    }else{
                        DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        // Util().enviarAlerta(mensaje:  .ErrorEnElServicio, titulo: .Alerta, controller: self)
                         self.performSegue(withIdentifier: "segueInicio", sender: nil)
                        }
                    }
                    
                })*/
               
            }
            
        }else{
            Util().enviarAlerta(mensaje: .TodosLosCamposSonObligatorios, titulo: .Alerta, controller: self)
        }
    }
    
    private func getBusiness() {
        SVProgressHUD.show()
        Singleton.instance.services.getBussiness(method: .post, header: Services.getHeader(), completion: { (response) in
            SVProgressHUD.dismiss()
            if response != nil {
                if let b = response?.data?.first {
                    Singleton.instance.business = b
                        self.performSegue(withIdentifier: "segueInicio", sender: nil)
                    }
            } else {
                Util().enviarAlerta(mensaje: "Error al descargar configuración de la empresa", titulo: "Intenta más tarde", controller: self)
                }
        })
    }
    
    private func controlIntentos(){
        switch Variables.IntentosDeLogin {
        case 1:
             Util().enviarAlerta(mensaje: "Intente de nuevo, clave incorrecta o el usuario no existe.", titulo: .Alerta, controller: self)
        case 2:
            Util().enviarAlerta(mensaje: "Clave incorrecta o el usuario no existe. Si se equivoca una vez más, por seguridad la cuenta será bloqueada.", titulo: "Advertencia", controller: self)
        case 3:
            let usuario:String = (txtNombre.text?.trim())!
            Servicios().bloquearCuenta(usuario: usuario) { repuesta  in
                if repuesta?.Codigo == structCodigo.Correcto{
                    Util().enviarAlerta(mensaje: " Bloqueo se completó con éxito. Por favor contacte con el administrador del sistema.", titulo: "Mensaje", controller: self)
                    
                }
            }
            
            
        default:
            print("Error")
        }
         Util().enviarAlerta(mensaje: "Error de autenticación", titulo: .Alerta, controller: self)
    }
    
    @IBAction func rememberMe(_ sender: UIButton) {
        if sender.tag == 1 {
            imgRemember.image = #imageLiteral(resourceName: "ic_check_off")
            sender.tag = 0
        } else {
            imgRemember.image = #imageLiteral(resourceName: "ic_check_on-1")
            sender.tag = 1
        }
    }
    
    @IBAction func volver(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Delegados de textos
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtNombre{
            txtPassword.becomeFirstResponder()
        }else{
            OcultarTeclado()
        }
        
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let navVC = segue.destination as? UINavigationController
        if segue.identifier == strSegue.RecuperaPassword {
            let vc = navVC?.viewControllers.first as! RecuperarVC
            vc.texto = .NoRecueraTuPassword
        } else if segue.identifier == strSegue.RecuperaUsuario {
            let vc = navVC?.viewControllers.first as! RecuperarVC
            vc.texto = .NoRecueraTuUsuario
        }
    }
    

}
