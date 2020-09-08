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
    @IBOutlet weak var txtNaturalLegalPerson: UITextField!
   // @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPasswordConfirm: UITextField!
    @IBOutlet weak var txtEmailConfirm: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var viewConfirmPassword: UIView!
    
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var btnPassword: UIButton!
    
    @IBOutlet weak var imgSelect: UIImageView!
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        viewPassword.isHidden = true
        viewConfirmPassword.isHidden = true
        
        btnMenu.colorMenu()
              if revealViewController() != nil {
                  btnMenu.target = revealViewController()
                  btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
                  view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
              }

        // Do any additional setup after loading the view.
      let tap1 = UITapGestureRecognizer(target: self, action: #selector(OcultarTeclado))
                self.viewFrame.addGestureRecognizer(tap1)
                
                // Do any additional setup after loading the view.
                //self.llenarVista()
        self.loadData()
            }

    private func llenarVista(){
        txtUser.text = Variables.Perfil.Nombre
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
            
    private func loadData() {
        txtNaturalLegalPerson.text = Singleton.instance.user.razon_social
        txtUser.text = Singleton.instance.user.usuario
        txtEmail.text = Singleton.instance.user.email
        txtEmailConfirm.text = Singleton.instance.user.email
    }
            
    @IBAction func changedPassword(_ sender: UIButton) {
        if sender.tag == 0 {
            imgSelect.image = #imageLiteral(resourceName: "ic_check_on-1")
            sender.tag = 1
            viewPassword.isHidden = false
            viewConfirmPassword.isHidden = false
        } else {
            imgSelect.image = #imageLiteral(resourceName: "ic_round")
            sender.tag = 0
            viewPassword.isHidden = true
            viewConfirmPassword.isHidden = true
        }
    }
    
    @IBAction func guardaUsuario(_ sender: Any) {
        self.view.endEditing(true)
        if validaCampos(){
            var us:RequestPanel = RequestPanel()
            us.email = (txtEmail.text?.trim())!
            us.email_confirmation = (txtEmailConfirm.text?.trim())!
            if btnPassword.tag == 1 {
                us.cambiar_password = 1
                us.password = (txtPassword.text?.trim())!
                us.password_confirmation = (txtPasswordConfirm.text?.trim())!
            }
                    
            SVProgressHUD.show()
            Singleton.instance.services.setUserPanel(request: us) { (response) in
                if response != nil && !(response?.message.isEmpty)! {
                    SVProgressHUD.showSuccess(withStatus: "Exito")
                    SVProgressHUD.dismiss(withDelay: 3)
                    Singleton.instance.user.email = us.email
                } else {
                    SVProgressHUD.showError(withStatus: .ErrorEnElServicio)
                        SVProgressHUD.dismiss(withDelay: 3)
                    }
                }
            }
    }
            
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
    }
            
    private func validaCampos() -> Bool{
        var valido = true
    
        if btnPassword.tag == 1 {
            if txtPassword.text?.trim() != txtPasswordConfirm.text?.trim(){
                SVProgressHUD.showError(withStatus: .LasContrasenasNoCoinciden)
                SVProgressHUD.dismiss(withDelay: 4)
                return false
            }
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
                                                       name: UIResponder.keyboardWillShowNotification,
                                                       object: nil)
        
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
            
            

            /*
            // MARK: - Navigation

            // In a storyboard-based application, you will often want to do a little preparation before navigation
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // Get the new view controller using segue.destinationViewController.
                // Pass the selected object to the new view controller.
            }
            */

    }
