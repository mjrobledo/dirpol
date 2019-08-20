//
//  ViewController.swift
//  dirpol
//
//  Created by Miguel Robledo on 14/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == strSegue.RecuperaUsuario {
            let vc = segue.destination as! RecuperarVC
            vc.texto = .NoRecueraTuUsuario
        }
    }
    

}



