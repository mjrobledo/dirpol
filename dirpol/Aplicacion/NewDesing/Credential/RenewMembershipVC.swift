//
//  RenewMembershipVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/16/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class RenewMembershipVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func call(_ sender: Any) {
        Utileria.llamar(tel: "+5115006000", viewController: self)
    }
        
    @IBAction func whatsapp(_ sender: Any) {
        Utileria.openWhatsapp()
    }
    
    @IBAction func facebook(_ sender: Any) {
        Utileria.openFB()
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
