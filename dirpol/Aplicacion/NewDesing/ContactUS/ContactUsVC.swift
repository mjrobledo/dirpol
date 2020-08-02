//
//  ContactUsVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/18/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsVC: UIViewController , listadoDelegate, MFMailComposeViewControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewForm: UIView!
    
    @IBOutlet weak var lblTema: UITextField!
    @IBOutlet var viewCorrecto: UIView!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtEmpresa: UITextField!
    @IBOutlet weak var btnTema: UIButton!
    @IBOutlet weak var txtMensaje: UITextView!
    
    let req = requestContacto()
    var mail:MFMailComposeViewController! = nil
    
     @IBOutlet weak var btnMenu: UIBarButtonItem!
       
    override func viewDidLoad() {
           super.viewDidLoad()
           if revealViewController() != nil {
               btnMenu.target = revealViewController()
               btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
               view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
           }
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(OcultarTeclado))
        self.viewForm.addGestureRecognizer(tap1)
        
        // Do any additional setup after loading the view.
        txtNombre.text = ""
        txtEmpresa.text = Variables.Perfil.Nombre
        txtEmail.text = Variables.Perfil.Email
        
        
    }
    
    @objc func OcultarTeclado(){
        self.view.endEditing(true)
    }
    
    @IBAction func volver(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func enviarMensaje(_ sender: Any) {
        if validaCampos(){
            if !(txtEmail.text?.validaCorreo())!{
                Util().enviarAlerta(mensaje: .LaCuentaDeCorreoNoEsValida, titulo: .Alerta, controller: self)
                return
            }
            
            req.Nombre = (txtNombre.text?.trim())!
            req.Email = (txtEmail.text?.trim())!
            req.Mensaje = txtMensaje.text.trim()
            req.Contacto = (txtEmpresa.text?.trim())!
            req.Tema = (lblTema.text?.trim())!
            
            mail = MFMailComposeViewController()
            if mail != nil{
                mail.mailComposeDelegate = self
                mail.setSubject("\(req.Tema) - \(req.Contacto)")
                mail.setMessageBody(req.Mensaje, isHTML: false)
                mail.setToRecipients(["mjrobledo@live.com.mx"])
            
                self.present(mail, animated: true, completion: nil)
            }else{
                Util().enviarAlerta(mensaje: .ParaContactarnosEsNecesario, titulo: .Alerta, controller: self)
            }
        }else{
            Util().enviarAlerta(mensaje: .TodosLosCamposSonObligatorios, titulo: .Alerta, controller: self)
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.sent :
            self.viewCorrecto.frame = self.view.frame
            self.view.addSubview(self.viewCorrecto)
            mail.dismiss(animated: true, completion: nil)
            
        case MFMailComposeResult.failed:
            Util().enviarAlerta(mensaje: error.debugDescription, titulo: .Alerta, controller: self)
        case MFMailComposeResult.cancelled:
            mail.dismiss(animated: true, completion: nil)
            
        default:
            mail.dismiss(animated: true, completion: nil)
        }
    }
    
    private func validaCampos() -> Bool{
        var valido = true
        
        if (txtEmpresa.text?.trim() == ""){
            valido = false
        }
        if (txtMensaje.text?.trim() == ""){
            valido = false
        }
        if (txtEmail.text?.trim() == ""){
            valido = false
        }
        
        if (txtNombre.text?.trim() == ""){
            valido = false
        }
        if (lblTema.text?.trim() == ""){
            valido = false
        }
        
        return valido
        
    }
    
    @IBAction func SeleccionaTema(_ sender: Any) {
        self.performSegue(withIdentifier: strSegue.Listado, sender: nil)
    }
    
    func opcionSeleccionada(id: Int, nombre: String) {
        lblTema.text = nombre
    }
    func regionesSeleccionadas(ids: [Int], nombre: String) {
        
    }
    
    func limpiarFormulario(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        OcultarTeclado()
        
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == strSegue.Listado{
            let svc = segue.destination as! ListadoTemaVC
            svc.delegateListado = self
            svc.providesPresentationContextTransitionStyle = true;
            svc.definesPresentationContext = true;
            svc.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
            svc.pantallaPadre = strPantalla.Contacto
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
    

}
