//
//  RegionsVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/18/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import GoogleMaps

class RegionsVC: UIViewController {
    enum CardState {
        case expanded
        case collapsed
    }

     @IBOutlet weak var viewMap: GMSMapView!
     @IBOutlet weak var btnMenu: UIBarButtonItem!

    var regionCard: RegionCardVC!
    var visualEffectView: UIVisualEffectView!

    var marker:[GMSMarker] = []

    var cardHeight:CGFloat = 400
    let cardHandleAreaHeight:CGFloat = 65

    var cardVisible = false
    private var labelDepto = ""
    
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }

    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0

       override func viewDidLoad() {
              super.viewDidLoad()
              if revealViewController() != nil {
                  btnMenu.target = revealViewController()
                  btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
                  view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
              }

        viewMap.camera = GMSCameraPosition(latitude: -10.190200, longitude: -75.538139, zoom: 6)
        viewMap.delegate = self
        /*
         -10.190200, -75.538139
         */
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -16.355114, longitude: -71.540182)
        marker.title = "Arequipa"
        marker.snippet = "Peru"
        marker.map = viewMap
        marker.iconView = UIImageView(image: UIImage(named: "ic_marker_region"))
        //marker.setValue("1", forKey: "id")

        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: -9.800696, longitude: -76.175346)
        marker2.iconView = UIImageView(image: UIImage(named: "ic_marker_red"))
        marker2.title = "Huánuco"
        marker2.snippet = "Peru"
        //marker.setValue("2", forKey: "id")
        marker2.map = viewMap
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if regionCard == nil {
            setupCard()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueProvince" {
            let vc = segue.destination as! ProvincesVC
            vc.depto = self.labelDepto
        } else  if segue.identifier == "segueList" {
            let vc = segue.destination as! ListVC
            vc.setPopPup()
        }
    }
    

}

extension RegionsVC: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.labelDepto = marker.title!
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "segueProvince", sender: nil)
        }
        
        return false // return false to display info window
    }
}
 
