//
//  RenewMembershipVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/16/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class RenewMembershipVC: UIViewController {

    @IBOutlet weak var vieWS: UIView!
    @IBOutlet weak var viewFb: UIView!
    @IBOutlet weak var viewTel: UIView!
    
    @IBOutlet weak var lblAcountNumber: UILabel!
    @IBOutlet weak var lblCodeAcount: UILabel!
    @IBOutlet weak var lblNameBank: UILabel!
    @IBOutlet weak var lblCreditType: UILabel!
    @IBOutlet weak var imgBank: UIImageView!
    
    //Colombia vars
    @IBOutlet weak var lblName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configScreen()
        self.setData()
        // Do any additional setup after loading the view.
    }
    
    private func setData() {
        lblAcountNumber.text = Singleton.instance.business.numera_cuenta
        lblCodeAcount.text = Singleton.instance.business.numero_cuenta_interbancario
        lblNameBank.text = Singleton.instance.business.banco_pago
    }
    
    private func setDataPeru() {
        
        lblCreditType.text = Singleton.instance.business.tipo_cuenta
        
        if let urlB : String = Singleton.instance.business.ruta_logo_banco {
            imgBank.imageFromServerURL(urlString: urlB, defaultImage: #imageLiteral(resourceName: "ic_bcp"))
        }
    }
    
    private func setDataColombia() {
    
    }
    
    
    @IBAction func call(_ sender: Any) {
        if let tel : String = Singleton.instance.business.telefono {
            Util.llamar(tel: tel, viewController: self)
        } else {
            Util().enviarAlerta(mensaje: "No disponible por el momento", titulo: "", controller: self)
        }
    }
        
    @IBAction func whatsapp(_ sender: Any) {
        if let ws : String = Singleton.instance.business.whatsapp {
            Util.openWhatsapp(number: ws.trim())
        } else {
            Util().enviarAlerta(mensaje: "No disponible por el momento", titulo: "", controller: self)
        }
    }
    
    @IBAction func facebook(_ sender: Any) {
        if let fb : String = Singleton.instance.business.facebook {
            Util.openFB(idFacebook: fb.trim())
        } else {
            Util().enviarAlerta(mensaje: "No disponible por el momento", titulo: "", controller: self)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func configScreen() {
        switch Api.config_app {
        case .Colombia:
            vieWS.cornerRadius = CGFloat(vieWS.frame.width / 2)
            viewFb.cornerRadius = CGFloat(viewFb.frame.width / 2)
            viewTel.cornerRadius = CGFloat(viewTel.frame.width / 2)
            vieWS.borderWidth = 2
            viewTel.borderWidth = 2
            viewFb.borderWidth = 2
            self.setDataColombia()
        case .Peru:
            print("Peru config")
            self.setDataPeru()
        case .Mexico:
            viewTel.roundView(porsion: 20)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
