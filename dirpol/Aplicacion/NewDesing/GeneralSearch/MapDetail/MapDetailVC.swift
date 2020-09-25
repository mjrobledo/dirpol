//
//  ViewController.swift
//  CardViewAnimation
//
//  Created by Brian Advent on 26.10.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit
import GoogleMaps
import SVProgressHUD

class MapDetailVC: UIViewController {

    @IBOutlet weak var viewMap: GMSMapView!
    enum CardState {
        case expanded
        case collapsed
    }
    
    var entityID: String!
    
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
    
    let locationManager = CLLocationManager()
    let didFindMyLocation = false
    
    private var latitude : Double = 0, longitude : Double = 0
    private var entityM : EntityM!
    override func viewDidLoad() {
       super.viewDidLoad()
        
     }
    
    private func getEntityDetail() {
        SVProgressHUD.show()
        Singleton.instance.services.getEntityDetailM(entidad_id: entityID!) { (response) in
            SVProgressHUD.dismiss()
            if response != nil && response?.data != nil && response?.status == 200 {
                self.entityM = response?.data
                if let descrip = response?.data?.tipos_entidad?.descripcion {
                    self.cardViewController.typeEntity = descrip
                }
                if let descrip = response?.data?.descripcion {
                    self.cardViewController.division =  descrip
                }
                
                if  let entity = response?.data?.entidad_sedes?.filter( { $0.principal == 1 }).first {
                    self.cardViewController.entity = entity
                    self.cardViewController.configForm()
                    if let lat = Double((entity.latitud)!) {
                        let lng = Double((entity.longitud)!)
                        DispatchQueue.main.async {
                         self.addMarker(latitude: lat , longitude: lng!)
                        }
                    }
                }
                
                self.cardViewController.table.reloadData()
                print(response)
            }
        }
    }
    
    private func addMarker(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 5.0)
        viewMap.camera = camera
        viewMap.delegate = self
        viewMap.isMyLocationEnabled = true
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.map = viewMap
        marker.icon =  #imageLiteral(resourceName: "ic_marker_red") //GMSMarker.markerImage(with: UIColor.cPrincipal())
        
        locationManager.requestAlwaysAuthorization()

        //marker.zIndex = Int32(r.Id);
        viewMap.selectedMarker = marker
    }
        
    @IBAction func setLocation(_ sender: Any) {
        //if locationManager != nil {
        let camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 5.0)
        viewMap.camera = camera
       // }
    }
    
    @IBAction func setRute(_ sender: Any) {
        
        let urlMaps =  URL(string: "comgooglemaps://?saddr=&daddr=\(self.latitude),\(self.longitude)&directionsmode=driving")
        
        if UIApplication.shared.canOpenURL(urlMaps!) {
            UIApplication.shared.open(urlMaps!, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        } else {
            
        }
         
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if cardViewController == nil {
            self.setupCard()
            self.getEntityDetail()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueRepresentative" {
        let svc = segue.destination as! OfficialsVC
            svc.setPopPup()
            svc.people = sender as? EntidadPersonal
        } else if segue.identifier == "seguePhotos" {
            let ph = sender as! [EntidadSedeFoto]
            let svc = segue.destination as! GalleryVC
            svc.typeEntity = cardViewController.typeEntity
            svc.division = cardViewController.division
            svc.photos = ph
        }
    }
    
}

extension MapDetailVC: GMSMapViewDelegate, CLLocationManagerDelegate{
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
          //let r = regiones.first(where: {$0.Id == marker.zIndex } )
          
        let viewFromNib: ViewMarker! = (Bundle.main.loadNibNamed("ViewMarker",
                                                                 owner: nil,
                                                                 options: nil)?.first as! ViewMarker)
          //let name = String(utf8String: (r?.Nombre.cString(using: .utf8)!)!)
        viewFromNib?.lblRegion.text = self.cardViewController.typeEntity
          //Variables.region = name!
          return viewFromNib
      }
      
      
      func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
          print("tap infowindows \(marker.zIndex)")
          
         // let r = regiones.first(where: {$0.Id == marker.zIndex } )
           
      }
      
      func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
          print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
      }
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            //mapView.myLocationEnabled = true
            //mapView.settings.myLocationButton = true
        }
    }
       
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            viewMap.camera = GMSCameraPosition(target: locations.first!.coordinate, zoom: 20, bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
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
