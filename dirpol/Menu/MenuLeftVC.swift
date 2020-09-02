//
//  MenuVC.swift
//  Proyecto
//
//  Created by DESAPP-1 on 16/03/17.
//  Copyright © 2017 Lisyx. All rights reserved.
//

import UIKit
import CropViewController

 
class MenuLeftVC: UIViewController, UITableViewDataSource, UITableViewDelegate, SWRevealViewControllerDelegate {

    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblID: UILabel!
    
    @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var viewTop: UIView!
    
    var pickerController: UIImagePickerController!
    private var croppingStyle = CropViewCroppingStyle.default
    var ar_Menu:[Menu] = Menu.getMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewTop.backgroundColor = UIColor.cPrincipal()
        // Do any additional setup after loading the view.
        Singleton.instance.menuTable = self.tblMenu
        tblMenu.reloadData()
        self.configScreen()
    }

    override func viewDidAppear(_ animated: Bool) {
        tblMenu.reloadData()
    }
    
    private func configScreen(){
        switch Api.config_app {
        case .Colombia:
            imgHeader.isHidden = false
            imgLogo.isHidden = true
            lblUserName.textColor = UIColor.yellow
            lblID.textColor = UIColor.white
            lblSubtitle.textColor = UIColor.white
        case .Peru:
            lblUserName.textColor = UIColor.cPrincipal()
        case .Mexico:
            print("Mexico Menu")
        }
    }
    
    func revealControllerPanGestureBegan(_ revealController: SWRevealViewController!) {
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
        cell.imgIcono.image =  m.imagen.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        cell.imgIcono.tintColor = UIColor.cPrincipal()
        
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
    
    static func changedMenu(menu:Int)
    {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: menu, section: 0)
            Singleton.instance.menuTable.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            Singleton.instance.menuTable.delegate?.tableView!(Singleton.instance.menuTable, didSelectRowAt: indexPath)
        }
    }
    
    @IBAction func goToRenew(_ sender: Any) {
        var segueID = "renewIDP"
        switch Api.config_app {
        case .Colombia:
            segueID = "renewIDC"
        case .Peru:
            segueID = "renewIDP"
        case .Mexico:
            segueID = "renewIDP"
        }
        let vc =  UIStoryboard(name: "Credential", bundle: nil).instantiateViewController(withIdentifier: segueID)  as! RenewMembershipVC
        vc.setPopPup()
        self.present(vc, animated: true, completion: nil)
    }
    
    @available(iOS 13.0, *)
    @IBAction func takeAPicture(_ sender: Any) {
        self.selectPath()
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

// MARK: - PhotoProfile
extension MenuLeftVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK:- Cambiar foto de perfil
    
    
        private func setCrollImage(image: UIImage) {
            //If profile picture, push onto the same navigation stack
            let cropViewController = CropViewController(croppingStyle: .circular, image: image)
            cropViewController.delegate = self
            present(cropViewController, animated: true, completion: nil)
        }
        
        func selectPath() {
            pickerController = UIImagePickerController()
            pickerController.delegate = self
            
            let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet) // 1
            let btn_camara = UIAlertAction(title: "Camera", style: .default) { (alert: UIAlertAction!) -> Void in
                //self.selectedCamera()
                self.fromCamera()
            }
            let btn_carrete = UIAlertAction(title: "Gallery", style: .default) { (alert: UIAlertAction!) -> Void in
              //  self.selectedCarrete()
                self.fromGalery()
            }
            let btn_cancelar = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in }

            alert.addAction(btn_camara) // 4
            alert.addAction(btn_carrete) // 4
            alert.addAction(btn_cancelar) // 4

            present(alert, animated: true, completion: nil) // 6
        }
    
    func fromCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            pickerController.sourceType = .camera
            present(pickerController, animated: true, completion: nil)
        } else {
            Util().enviarAlerta(mensaje: "Camara no disponible", titulo: "Ok", controller: self)
        }
    }

    func fromGalery() {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        pickerController.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage]! as! UIImage
        self.setCrollImage(image: image)
    }
}

extension MenuLeftVC: CropViewControllerDelegate {
    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        print("didCropToCircularImage")
        cropViewController.dismiss(animated: true) {
            self.imgProfile.image = image
        }
    }
    func cropViewController(_ cropViewController: CropViewController, didCropImageToRect rect: CGRect, angle: Int) {
        print("didCropImageToRect")
    }
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        print("didFinishCancelled")
        cropViewController.dismiss(animated: true, completion: nil)
    }
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        print("didCropToImage")
    }
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
     
        
        return [Menu(titulo: "Inicio", segue: Segue.Home, imagen: UIImage(named: "menu_home_\(Api.config_app.getShortName())")!),
                Menu(titulo: "Regiones", segue: Segue.Region, imagen: UIImage(named: "menu_region_\(Api.config_app.getShortName())")!),
                Menu(titulo: "Búsqueda Avanzada", segue: Segue.Search, imagen: UIImage(named: "menu_search_\(Api.config_app.getShortName())")!),
                Menu(titulo: "Directorio", segue: Segue.Directory, imagen: UIImage(named: "menu_directory_\(Api.config_app.getShortName())")!),
                Menu(titulo: "Contáctanos", segue: Segue.ContactUs, imagen: UIImage(named: "menu_contact_\(Api.config_app.getShortName())")!),
                Menu(titulo: "Credencial Virtual", segue: Segue.Credential, imagen: UIImage(named: "menu_credential_\(Api.config_app.getShortName())")!),
                Menu(titulo: "Panel de Usuario", segue: Segue.Panel, imagen: UIImage(named: "menu_panel_\(Api.config_app.getShortName())")!),
                Menu(titulo: "Acerca de Dirpol", segue: Segue.About, imagen: UIImage(named: "menu_about_\(Api.config_app.getShortName())")!),
                Menu(titulo: "Salir", segue: Segue.Exit, imagen: UIImage(named: "menu_exit_\(Api.config_app.getShortName())")!)]
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
