//
//  AboutUS.swift
//  dirpol
//
//  Created by Developer iOS on 7/18/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class AboutUS: UIViewController {

    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var txtAbout: UITextView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
        btnMenu.colorMenu()
           if revealViewController() != nil {
               btnMenu.target = revealViewController()
               btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
               view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
           }
        // Do any additional setup after loading the view.
        
        if let text : String = Singleton.instance.business.acerca_de {
            txtAbout.text = text.trim()
            
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
