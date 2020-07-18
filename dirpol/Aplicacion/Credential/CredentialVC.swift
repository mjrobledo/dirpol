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
      
      override func viewDidLoad() {
          super.viewDidLoad()
          if revealViewController() != nil {
              btnMenu.target = revealViewController()
              btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
              view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
          }
        // Do any additional setup after loading the view.
    }
    
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueRenew" {
            let svc = segue.destination as! RenewMembershipVC
            svc.providesPresentationContextTransitionStyle = true;
            svc.definesPresentationContext = true;
            svc.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
        }
    }
}
