//
//  ViewRegionesMapa.swift
//  dirpol
//
//  Created by macbook on 19/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import GoogleMaps
import SVProgressHUD

protocol regionesDelegate {
    func regionSeleccionada(region:Region)
}

var regiones:[Region] = []

class ViewRegionesMapa: UIView, GMSMapViewDelegate {

    var delegateRegiones:regionesDelegate!
    
    @IBOutlet weak var viewMapa: GMSMapView!
    
    var markers:[GMSMarker] = []
    func iniciar(){
        //,
        //regiones = Region().getRegionesDummies()
        
        let camera = GMSCameraPosition.camera(withLatitude: -10.256319, longitude: -75.332631, zoom: 5.0)
       
        //let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: nil)
        
       // viewMapa = mapView
        viewMapa.camera = camera
        // Creates a marker in the center of the map.
        
        if regiones.count == 0{
            SVProgressHUD.show()
            Servicios().getRegiones(completion: { region in
                SVProgressHUD.dismiss()
                if region != nil {
                    regiones = region!
                    self.addMarker()
                }else{
                    self.addMarker()
                }
            })
            viewMapa.delegate = self
        }
    }
    
    func addMarker(){
         
        for r in regiones {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: r.Latitud, longitude: r.Longitud)
            marker.map = viewMapa
            marker.icon =  #imageLiteral(resourceName: "ic_marker_region") //GMSMarker.markerImage(with: UIColor.cPrincipal())
            marker.zIndex = Int32(r.Id);
            markers.append(marker)
        }
    }
    

    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let r = regiones.first(where: {$0.Id == marker.zIndex } )
        
        let viewFromNib: ViewMarcker! = Bundle.main.loadNibNamed("ViewMarcker",
                                                            owner: nil,
                                                            options: nil)?.first as! ViewMarcker
        let name = String(utf8String: (r?.Nombre.cString(using: .utf8)!)!)
        viewFromNib?.lblRegion.text = name
        
        return viewFromNib
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        print("tap infowindows \(marker.zIndex)")
        
        let r = regiones.first(where: {$0.Id == marker.zIndex } )
        if (delegateRegiones != nil){
            if r != nil{
                self.delegateRegiones.regionSeleccionada(region: r!)
            }else{
                print("No se encontro esa región")
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
    }
    
    
    /*required init?(coder aDecoder: NSCoder) {
       
    }*/
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
 

}
