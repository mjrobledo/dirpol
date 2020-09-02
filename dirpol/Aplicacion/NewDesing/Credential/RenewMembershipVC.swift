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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configScreen()
        // Do any additional setup after loading the view.
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
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func configScreen() {
        switch Api.config_app {
        case .Colombia:
            vieWS.cornerRadius = CGFloat(vieWS.frame.width / 2)
            viewFb.cornerRadius = CGFloat(vieWS.frame.width / 2)
            viewTel.cornerRadius = CGFloat(vieWS.frame.width / 2)
            vieWS.borderWidth = 2
            viewTel.borderWidth = 2
            viewFb.borderWidth = 2
        case .Peru:
            viewTel.roundView(porsion: 20)
            viewFb.roundView(porsion: 20)
            viewTel.roundView(porsion: 20)
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
