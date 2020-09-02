//
//  HomeVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/14/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var viewMenuCo: UIView!
    @IBOutlet weak var viewMenuPe: UIView!
    
    @IBOutlet weak var btnRegion: UIButton!
    @IBOutlet weak var btnDirectory: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnPanel: UIButton!
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    @IBOutlet weak var imgBackground: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            btnMenu.target = revealViewController()
            btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
                
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        self.view.addGestureRecognizer(tap1)
        self.configScreen()
        // Do any additional setup after loading the view.
    }
    
    private func configScreen(){
        switch Api.config_app {
        case .Colombia:
            imgBackground.image = #imageLiteral(resourceName: "img_bacground_co")
            viewMenuCo.isHidden = false
            viewMenuPe.isHidden = true
            btnMenu.tintColor = .cYelowCo()
        case .Peru:
            imgBackground.image = UIImage(named: "img_login")
            btnMenu.tintColor = .cGreenPe()
        case .Mexico:
            imgBackground.image = UIImage(named: "img_login")
        }
    }

    @objc func hideKeyBoard(){
        self.view.endEditing(true)
    }

    @IBAction func goToAdvancedSearch(_ sender: Any) {
       /* if Singleton.instance.menuTable == nil {
            self.revealViewController().revealToggle(animated: false)
        }
        MenuLeftVC.changedMenu(menu: 2)
        self.revealViewController().revealToggle(animated: false)
        */
    }
    
    @IBAction func goToRegions(_ sender: Any) {
        
    }
    
    @IBAction func goToDirectory(_ sender: Any) {
        /*if Singleton.instance.menuTable == nil {
            self.revealViewController().revealToggle(animated: true)
        }
        MenuLeftVC.changedMenu(menu: 3)
        self.revealViewController().revealToggle(animated: false)
        */
    }
    
    @IBAction func goToPanel(_ sender: Any) {
        /*if Singleton.instance.menuTable == nil {
            self.revealViewController().revealToggle(animated: false)
        }
        MenuLeftVC.changedMenu(menu: 6)
        self.revealViewController().revealToggle(animated: false)*/
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.hideKeyBoard()
        return true
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
