//
//  ViewDirectorio.swift
//  dirpol
//
//  Created by macbook on 19/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol directorioDelegate {
    func directorioSeleccionado(institucion:Institucion)
}

var direcciones:[InstitucionFuncionario] = []
var direccionesAux:[InstitucionFuncionario] = []
var ItemsAlfabetoDireccion:[Substring] = []

var arrIndexSection : [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]


class ViewDirectorio: UIView, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate{
    
    var delegateDirectorio:directorioDelegate!
    
    @IBOutlet weak var txtBusqueda: UITextField!
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var lblContador: UILabel!
    
    @IBOutlet weak var lblNumeroRegistros: UILabel!
    
    
    
    
    func iniciar(){
        tabla.delegate = self
        tabla.dataSource = self
        txtBusqueda.delegate = self
        
        if direcciones.count != 0{
            direccionesAux = direcciones
            self.llenarAlfabeto()
            tabla.reloadData()
            return
        }
        
        SVProgressHUD.show()
        Servicios().getInstitucionesProvincia(id_provincia: 0, completion: {resp in
            SVProgressHUD.dismiss()
            if resp != nil && resp?.Datos != nil{
                if resp?.Codigo == structCodigo.Correcto{
                    direcciones = (resp?.Datos)!
                    direccionesAux = (resp?.Datos)!
                    
                    self.llenarAlfabeto()

                    if resp?.Datos.count == 0{
                        SVProgressHUD.show(withStatus: .NoSeEncontraronDatos)
                        SVProgressHUD.dismiss(withDelay: 3)
                    }
                }else{
                    SVProgressHUD.showInfo(withStatus: resp?.Mensaje)
                    SVProgressHUD.dismiss(withDelay: 3)
                }
            }else{
                SVProgressHUD.showError(withStatus: .ErrorEnElServicio)
                SVProgressHUD.dismiss(withDelay: 3)
            }
            self.tabla.reloadData()
            self.actualizaNumerosContactos()
        })
    }
    
    private func llenarAlfabeto(){
        ItemsAlfabetoDireccion = []
        let d = direccionesAux.map({ $0.Nombre.prefix(1) })
        ItemsAlfabetoDireccion = Array(Set(d)).sorted()
        
       /* for item in direccionesAux{
            if !ItemsAlfabetoDireccion.contains(String(item.Nombre.prefix(1).uppercased())){
                ItemsAlfabetoDireccion.append(String(item.Nombre.prefix(1).uppercased()))
            }
        }*/
        //ItemsAlfabetoDireccion = ItemsAlfabetoDireccion.sorted()
    }
    
    func buscar(palabra: String){
        
        if palabra.trim() != ""{
            direccionesAux = direcciones.filter({$0.Nombre.lowercased().contains(palabra.trim()) })
        }else{
            direccionesAux = direcciones
        }
        self.llenarAlfabeto()
        actualizaNumerosContactos()
        tabla.reloadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        
        buscar(palabra: txtAfterUpdate)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
    private func actualizaNumerosContactos(){
        let con:String = .contactos
        self.lblContador.text = "\(direccionesAux.count) \(con)"  
    }
    //Metodos para los encabezados y alfabeto
    func numberOfSections(in tableView: UITableView) -> Int {
        return ItemsAlfabetoDireccion.count
    }
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return arrIndexSection   //Side Section title
    }
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int
    {
        return index
    }
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(ItemsAlfabetoDireccion[section])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let encabezado:String = String(ItemsAlfabetoDireccion[section])
        let items = direccionesAux.filter{ $0.Nombre.hasPrefix(encabezado) }
        return items.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let encabezado:String = String(ItemsAlfabetoDireccion[indexPath.section])
       
        let items = direccionesAux.filter{ $0.Nombre.hasPrefix(encabezado) }
        let direccion = items[indexPath.row]
       
        //let direccion = direccionesAux[indexPath.row]
        let titulo:UILabel = cell?.viewWithTag(1) as! UILabel
        titulo.text = "\(direccion.Nombre)"
        titulo.backgroundColor = UIColor.cPrincipal()
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.delegateDirectorio != nil{
            getInstitucionFuncionario(idFuncionario: direccionesAux[indexPath.row].Id)
        }
    }
    
    private func getInstitucionFuncionario(idFuncionario:Int){
        SVProgressHUD.show(withStatus: .ObteniendoInformacion)
        Servicios().getInstitucionFuncionario(id_funcionario: idFuncionario) { resp in
            SVProgressHUD.dismiss()
            
            if resp != nil && resp?.Datos != nil {
                if resp?.Codigo == structCodigo.Correcto{
                    let inst:Institucion = (resp?.Datos)!
                    self.delegateDirectorio.directorioSeleccionado(institucion: inst)
                }else{
                    SVProgressHUD.showInfo(withStatus: resp?.Mensaje)
                    SVProgressHUD.dismiss(withDelay: 3)
                }
            }else{
                SVProgressHUD.showError(withStatus: .ErrorEnElServicio)
                SVProgressHUD.dismiss(withDelay: 3)
            }
        }
    }
    
    
    @IBAction func buscarDirecciones(_ sender: Any) {
        txtBusqueda.resignFirstResponder()
        self.buscar(palabra: (txtBusqueda.text?.trim())!)
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    

}



