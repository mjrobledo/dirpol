//
//  UserPanelVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/18/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

class UserPanelVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
       
       @IBOutlet weak var viewFrame: UIView!
       
       @IBOutlet weak var txtName: UITextField!
       
       @IBOutlet weak var txtUser: UITextField!
       @IBOutlet weak var txtPassword: UITextField!
       
       @IBOutlet weak var txtPasswordConfirm: UITextField!
       @IBOutlet weak var txtEmailConfirm: UITextField!
       @IBOutlet weak var txtEmail: UITextField!
    
     @IBOutlet weak var btnMenu: UIBarButtonItem!
          
       override func viewDidLoad() {
              super.viewDidLoad()
              if revealViewController() != nil {
                  btnMenu.target = revealViewController()
                  btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
                  view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
              }

        // Do any additional setup after loading the view.
      let tap1 = UITapGestureRecognizer(target: self, action: #selector(OcultarTeclado))
                self.viewFrame.addGestureRecognizer(tap1)
                
                // Do any additional setup after loading the view.
                self.llenarVista()
            }

            private func llenarVista(){
                txtName.text = Variables.Perfil.Nombre
                txtUser.text = Variables.Perfil.Username
                txtUser.isEnabled = false
                
                txtEmail.text = Variables.Perfil.Email
                txtEmailConfirm.text = Variables.Perfil.Email
                
                txtPassword.text = Variables.Perfil.Password
                txtPasswordConfirm.text = Variables.Perfil.Password
                
            }
            
            @objc func OcultarTeclado(){
                self.view.endEditing(true)
            }
            
            @IBAction func volver(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
            }
            
            @IBAction func guardaUsuario(_ sender: Any) {
                if validaCampos(){
                    let us:Usuario = Usuario()
                    us.Email = (txtEmail.text?.trim())!
                    us.Id = Variables.Perfil.Id
                    us.Nombre = (txtName.text?.trim())!
                    us.Username = Variables.Perfil.Username
                    us.Password = (txtPassword.text?.trim())!
                    
                    SVProgressHUD.show()
                    Servicios().editarUsuario(usuario: us, completion: {
                        resp in
                        SVProgressHUD.dismiss()
                        if resp != nil {
                            SVProgressHUD.showSuccess(withStatus: resp?.Mensaje)
                            SVProgressHUD.dismiss(withDelay: 3)
                            DispatchQueue.main.async {
                                Variables.Perfil = us
                                self.dismiss(animated: true, completion: nil)
                            }
                        }else{
                            SVProgressHUD.showError(withStatus: .ErrorEnElServicio)
                            SVProgressHUD.dismiss(withDelay: 3)
                        }
                    })
                }else{
                    
                }
            }
            
            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
            
            private func validaCampos() -> Bool{
                var valido = true
                
                for i in 1...5{
                    let txt = self.view.viewWithTag(i) as! UITextField
                    if txt.text?.trim() == ""{
                        valido = false
                        break
                    }
                }
                
                if !valido{
                    SVProgressHUD.showError(withStatus: .TodosLosCamposSonObligatorios)
                    SVProgressHUD.dismiss(withDelay: 4)
                    return false
                }
                
                if txtPassword.text?.trim() != txtPasswordConfirm.text?.trim(){
                    SVProgressHUD.showError(withStatus: .LasContrasenasNoCoinciden)
                    SVProgressHUD.dismiss(withDelay: 4)
                    return false
                }
                
                if !(txtEmail.text?.trim().validaCorreo())! {
                    SVProgressHUD.showError(withStatus: .FormatoCorreoInvalido)
                    SVProgressHUD.dismiss(withDelay: 4)
                    return false
                }
                
                if txtEmail.text?.trim() != txtEmailConfirm.text?.trim(){
                    SVProgressHUD.showError(withStatus: .LosCorreosNoCoinciden)
                    SVProgressHUD.dismiss(withDelay: 4)
                    return false
                }
                
                return valido
                
            }
            
            // MARK: - Textos
            func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                siguienteCampo(textField: textField)
                
                return true
            }
            
            func siguienteCampo(textField:UITextField ){
                if (self.view.viewWithTag(textField.tag + 1) != nil)   {
                    let txt = self.view.viewWithTag(textField.tag + 1) as! UITextField
                    txt.becomeFirstResponder()
                } else {
                    self.view.endEditing(true)
                }
            }
            
            // MARK: - Scroll
           
            
            override func viewWillAppear(_ animated: Bool) {
                // Do any additional setup after loading the view.
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(self.keyboardWillShow(notification:)),
                                                       name: NSNotification.Name.UIKeyboardWillShow, object: nil)
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(self.keyboardWillHide(notification:)),
                                                       name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            }
            
            @objc func keyboardWillShow(notification: NSNotification) {
                guard let userInfo = notification.userInfo,
                    let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue )?.cgRectValue else{
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
            
            

            /*
            // MARK: - Navigation

            // In a storyboard-based application, you will often want to do a little preparation before navigation
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // Get the new view controller using segue.destinationViewController.
                // Pass the selected object to the new view controller.
            }
            */

        }
