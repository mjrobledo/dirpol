//
//  ViewController.swift
//  CardViewAnimation
//
//  Created by Brian Advent on 26.10.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit
import GoogleMaps

class MapDetailVC: UIViewController {

    @IBOutlet weak var viewMap: GMSMapView!
    enum CardState {
        case expanded
        case collapsed
    }
    
    var cardViewController:CardViewController!
    var visualEffectView:UIVisualEffectView!
    
    var cardHeight:CGFloat = 600
    let cardHandleAreaHeight:CGFloat = 65
    
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    override func viewDidLoad() {
       super.viewDidLoad()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        if cardViewController == nil {
            self.setupCard()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueRepresentative" {
        let svc = segue.destination as! OfficialsVC
            svc.setPopPup()
        }
    }
    
}

extension UIViewController  {
    func setPopPup() {
        self.providesPresentationContextTransitionStyle = true;
        self.definesPresentationContext = true;
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }
}
