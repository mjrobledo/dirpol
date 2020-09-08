//
//  CredentialVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/16/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class CredentialVC: UIViewController {

     @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var viewRenew: UIView!
    @IBOutlet weak var btnRenew: UIButton!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBussiness: UILabel!
    @IBOutlet weak var lblDateExpedition: UILabel!
    @IBOutlet weak var lblDateExpired: UILabel!
    
    @IBOutlet weak var lblAlertExpired: UILabel!
    
    @IBOutlet weak var imgCredential: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.colorMenu()
          if revealViewController() != nil {
              btnMenu.target = revealViewController()
              btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
              view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
          }
        self.loadForm()
        //viewRenew.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    private func loadForm() {
        lblName.text = Singleton.instance.user.getName()
        lblBussiness.text = Singleton.instance.user.razon_social
        
        if !Singleton.instance.user.fecha_caducidad!.isEmpty {
            lblDateExpired.text = Singleton.instance.user.fecha_caducidad?.date.stringDDMMYYY
            let days = Util.getDays(startDate: Date(), endDate: Singleton.instance.user.fecha_caducidad!.date)
            if days! <= 28 {
                viewRenew.isHidden = false
                lblAlertExpired.text = "Su plan caducará en los próximos \((days)!) días"
            } else {
                viewRenew.isHidden = true
            }
            
        } else {
            lblDateExpired.text = "-"
        }
        
        if !Singleton.instance.user.fecha_alta!.isEmpty {
            lblDateExpedition.text = Singleton.instance.user.fecha_alta?.date.stringDDMMYYY
        } else {
            lblDateExpedition.text = "-"
        }
        
        imgCredential.imageFromServerURL(urlString: Singleton.instance.imgCredential, defaultImage: #imageLiteral(resourceName: "LOGO2"))
    }
    
    @IBAction func openDetail(_ sender: Any) {
        if  Api.config_app == .Colombia {
            self.performSegue(withIdentifier: "segueColombia", sender: nil)
        } else {
            self.performSegue(withIdentifier: "seguePeru", sender: nil)
        }
    }
    
    
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueColombia" ||  segue.identifier == "seguePeru"{
            let svc = segue.destination as! RenewMembershipVC
            svc.setPopPup()
        }
        if segue.identifier == "segueCredential" {
            let svc = segue.destination as! ImageZoomVC
            svc.imgArray.append(self.imgCredential.image!)
        }
    }
}
