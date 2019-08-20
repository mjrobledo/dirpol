//
//  AltoMandoPolicialVC.swift
//  dirpol
//
//  Created by macbook on 18/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD


class AltoMandoPolicialVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var txtBusqueda: UITextField!
    
    @IBOutlet weak var tabla: UITableView!
    var instituciones:[InstitucionFuncionario] = []
    var institucionesAux:[InstitucionFuncionario] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getServicios()
    }
    
    private func getServicios(){
        SVProgressHUD.show()
        Servicios().getAltoMando(completion: { instituciones in
            SVProgressHUD.dismiss()
            
            if instituciones != nil && instituciones?.Datos != nil{
                if instituciones?.Codigo == structCodigo.Correcto{
                    self.instituciones = (instituciones?.Datos)!
                    self.institucionesAux = (instituciones?.Datos)!
                
                }else{
                    SVProgressHUD.showInfo(withStatus: instituciones?.Mensaje)
                    SVProgressHUD.dismiss(withDelay: 3)
                }
                self.tabla.reloadData()
            }else{
                SVProgressHUD.showError(withStatus: "Error en el servicio")
                SVProgressHUD.dismiss(withDelay: 3)
            }
        })
    }

    func buscar(busqueda:String){
        if busqueda != ""{
                institucionesAux = instituciones.filter({$0.Nombre.lowercased().contains(busqueda) })
        }else{
            self.institucionesAux = self.instituciones
        }
        tabla.reloadData()
    }
    
    @IBAction func volver(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func Buscar(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Delegados de TextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        
        buscar(busqueda:txtAfterUpdate)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // MARK: - Delegados de Tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return institucionesAux.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = institucionesAux[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let titulo:UILabel = cell?.viewWithTag(1) as! UILabel
        titulo.text = item.Nombre
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let idInstitucion = institucionesAux[indexPath.row].Id
            getInstitucion(idInstitucion: idInstitucion)
    }
    
    private func getInstitucion(idInstitucion:Int){
        SVProgressHUD.show(withStatus: "Obteniendo información")
        Servicios().getInstitucion(id_institucion: idInstitucion) { resp in
            SVProgressHUD.dismiss()
            
            if resp != nil && resp?.Datos != nil {
                if resp?.Codigo == structCodigo.Correcto{
                    let inst:Institucion = (resp?.Datos)!
                    self.performSegue(withIdentifier: strSegue.Detalle, sender: inst)
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
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
            if segue.identifier == strSegue.Detalle {
                let svc = segue.destination as! DetalleBusquedaVC
                let inst:Institucion = sender as! Institucion
                svc.institucion = inst
            }
    }
    

}
