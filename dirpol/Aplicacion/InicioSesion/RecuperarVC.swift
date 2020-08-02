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

    @IBOutlet weak var lblPregunta: UILabel!
    //@IBOutlet weak var lblMensaje: UILabel!
    @IBOutlet weak var txtCorreo: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewForm: UIView!
    
    
    var texto = ""
    var RecuperaPasswordUsuario = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
    @objc func hideKeyBoard(){
        self.view.endEditing(true)
    }
    
     @IBAction func call(_ sender: Any) {
         Util.llamar(tel: "+5115006000", viewController: self)
     }
         
     @IBAction func whatsapp(_ sender: Any) {
         Util.openWhatsapp()
     }
     
     @IBAction func facebook(_ sender: Any) {
         Util.openFB()
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
        let correo:String = (txtCorreo.text?.trim())!
        self.hideKeyBoard()
        if Util.conexionInternet(){
        DispatchQueue.global(qos: .userInitiated).async {
            SVProgressHUD.show()
            // Bounce back to the main thread to update the UI
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { 
                Servicios().recuperaUsuarioPassword(correo: correo, tipo: self.RecuperaPasswordUsuario, completion: { respuesta in
                    
                    SVProgressHUD.dismiss()
                    
                    if respuesta != nil{
                        if respuesta?.Codigo == structCodigo.Correcto{
                            Util().enviarAlerta(mensaje: .CorreoEnviadoCorrectamente, titulo: .Aplicacion, controller: self)
                            self.txtCorreo.text = ""
                            
                        }else{
                            Util().enviarAlerta(mensaje: (respuesta?.Mensaje)!, titulo: .Alerta, controller: self)
                        }
                    }else{
                         Util().enviarAlerta(mensaje:  .ErrorEnElServicio, titulo: .Alerta, controller: self)
                    }
                    
                })
            }
            }
        }else{
           Util().enviarAlerta(mensaje:  .DebesTenerConexionInternet, titulo: .Alerta, controller: self)
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
