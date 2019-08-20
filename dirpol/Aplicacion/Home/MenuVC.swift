//
//  MenuVC.swift
//  dirpol
//
//  Created by macbook on 18/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit

protocol segueMenu {
    func abrirMenu(segue:String)
    
}

class MenuVC: UIViewController , UITableViewDelegate, UITableViewDataSource {
    var idDelegate:segueMenu!
    
    var menu:[clsMenu] = []

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = menu[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = item.Nombre
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = menu[indexPath.row]
        
        self.idDelegate.abrirMenu(segue: item.Delegado)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

    @IBOutlet weak var tblMenu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = clsMenu().getMenuPrincipal()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func volver(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class  clsMenu {
    var Nombre:String = ""
    var Imagen:UIImage = #imageLiteral(resourceName: "ic_divisiones")
    var Delegado:String = ""
    
    init() {
        
    }
    init(nombre:String, imagen:UIImage, delegado:String) {
        self.Nombre = nombre
        self.Imagen = imagen
        self.Delegado = delegado
    }
    
    
    func  getMenuPrincipal() -> [clsMenu]{
      
        let menuAr:[clsMenu] = [
            clsMenu(nombre: .BusquedaAvanzada, imagen: #imageLiteral(resourceName: "ic_divisiones"), delegado: strSegue.Busqueda),
            clsMenu(nombre: .AltoMandoPolicial, imagen: #imageLiteral(resourceName: "ic_divisiones"), delegado: strSegue.Altomando),
            clsMenu(nombre: .PanelUsuario, imagen: #imageLiteral(resourceName: "ic_divisiones"), delegado: strSegue.Panel),
            clsMenu(nombre: .AcercaDe, imagen: #imageLiteral(resourceName: "ic_divisiones"), delegado: strSegue.AcercaDe),
            clsMenu(nombre: .CerrarSesion, imagen: #imageLiteral(resourceName: "ic_divisiones"), delegado: strSegue.Cerrar)
                                ]
        return menuAr
  
    }
}

struct strSegue {
    static let Cerrar = "segueCerrar"
    
    static let Busqueda = "segueBusqueda"
    static let Altomando = "segueAltomando"
    static let Panel = "seguePanel"
    static let AcercaDe = "segueAcercaDe"
    
    static let Menu = "segueMenu"
    static let Listado = "segueListado"
    
    static let Contacto = "segueContacto"
    
    static let Detalle = "segueDetalle"
    
    static let RecuperaUsuario = "segueResuperaUsuario"
    static let RecuperaPassword = "segueResuperaPassword"
    
    static let DetalleBAvanzada = "segueBusquedaAvanzada"
    
    
}

