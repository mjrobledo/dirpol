//
//  ViewRegionesTabla.swift
//  dirpol
//
//  Created by macbook on 20/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol provInstitucionDelegate {
    func institucionSeleccionada(institucion:Institucion)
    func volverARegionMapa()
}

var ItemsAlfabetoRegion:[Substring] = []

class ViewProvInstitucion: UIView , UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var bntFlechaBuscar: UIButton!
    @IBOutlet weak var viewBusqueda: UIView!
    
    var delegateProvinciaInst:provInstitucionDelegate!
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var imgUbicacion: UIImageView!
    
    @IBOutlet weak var lblTitulo: UILabel!
    
    @IBOutlet weak var txtBuscar: UITextField!
    
    
    var region:Region!
    var provincia:Region!
    
    
    var provincias:[Region] = []
    var instituciones:[InstitucionFuncionario] = []
    
    var provinciasAux:[Region] = []
    var institucionesAux:[InstitucionFuncionario] = []
    
    func iniciar(){
        txtBuscar.delegate = self
        if strVRegion.ventanaAbierta == strVRegion.VistaProvincia{
            if bntFlechaBuscar.tag == 10{
                viewBusqueda.alpha = 0
            }else{
                viewBusqueda.alpha = 1
            }
        }
        setTitulo()
        
        tabla.delegate = self
        tabla.dataSource = self
        
        tabla.reloadData()
        getDatosServicio()
    }
    
    //Obtiene los datos del servicio
    // Provincias segun Regione
    // Institución segun Provincia
    func getDatosServicio(){
        switch strucSubMenu.Activo {
        case strucSubMenu.Region :
            if strVRegion.ventanaAbierta == strVRegion.VistaProvincia && provincias.count == 0{
                SVProgressHUD.show()
                Servicios().getProvincias(idRegion : region.Id , completion: { provincias in
                    if provincias != nil{
                        SVProgressHUD.dismiss()
                        self.provincias = provincias!
                        self.provinciasAux = provincias!
                        self.llenarAlfabeto()
                        self.tabla.reloadData()
                    }
                })
            }else{
                if self.provincia == nil{
                    return
                }
                SVProgressHUD.show()
                Servicios().getInstitucionesProvincia(id_provincia: self.provincia.Id, completion: { instituciones in
                    SVProgressHUD.dismiss()
                    if instituciones != nil {
                        if instituciones?.Codigo == structCodigo.Correcto  {
                            self.instituciones = []
                            self.institucionesAux = []
                            
                            self.instituciones = (instituciones?.Datos)!
                            self.institucionesAux = (instituciones?.Datos)!
                            self.llenarAlfabeto()
                            self.tabla.reloadData()
                            
                            if self.instituciones.count == 0{
                                SVProgressHUD.showInfo(withStatus: "No se encontraron resultados")
                                SVProgressHUD.dismiss(withDelay: 4)
                            }
                        }else{
                            SVProgressHUD.showError(withStatus: instituciones?.Mensaje)
                            SVProgressHUD.dismiss(withDelay: 4)
                            strVRegion.ventanaAbierta = strVRegion.VistaProvincia
                        }
                    }else{
                        SVProgressHUD.showError(withStatus: "Error en el servicio")
                        SVProgressHUD.dismiss(withDelay: 3)
                        strVRegion.ventanaAbierta = strVRegion.VistaProvincia
                    }
                })
            }
            
        default:
            print("Default")
        }
    }
    //Agrega el titulo de la Región que se selecciono o la
    // Region - Provincia segun sea el caso.
    func setTitulo(){
        if strVRegion.ventanaAbierta == strVRegion.VistaProvincia{
            lblTitulo.text = region.Nombre
        }else{
           // lblTitulo.text = "\(region.Nombre) - \(provincia.Nombre)"
            lblTitulo.text = ""
        }
    }
    
    private func llenarAlfabeto(){
        ItemsAlfabetoRegion = []
        
        let d = provinciasAux.map({ $0.Nombre.prefix(1) })
        ItemsAlfabetoRegion = Array(Set(d)).sorted()
        
        if strVRegion.ventanaAbierta == strVRegion.VistaProvincia{
            let d = provinciasAux.map({ $0.Nombre.prefix(1) })
            ItemsAlfabetoRegion = Array(Set(d)).sorted()
        }else{
            let d = institucionesAux.map({ $0.Nombre.prefix(1) })
            ItemsAlfabetoRegion = Array(Set(d)).sorted()
        }
       
    }
    
    func buscar(busqueda:String){
        
        if busqueda.trim() != ""{
            if strVRegion.ventanaAbierta == strVRegion.VistaProvincia{
                provinciasAux = provincias.filter({$0.Nombre.lowercased().contains(busqueda) })
            }else{
                institucionesAux = instituciones.filter({$0.Nombre.lowercased().contains(busqueda) })
            }
        }else{
            if strVRegion.ventanaAbierta == strVRegion.VistaProvincia{
                self.provinciasAux = self.provincias
            }else{
                self.institucionesAux = self.instituciones
            }
        }
        llenarAlfabeto()
        tabla.reloadData()
    }
    // MARK: - Delegados de TextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if string.trim() == "" && textField.text?.trim().count == 1{
            buscar(busqueda:"\(string)")
        }else{
            buscar(busqueda:"\((textField.text)!)\(string)")
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        buscar(busqueda:"\((textField.text)!)")
        self.endEditing(true)
        return true
    }
    
    // MARK: - Delegados de Tabla
    //Metodos para los encabezados y alfabeto
    func numberOfSections(in tableView: UITableView) -> Int {
        return ItemsAlfabetoRegion.count
    }
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return arrIndexSection   //Side Section title
    }
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
    {
        return index
    }
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(ItemsAlfabetoRegion[section])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let encabezado:String = String(ItemsAlfabetoRegion[section])
        if strVRegion.ventanaAbierta == strVRegion.VistaProvincia{
            let items = provinciasAux.filter{ $0.Nombre.hasPrefix(encabezado) }
            return items.count;
        }else{
            let items = institucionesAux.filter{ $0.Nombre.hasPrefix(encabezado) }
            return items.count;
        }
    }
    
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if strVRegion.ventanaAbierta == strVRegion.VistaProvincia{
            return provinciasAux.count
        }else{
            return institucionesAux.count
        }
    }
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         if strVRegion.ventanaAbierta == strVRegion.VistaProvincia{
            return retornaCeldaProvincia(cellForRowAt: indexPath)
         }else{
            return retornaCeldaInstitucion(cellForRowAt: indexPath)
        }
        
    }
    private func retornaCeldaProvincia(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell")
        
        let encabezado:String = String(ItemsAlfabetoRegion[indexPath.section])
        let items = provinciasAux.filter{ $0.Nombre.hasPrefix(encabezado) }
        let item = items[indexPath.row]
        
        let titulo:UILabel = cell?.viewWithTag(1) as! UILabel
        titulo.text = item.Nombre
        
        return cell!
    }
    
    private func retornaCeldaInstitucion(cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabla.dequeueReusableCell(withIdentifier: "cell")
        
        let encabezado:String = String(ItemsAlfabetoRegion[indexPath.section])
        let items = institucionesAux.filter{ $0.Nombre.hasPrefix(encabezado) }
        let item = items[indexPath.row]
        
        //let item = institucionesAux[indexPath.row]
        
        let titulo:UILabel = cell?.viewWithTag(1) as! UILabel
        titulo.text = "\(item.Nombre)"
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if strVRegion.ventanaAbierta == strVRegion.VistaProvincia{
            strVRegion.ventanaAbierta = strVRegion.VistaInstitucion
            imgUbicacion.image = #imageLiteral(resourceName: "ic_provincia")
            imgUbicacion.isHidden = false
            bntFlechaBuscar.isHidden = true
            viewBusqueda.alpha = 1
            self.provincia = self.provinciasAux[indexPath.row]
            self.txtBuscar.text = ""
            self.provinciasAux = self.provincias
            getDatosServicio()
        }else{
            self.getInstitucion(idInstitucion: institucionesAux[indexPath.row].Id)
        }
        
         setTitulo()
    }
    
    private func getInstitucion(idInstitucion:Int){
        SVProgressHUD.show(withStatus: "Obteniendo información")
        Servicios().getInstitucion(id_institucion: idInstitucion) { resp in
            SVProgressHUD.dismiss()
            
            if resp != nil && resp?.Datos != nil {
                if resp?.Codigo == structCodigo.Correcto{
                    let inst:Institucion = (resp?.Datos)!
                    self.delegateProvinciaInst.institucionSeleccionada(institucion: inst)
                }else{
                    SVProgressHUD.showInfo(withStatus: resp?.Mensaje)
                    SVProgressHUD.dismiss(withDelay: 3)
                }
            }else{
                SVProgressHUD.showError(withStatus: "Error en el servicio")
                SVProgressHUD.dismiss(withDelay: 3)
            }
        }
    }
    
    
    @IBAction func Volver(_ sender: Any) {
        if strVRegion.ventanaAbierta == strVRegion.VistaInstitucion{
            strVRegion.ventanaAbierta = strVRegion.VistaProvincia
            setTitulo()
            imgUbicacion.image = #imageLiteral(resourceName: "ic_region")
            imgUbicacion.isHidden = true
            bntFlechaBuscar.isHidden = false
            
            tabla.reloadData()
        }else{
            delegateProvinciaInst.volverARegionMapa()
        }
        
    }
    
    @IBAction func abrirCerarBusqueda(_ sender: Any) {
        
        if bntFlechaBuscar.tag == 10{
            bntFlechaBuscar.tag = 11
            UIView.animate(withDuration: 1.0, animations: {
                self.bntFlechaBuscar.transform = CGAffineTransform(rotationAngle: CGFloat.pi/1)
                self.viewBusqueda.alpha = 1
            })
            
        }else{
            bntFlechaBuscar.tag = 10
            UIView.animate(withDuration: 1.0, animations: {
                self.bntFlechaBuscar.transform = CGAffineTransform(rotationAngle: CGFloat.pi*2)
                self.viewBusqueda.alpha = 0
            })
            
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

// Mantiene que vista esta activa del submenu de Region
struct strVRegion{
    static var ventanaAbierta = 1
    
    static let VistaProvincia = 1
    static let VistaInstitucion = 2
    

}

//Ventana busqueda
struct strVBusqueda{
    static var ventanaAbierta = 1
    
    static let VistaBusquedaGoogle = 1
    static let VistaBusquedaCompleta = 2
    
    
}
