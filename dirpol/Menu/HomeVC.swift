//
//  HomeVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/14/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var btnRegion: UIButton!
    @IBOutlet weak var btnDirectory: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnPanel: UIButton!
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            btnMenu.target = revealViewController()
            btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
                
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        self.view.addGestureRecognizer(tap1)

        // Do any additional setup after loading the view.
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
