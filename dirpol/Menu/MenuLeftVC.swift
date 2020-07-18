//
//  MenuVC.swift
//  Proyecto
//
//  Created by DESAPP-1 on 16/03/17.
//  Copyright © 2017 Lisyx. All rights reserved.
//

import UIKit

class MenuLeftVC: UIViewController, UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate {

    
    @IBOutlet weak var imgPerfil: UIImageView!
    
    @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var viewTop: UIView!
    
    
    var ar_Menu:[Menu] = Menu.getMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewTop.backgroundColor = UIColor.cPrincipal()
        // Do any additional setup after loading the view.
        
        tblMenu.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
       /* if Variable.usuario != nil {
            lblNombre.text = "\(Variable.usuario.nombre) \(Variable.usuario.apaterno) \(Variable.usuario.us_amaterno)"
            imgPerfil.image = #imageLiteral(resourceName: "H&M")
        }else{
            imgPerfil.image = #imageLiteral(resourceName: "H&M")
           lblNombre.text = "HYM"
        }*/
        /*
        if(Variable.menuLogin){
            ar_Menu = Constante.getMenuLogin()
        }else{
            ar_Menu = Constante.getSinLogin()
        }*/
        tblMenu.reloadData()
    }
    
    func revealControllerPanGestureBegan(_ revealController: SWRevealViewController!) {
        /*
        if(Variable.menuLogin){
            ar_Menu = Constante.getMenuLogin()
        }else{
            ar_Menu = Constante.getSinLogin()
        }*/
        tblMenu.reloadData()
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return ar_Menu.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu", for: indexPath) as! MenuCell
        
        let m = ar_Menu[indexPath.row]
        
        
        cell.lblTitulo.text = m.titulo.uppercased()
        cell.imgIcono.image =  m.imagen //.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        //cell.imgIcono.tintColor = UIColor.black
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        DispatchQueue.main.async {
            self.revealViewController().revealToggle(animated: true)
        }
        
        let m = ar_Menu[indexPath.row]
        if m.segue == .Exit {
            alertCerrarSesion()
        }else{
            performSegue(withIdentifier: m.segue.rawValue, sender: nil)
        }
    }
    

    func alertCerrarSesion() {
        
        let alertController = UIAlertController(title: .CerrarSesion , message: .AlertaSesion, preferredStyle: UIAlertController.Style.alert)
        let siAction = UIAlertAction(title: .Si, style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
            self.dismiss(animated: true, completion: nil)
        }
        
        let noAction = UIAlertAction(title: .No, style: UIAlertAction.Style.cancel) { (result : UIAlertAction) -> Void in
            DispatchQueue.main.async {
                self.revealViewController().revealToggle(animated: true)
            }
            
        }
        alertController.addAction(siAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    static func cambiaMenu(menu:Int)
    {
        let indexPath = IndexPath(row: menu, section: 0)
        //Variable.tablaMenu.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
      //  Variable.tablaMenu.delegate?.tableView!(Variable.tablaMenu, didSelectRowAt: indexPath)
        
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

class Menu {
    var titulo = ""
    var segue: Segue = .Exit
    var imagen = UIImage()
    init(titulo: String, segue: Segue, imagen: UIImage) {
        self.titulo = titulo
        self.segue = segue
        self.imagen = imagen
    }
    
    static func getMenu() -> [Menu] {
     
        return [Menu(titulo: "Inicio", segue: Segue.Home, imagen: #imageLiteral(resourceName: "ic_home")),
                Menu(titulo: "Regiones", segue: Segue.Region, imagen: #imageLiteral(resourceName: "menu_regions")),
                Menu(titulo: "Búsqueda Avanzada", segue: Segue.Search, imagen: #imageLiteral(resourceName: "menu_search")),
                Menu(titulo: "Directorio", segue: Segue.Directory, imagen: #imageLiteral(resourceName: "menu_directoty")),
                Menu(titulo: "Contáctanos", segue: Segue.Directory, imagen: #imageLiteral(resourceName: "menu_contac_us")),
                Menu(titulo: "Credencial Virtual", segue: Segue.Credential, imagen: #imageLiteral(resourceName: "menu_credential")),
                Menu(titulo: "Panel de Usuario", segue: Segue.Panel, imagen: #imageLiteral(resourceName: "menu_panel")),
                Menu(titulo: "Acerca de Dirpol", segue: Segue.About, imagen: #imageLiteral(resourceName: "menu_about")),
                Menu(titulo: "Salir", segue: Segue.Exit, imagen: #imageLiteral(resourceName: "menu_exit"))]
    }
}

enum Segue: String {
    case Home = "segueInicio"
    case Region = "segueRegion"
    case Search = "segueSearch"
    case Directory = "segueDirectory"
    case ContactUs = "segueContactUs"
    case Credential = "segueCredential"
    case Panel = "seguePanel"
    case About = "segueAbout"
    case Exit = "segueExit"
}
