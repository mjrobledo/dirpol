//
//  ViewBusquedaUno.swift
//  dirpol
//
//  Created by macbook on 19/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol busquedaDelegate {
    func busquedaCompleta(texto:String)
    func verDetalleBusqueda(institucion:Institucion)
}

class ViewBusquedaUno: UIView, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
   
    var delegateBusqueda:busquedaDelegate!
    
    @IBOutlet weak var tabla: UITableView!
    @IBOutlet weak var txtBusqueda: UITextField!
    @IBOutlet weak var btnBuscar: UIButton!
    
    @IBOutlet weak var lblDominio: UILabel!
    
    var Items:[InstitucionFuncionario] = []
    var frameOriginal:CGRect = CGRect()
    
    func iniciar(){
     
        tabla.delegate = self
        tabla.dataSource = self
        tabla.alpha = 0
        self.lblDominio.alpha = 0
        tabla.reloadData()
        frameOriginal = tabla.frame
        txtBusqueda.delegate = self
    }
    
    func reiniciar(){
        Items = []
        txtBusqueda.text = ""
        tabla.reloadData()
    }
    
    @objc func ocultarTeclado(){
        self.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let label:UILabel = cell?.viewWithTag(1) as! UILabel
        label.text = self.Items[indexPath.row].Nombre
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = Items[indexPath.row]
        if item.Tipo == structTipo.Institucion{
            getInstitucion(idInstitucion: item.Id)
        }else{
            getInstitucionFuncionario(idFuncionario: item.Id)
        }
        
    }
    
    private func getInstitucion(idInstitucion:Int){
        SVProgressHUD.show(withStatus: "Obteniendo información")
        Servicios().getInstitucion(id_institucion: idInstitucion) { resp in
            SVProgressHUD.dismiss()
            
            if resp != nil && resp?.Datos != nil {
                if resp?.Codigo == structCodigo.Correcto{
                    let inst = resp?.Datos
                    self.delegateBusqueda.verDetalleBusqueda(institucion: inst!)
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
                    self.delegateBusqueda.verDetalleBusqueda(institucion: inst)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        txtBusqueda.resignFirstResponder()
        //self.busquedaAvanzada()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let texto = textFieldText.replacingCharacters(in: range, with: string)
        
        if texto.trim().count == 0 {
            btnBuscar.isEnabled = false
        }else{
            btnBuscar.isEnabled = true
        }
        if(texto.trim().count >= 3){
          
            buscar(palabra: texto)
        }else{
            UIView.animate(withDuration: 1, animations: {
                self.tabla.alpha = 0
                self.lblDominio.alpha = 0
            })
        }
        return true
    }
    
    private func buscar(palabra:String){
        print("buscar palabra \(palabra)")
        getInstituciones(texto: palabra)
    }
    
    @IBAction func buscar(_ sender: Any) {
       txtBusqueda.resignFirstResponder()
        self.busquedaAvanzada()
        print("Buscar desde el boton")
    }
    
    @IBAction func ocultarTeclado(_ sender: Any) {
        self.ocultarTeclado()
    }
    
    
    private func getInstituciones(texto:String){
        if texto.count <= 2 {
            return
        }
        Items = []
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1, animations: {
                self.tabla.alpha = 1
                self.lblDominio.alpha = 1
            })
            self.tabla.reloadData()
            //self.txtBusqueda.isEnabled = false
            SVProgressHUD.show()
            self.tabla.alpha = 0
            self.lblDominio.alpha = 0
        }
        
        Servicios().getBusquedaGoogle(texto: texto, completa: false) { respuesta in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                
                //self.txtBusqueda.isEnabled = false
            }
            
            if respuesta?.Codigo == structCodigo.Correcto{
                if respuesta?.Datos.count == 0{
                    SVProgressHUD.showSuccess(withStatus: "No se encontraron resultados")
                    SVProgressHUD.dismiss(withDelay: 3)
                }else{
                    self.Items = (respuesta?.Datos)!
                    let cg = CGSize(width: self.tabla.frame.width, height: CGFloat(43 * self.Items.count));
                    if cg.height < self.tabla.frame.size.height {
                        self.tabla.alpha = 1
                        self.lblDominio.alpha = 1
                        self.tabla.frame = CGRect(origin: self.tabla.frame.origin, size: cg)
                    }else{
                        self.tabla.alpha = 1
                        self.lblDominio.alpha = 1
                        self.tabla.frame = self.frameOriginal
                    }
                    let y = (self.tabla.frame.origin.y + self.tabla.frame.height + 10)
                    self.lblDominio.frame = CGRect(x: self.lblDominio.frame.origin.x, y: y, width: self.lblDominio.frame.width, height: self.lblDominio.frame.height)
                    
                    self.tabla.reloadData()
                }
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
    
    private func busquedaAvanzada(){
        if self.delegateBusqueda != nil{
            let texto = (txtBusqueda.text?.trim())!
            self.delegateBusqueda.busquedaCompleta(texto: texto)
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

struct structTipo {
    static var Institucion = 1
    static var Funcionario = 2
}
