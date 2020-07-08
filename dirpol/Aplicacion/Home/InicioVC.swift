//
//  InicioVC.swift
//  dirpol
//
//  Created by macbook on 18/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit

class InicioVC: UIViewController, segueMenu , MenuDelegate, busquedaDelegate, directorioDelegate, regionesDelegate, provInstitucionDelegate, busquedaDosDelegate{
    
    func institucionSeleccionada(institucion: Institucion) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: strSegue.Detalle, sender: institucion)
        }
    }
    
    func regionDosSeleccionado() {
        
    }
     

    @IBOutlet weak var btnVuelveRegion: UIButton!
    
    @IBOutlet weak var viewFrame: UIView!
    @IBOutlet weak var collMenu: CollMenu!
    
    
    @IBOutlet weak var viewTutorial: UIView!
    @IBOutlet var viewBusqueda: ViewBusquedaUno!
    @IBOutlet var viewDirectorio: ViewDirectorio!
    @IBOutlet var viewRegionMapa: ViewRegionesMapa!
    @IBOutlet var viewRegionProv: ViewProvInstitucion!
    @IBOutlet var viewBusquedaDos: ViewBusquedaDos!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(quitarAyuda))
        self.viewTutorial.addGestureRecognizer(tap1)
        
        collMenu.menu = ["Regiones","Búsqueda","Directorio"]
        collMenu.delegateMenu = self
        // Do any additional setup after loading the view.
        menuSeleccionado(index: 1)
        collMenu.menuSelec = 1
        
        viewRegionProv.delegateProvinciaInst = self
        viewRegionMapa.delegateRegiones = self
        viewBusquedaDos.delegateBusquedaDos = self
        viewDirectorio.delegateDirectorio = self
    }
    
    
    
    @objc private func OcultarTeclado(){
        self.viewBusqueda.endEditing(true)
    }
    @objc private func quitarAyuda(){
        self.viewTutorial.removeFromSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    func menuSeleccionado(index: Int) {
        strucSubMenu.Activo = index
        
        self.view.endEditing(true)
        switch index {
        case strucSubMenu.Region:
            btnVuelveRegion.isHidden = true
            switch strucSubMenu.MenuRegion {
                case strucSubMenu.RegionMapa:
                    self.viewRegionMapa.frame = CGRect(x: 0, y: 0, width: viewFrame.frame.width, height: viewFrame.frame.height)
                    self.viewFrame.addSubview(viewRegionMapa)
                    viewBusqueda.removeFromSuperview()
                    viewDirectorio.removeFromSuperview()
                    viewRegionProv.removeFromSuperview()
                    
                    DispatchQueue.main.async {
                        self.viewRegionMapa.iniciar()
                    }
                case strucSubMenu.RegionProvincia:
                        btnVuelveRegion.isHidden = false
                        self.viewRegionProv.frame = CGRect(x: 0, y: 0, width: viewFrame.frame.width, height: viewFrame.frame.height)
                        self.viewFrame.addSubview(viewRegionProv)
                        
                        viewRegionMapa.removeFromSuperview()
                        viewBusqueda.removeFromSuperview()
                        viewDirectorio.removeFromSuperview()
                        DispatchQueue.main.async {
                            self.viewRegionProv.iniciar()
                        }
                
            default:
                print("Prueba")
            }
            
        case strucSubMenu.Busqueda:
            
            switch strVBusqueda.ventanaAbierta {
            case strVBusqueda.VistaBusquedaGoogle:
                strVBusqueda.ventanaAbierta = strVBusqueda.VistaBusquedaGoogle
                btnVuelveRegion.isHidden = true
                self.viewBusqueda.frame = CGRect(x: 0, y: 0, width: viewFrame.frame.width, height: viewFrame.frame.height)
                self.viewBusqueda.delegateBusqueda = self
                self.viewFrame.addSubview(viewBusqueda)
                    
                viewRegionMapa.removeFromSuperview()
                viewDirectorio.removeFromSuperview()
                DispatchQueue.main.async {
                    self.viewBusqueda.iniciar()
                }
            case strVBusqueda.VistaBusquedaCompleta :
                self.busquedaCompleta(texto: "")
            default:
                print("busqueda non")
            }
            
        case strucSubMenu.Directorio:
            btnVuelveRegion.isHidden = true
            self.viewDirectorio.frame = CGRect(x: 0, y: 0, width: viewFrame.frame.width, height: viewFrame.frame.height)
            self.viewDirectorio.delegateDirectorio = self
            self.viewFrame.addSubview(viewDirectorio)
            
            viewRegionMapa.removeFromSuperview()
            viewBusqueda.removeFromSuperview()
            DispatchQueue.main.async {
                self.viewDirectorio.iniciar()
            }
            
        default:
            print("menu x")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func abirContacto(_ sender: Any) {
        self.performSegue(withIdentifier: strSegue.Contacto, sender: nil)
    }
    
    
    
    @IBAction func abirMenu(_ sender: Any) {
        self.performSegue(withIdentifier: strSegue.Menu, sender: nil)
    }
    
    
    // MARK: - Delegados de Regiones
    //Se llama cuando viene desde el View de Regiones marker
    //Se selecciona
    func regionSeleccionada(region: Region) {
        viewRegionProv.region = region
        Variables.region = region.Nombre
        strucSubMenu.MenuRegion = strucSubMenu.RegionProvincia
        strVRegion.ventanaAbierta = strVRegion.VistaProvincia
        
        menuSeleccionado(index: 0)
    }
    
    func volverARegionMapa() {
        strucSubMenu.MenuRegion = strucSubMenu.RegionMapa
        menuSeleccionado(index: 0)
    }
    
    
    // MARK: - Metodos de vista
    
    func abrirMenu(segue: String) {
        switch segue {
        case strSegue.Cerrar:
            self.alertCerrarSesion()
        default:
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: segue, sender: nil)
            }
        }
    }
    
    
    //Cerrar sesion
    func alertCerrarSesion() {
        
        let alertController = UIAlertController(title: .CerrarSesion , message: .AlertaSesion, preferredStyle: UIAlertControllerStyle.alert)
        let siAction = UIAlertAction(title: .CERRARSESION, style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            DispatchQueue.main.async {
                strucSubMenu.Activo = strucSubMenu.Busqueda
                self.dismiss(animated: true, completion: nil)
            }
        }
        let noAction = UIAlertAction(title: .Cancelar, style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            DispatchQueue.main.async {
            }
        }
        
        alertController.addAction(siAction)
        alertController.addAction(noAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Delegados de directorio
    func directorioSeleccionado(institucion: Institucion) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: strSegue.Detalle, sender: institucion)
        }
    }
    
    // MARK: - Delegados de busqueda
    func busquedaCompleta(texto: String) {
        btnVuelveRegion.isHidden = false
        strVBusqueda.ventanaAbierta = strVBusqueda.VistaBusquedaCompleta
        UIView.animate(withDuration: 2, animations: {
            self.viewBusquedaDos.frame = CGRect(x: 0, y: 0, width: self.self.viewFrame.frame.width, height: self.viewFrame.frame.height)
            if !texto.isEmpty {
                self.viewBusquedaDos.txtBusqueda.text = texto
            }
            self.viewBusquedaDos.iniciar(texto: texto)
            self.viewFrame.addSubview(self.viewBusquedaDos)
           
            self.viewBusqueda.removeFromSuperview()
        }, completion: nil)
    }
    
    func verDetalleBusqueda(text: String) {
        DispatchQueue.main.async {
            Variables.region = ""
            Variables.provincia = ""
            self.busquedaCompleta(texto: text)
        }
    }
    
    func verDetalleBusqueda(institucion: Institucion) {
        DispatchQueue.main.async {
            Variables.region = ""
            Variables.provincia = ""
            //self.performSegue(withIdentifier: strSegue.Detalle, sender: institucion)
            self.busquedaCompleta(texto: institucion.NombreFuncionario)
        }
    }
    
    func volverBusquedaUno() {
        strVBusqueda.ventanaAbierta = strVBusqueda.VistaBusquedaGoogle
        UIView.animate(withDuration: 2, animations: {
            self.btnVuelveRegion.isHidden = true
            self.viewBusqueda.frame = CGRect(x: 0, y: 0, width: self.self.viewFrame.frame.width, height: self.viewFrame.frame.height)
            self.viewFrame.addSubview(self.viewBusqueda)
            self.viewBusquedaDos.removeFromSuperview()
        }, completion: nil)
    }
    
    func busquedaDosSeleccionado(institucion: Institucion) {
        DispatchQueue.main.async {
            Variables.region = ""
            Variables.provincia = ""
            self.performSegue(withIdentifier: strSegue.Detalle, sender: institucion)
        }
    }
    // MARK: - Botones
    // Si esta en instituciones regresa a Provincia
    // Si esta en provincia regresa a instituciones
    @IBAction func volverARegionProvincia(_ sender: Any) {
        if strucSubMenu.Activo == strucSubMenu.Region{
            viewRegionProv.txtBuscar.text = ""
            if strVRegion.ventanaAbierta == strVRegion.VistaInstitucion{
                strVRegion.ventanaAbierta = strVRegion.VistaProvincia
                viewRegionProv.setTitulo()
                viewRegionProv.imgUbicacion.isHidden = true
                viewRegionProv.bntFlechaBuscar.isHidden = false
                viewRegionProv.iniciar()
                viewRegionProv.tabla.reloadData()
            }else{
                viewRegionProv.provincias = []
                self.volverARegionMapa()
            }
        }else{
            if strucSubMenu.Activo == strucSubMenu.Busqueda{
                //
                if strVBusqueda.ventanaAbierta == strVBusqueda.VistaBusquedaCompleta{
                    self.volverBusquedaUno()
                }else{
                    
                }
            }
        }
    }
    
    @IBAction func regresaHome(_ sender : UIStoryboardSegue){
        menuSeleccionado(index: 1)
        collMenu.menuSelec = 1
        collMenu.reloadData()
        viewBusqueda.reiniciar()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == strSegue.Menu{
            let svc = segue.destination as! MenuVC
            svc.idDelegate = self
            svc.providesPresentationContextTransitionStyle = true;
            svc.definesPresentationContext = true;
            svc.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
        }else{
            if segue.identifier == strSegue.Detalle {
                let svc = segue.destination as! DetalleBusquedaVC
                let inst:Institucion = sender as! Institucion
                svc.institucion = inst
            }
        }
        
    }
    

}
//Mantiene el control del submenu principal InicioVC (Region , Busqueda, Directorio)
struct strucSubMenu {
    static var Activo = 1
    
    static let Region = 0
    static let Busqueda = 1
    static let Directorio = 2
    
    static let RegionMapa = 1
    static let RegionProvincia = 2
    static let RegionDetalle = 3
    
    static var MenuRegion = 1
}
