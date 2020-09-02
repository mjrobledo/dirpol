//
//  DirectoryVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/17/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

class DirectoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate {


    var direcciones:[InstitucionFuncionario] = []
    var direccionesAux:[InstitucionFuncionario] = []
    var ItemsAlfabetoDireccion:[Substring] = []

    var arrIndexSection : [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

    @IBOutlet weak var txtBusqueda: UITextField!
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var lblContador: UILabel!
    
    @IBOutlet weak var lblNumeroRegistros: UILabel!
    
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenu.colorMenu()
        if revealViewController() != nil {
            btnMenu.target = revealViewController()
            btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        super.viewDidLoad()
        self.iniciar()
        // Do any additional setup after loading the view.
    }
    
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
                    self.direcciones = (resp?.Datos)!
                    self.direccionesAux = (resp?.Datos)!
                       
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
        self.view.endEditing(true)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
        let footerView = UIView(frame:rect)
        let label = UILabel(frame: rect)
        label.textAlignment = .center
        label.text = String(ItemsAlfabetoDireccion[section])
        label.textColor = UIColor.white
        label.font = UIFont().MontserratBold(size: 15)
        footerView.addSubview(label)
        footerView.backgroundColor = UIColor.cPrincipal()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
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
                   
           return cell!
       }
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           /*if self.delegateDirectorio != nil{
               getInstitucionFuncionario(idFuncionario: direccionesAux[indexPath.row].Id)
           }*/
       }
       
       private func getInstitucionFuncionario(idFuncionario:Int){
           SVProgressHUD.show(withStatus: .ObteniendoInformacion)
           Servicios().getInstitucionFuncionario(id_funcionario: idFuncionario) { resp in
               SVProgressHUD.dismiss()
               
               if resp != nil && resp?.Datos != nil {
                   if resp?.Codigo == structCodigo.Correcto{
                       let inst:Institucion = (resp?.Datos)!
                       //self.delegateDirectorio.directorioSeleccionado(institucion: inst)
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
