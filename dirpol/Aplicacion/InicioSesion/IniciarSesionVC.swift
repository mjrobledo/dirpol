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

    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var btnIniciaSesion: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(OcultarTeclado))
        tap1.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap1)
    
        txtNombre.text = "29478"
        txtPassword.text = "usuario2018"
        
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
        let reqLogin = RequestLogin()
        reqLogin.usuario = usuario
        reqLogin.password = password
        
        if validaCampos(){
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Iniciando sesión")
                self.btnIniciaSesion.isEnabled = false
                self.OcultarTeclado()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                
                self.btnIniciaSesion.isEnabled = true
                
                //Variables.Perfil = Usuario().getUsuarioPrueba()
                
                Servicios().inicioSesion(usuario: reqLogin, completion: { respuesta  in
                    SVProgressHUD.dismiss()
                    if respuesta != nil {
                        switch respuesta?.Codigo {
                        case structCodigo.Correcto :
                            Variables.Perfil = (respuesta?.Usuario)!
                            Variables.Perfil.Password = (self.txtPassword.text?.trim())!
                                self.performSegue(withIdentifier: "segueInicio", sender: nil)
                        
                        case structCodigo.UsuarioNoExiste :
                                Utileria().enviarAlerta(mensaje: "Error de autenticación", titulo: .Alerta, controller: self)
                        
                        case structCodigo.PasswordErronea :
                            self.controlIntentos()
                            Variables.IntentosDeLogin = Variables.IntentosDeLogin + 1
                        
                        case structCodigo.CuentaBloqueada :
                            Utileria().enviarAlerta(mensaje: "Por seguridad su cuenta a sido bloqueada", titulo: .Alerta, controller: self)
                            
                        default:
                            print("No hay opciones login")
                        }
                    }else{
                        DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                         Utileria().enviarAlerta(mensaje:  .ErrorEnElServicio, titulo: .Alerta, controller: self)
                         //self.performSegue(withIdentifier: "segueInicio", sender: nil)
                        }
                    }
                    
                })
               
            }
            
        }else{
            Utileria().enviarAlerta(mensaje: .TodosLosCamposSonObligatorios, titulo: .Alerta, controller: self)
        }
    }
    
    private func controlIntentos(){
        switch Variables.IntentosDeLogin {
        case 1:
             Utileria().enviarAlerta(mensaje: "Intente de nuevo, clave incorrecta o el usuario no existe.", titulo: .Alerta, controller: self)
        case 2:
            Utileria().enviarAlerta(mensaje: "Clave incorrecta o el usuario no existe. Si se equivoca una vez más, por seguridad la cuenta será bloqueada.", titulo: "Advertencia", controller: self)
        case 3:
            let usuario:String = (txtNombre.text?.trim())!
            Servicios().bloquearCuenta(usuario: usuario) { repuesta  in
                if repuesta?.Codigo == structCodigo.Correcto{
                    Utileria().enviarAlerta(mensaje: " Bloqueo se completó con éxito. Por favor contacte con el administrador del sistema.", titulo: "Mensaje", controller: self)
                    
                }
            }
            
            
        default:
            print("Error")
        }
         Utileria().enviarAlerta(mensaje: "Error de autenticación", titulo: .Alerta, controller: self)
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
        if segue.identifier == strSegue.RecuperaPassword {
            let vc = segue.destination as! RecuperarVC
            vc.texto = .NoRecueraTuPassword
        }
    }
    

}
