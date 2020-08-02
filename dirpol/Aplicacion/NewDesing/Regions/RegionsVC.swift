//
//  RegionsVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/18/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class RegionsVC: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
