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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.colorMenu()
          if revealViewController() != nil {
              btnMenu.target = revealViewController()
              btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
              view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
          }
        
        viewRenew.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func show(_ sender: Any) {
        self.viewRenew.isHidden = false
    }
    
    @IBAction func hide(_ sender: Any) {
        self.viewRenew.isHidden = true
    }
    
    @IBAction func showCredential(_ sender: Any) {
        
        let viewController = UIViewController(nibName: "CredentialImageVC", bundle: nil)
        self.present(viewController, animated: true, completion: nil)
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
    }
}
