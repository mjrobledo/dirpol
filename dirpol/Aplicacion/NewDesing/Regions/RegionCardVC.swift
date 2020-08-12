//
//  CardViewController.swift
//  CardViewAnimation
//
//  Created by Brian Advent on 26.10.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit

protocol RegionCardVCDelegate {
    func filter()
    func goToProvince()
    func goToCity()
    func goToDistrito()
}

class RegionCardVC: UIViewController {

    var delegate: RegionCardVCDelegate!
    
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var txtDepto: UITextField!
    @IBOutlet weak var txtProvincia: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtDistrito: UITextField!
 
     /*
    override func viewDidLoad() {
        self.viewDidLoad()
        
    }*/
    
    @IBAction func filter(_ sender: Any) {
        if delegate != nil {
            self.delegate.filter()
        }
    }
    
    @IBAction func goToProvince(_ sender: Any) {
        self.delegate.goToProvince()
    }
    
    @IBAction func goToCity(_ sender: Any) {
        self.delegate.goToCity()
    }
    
    @IBAction func goToDistrito(_ sender: Any) {
        self.delegate.goToDistrito()
    }
    
    
    
}
