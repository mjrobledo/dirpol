//
//  ViewBusquedaDos.swift
//  dirpol
//
//  Created by macbook on 25/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol busquedaDosDelegate {
    func busquedaDosSeleccionado(institucion:Institucion)
    func volverBusquedaUno()
}

class ViewBusquedaDos: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    var delegateBusquedaDos:busquedaDosDelegate!
    @IBOutlet weak var tablaBusqueda: UITableView!
    
    @IBOutlet weak var txtBusqueda: UITextField!
    @IBOutlet weak var btnBuscar: UIButton!
    @IBOutlet weak var lblNumeroResultados: UILabel!
    
    var Items:[InstitucionFuncionario] = []
    
    func iniciar(texto:String){
        self.getInstitucionesFuncionario(texto: texto)
        tablaBusqueda.delegate = self
        tablaBusqueda.dataSource = self
        tablaBusqueda.reloadData()
        txtBusqueda.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let label:UILabel = cell?.viewWithTag(1) as! UILabel
        label.text = Items[indexPath.row].Nombre
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.delegateBusquedaDos != nil{
            if Items[indexPath.row].Tipo == structTipo.Institucion{
                getInstitucion(idInstitucion: Items[indexPath.row].Id)
            }else{
                getInstitucionFuncionario(idFuncionario: Items[indexPath.row].Id)
            }
        }
    }
    
    private func getInstitucion(idInstitucion:Int){
        SVProgressHUD.show(withStatus: "Obteniendo información")
        Servicios().getInstitucion(id_institucion: idInstitucion) { resp in
            SVProgressHUD.dismiss()
            
            if resp != nil && resp?.Datos != nil {
                if resp?.Codigo == structCodigo.Correcto{
                    let inst:Institucion = (resp?.Datos)!
                    self.delegateBusquedaDos.busquedaDosSeleccionado(institucion: inst)
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
    
    private func getInstitucionFuncionario(idFuncionario:Int){
        SVProgressHUD.show(withStatus: "Obteniendo información")
        Servicios().getInstitucionFuncionario(id_funcionario: idFuncionario) { resp in
            SVProgressHUD.dismiss()
            
            if resp != nil && resp?.Datos != nil {
                if resp?.Codigo == structCodigo.Correcto{
                    let inst:Institucion = (resp?.Datos)!
                    self.delegateBusquedaDos.busquedaDosSeleccionado(institucion: inst)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let texto = textFieldText.replacingCharacters(in: range, with: string)
        
        if texto.trim().count == 0 {
            btnBuscar.isEnabled = false
        }else{
            btnBuscar.isEnabled = true
        }
        
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Buscar")
        let texto = (textField.text?.trim())!
        self.getInstitucionesFuncionario(texto: texto)
        txtBusqueda.resignFirstResponder()
        return true
    }
    
    
    
     func getInstitucionesFuncionario(texto:String){
        if texto.count <= 2 {
            return
        }
        Items = []
        DispatchQueue.main.async {
            self.tablaBusqueda.reloadData()
            SVProgressHUD.show()
        }
        
        Servicios().getBusquedaGoogle(texto: texto, completa: true) { respuesta in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            
            if respuesta != nil && respuesta?.Codigo == structCodigo.Correcto{
                if respuesta?.Datos.count == 0{
                    SVProgressHUD.showSuccess(withStatus: "No se encontraron resultados")
                    SVProgressHUD.dismiss(withDelay: 3)
                }else{
                    self.Items = (respuesta?.Datos)!
                    self.tablaBusqueda.reloadData()
                }
                self.lblNumeroResultados.text = "¡Encontrado(s) \((respuesta?.Datos.count)!) resultado(s)!"
            }else{
                if respuesta == nil{
                    SVProgressHUD.showSuccess(withStatus: "Error en el servicio")
                    SVProgressHUD.dismiss(withDelay: 3)
                }else{
                    SVProgressHUD.showSuccess(withStatus: respuesta?.Mensaje)
                    SVProgressHUD.dismiss(withDelay: 3)
                }
            }
        }
    }
    
    
    @IBAction func volverBusquedaUno(_ sender: Any) {
        delegateBusquedaDos.volverBusquedaUno()
    }
    
    @IBAction func buscar(_ sender: Any) {
        let texto = (txtBusqueda.text?.trim())!
        self.getInstitucionesFuncionario(texto: texto)
        txtBusqueda.resignFirstResponder()
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
