//
//  AdvanceSearchVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/18/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class AdvanceSearchVC: UIViewController {

    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var btnFirefighter: UIButton!
    @IBOutlet weak var btnPolice: UIButton!
    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var btnSerenazo: UIButton!
    
    @IBOutlet weak var lblFirefighter: UILabel!
    @IBOutlet weak var lblPolice: UILabel!
    @IBOutlet weak var lblHospital: UILabel!
    @IBOutlet weak var lblSerenazo: UILabel!
    
    @IBOutlet weak var imgFirefighter: UIImageView!
    @IBOutlet weak var imgPolice: UIImageView!
    @IBOutlet weak var imgHospital: UIImageView!
    @IBOutlet weak var imgSerenazo: UIImageView!
    
    @IBOutlet weak var btnDepto: UIButton!
    @IBOutlet weak var btnProvince: UIButton!
    @IBOutlet weak var btnDitrict: UIButton!
    @IBOutlet weak var btnCity: UIButton!
    @IBOutlet weak var btnPostion: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            btnMenu.target = revealViewController()
            btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectedList(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueList", sender: nil)
    }
    
    @IBAction func selectedType(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        switch sender {
        case btnFirefighter:
            lblFirefighter.textColor = sender.isSelected ? UIColor.white : UIColor.darkGray
            imgFirefighter.tintColor = sender.isSelected ? UIColor.white : UIColor.cPrincipal()
        case btnPolice:
            lblPolice.textColor = sender.isSelected ? UIColor.white : UIColor.darkGray
            imgPolice.tintColor = sender.isSelected ? UIColor.white : UIColor.cPrincipal()
        case btnHospital:
            lblHospital.textColor = sender.isSelected ? UIColor.white : UIColor.darkGray
            imgHospital.tintColor = sender.isSelected ? UIColor.white : UIColor.cPrincipal()
        case btnSerenazo:
            lblSerenazo.textColor = sender.isSelected ? UIColor.white : UIColor.darkGray
            imgSerenazo.tintColor = sender.isSelected ? UIColor.white : UIColor.cPrincipal()
        default:
            print("")
        }
        
        sender.backgroundColor = sender.isSelected ? UIColor.cPrincipal() : UIColor.white
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueList" {
            let svc = segue.destination as! ListVC
            svc.providesPresentationContextTransitionStyle = true;
            svc.definesPresentationContext = true;
            svc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        }
    }

}
