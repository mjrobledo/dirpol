//
//  DetalleBAvanzadaVC.swift
//  dirpol
//
//  Created by macbook on 27/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit

class DetalleBAvanzadaVC: UIViewController,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tabla: UITableView!
    
    @IBOutlet weak var lblTitulo: UILabel!
    @IBOutlet weak var txtBusqueda: UITextField!
    
    var ItemsPrincipal:[Institucion] = []
    var Items:[Institucion] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        
        tabla.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func volver(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func Buscar(_ sender: Any) {
        buscar()
        self.view.endEditing(true)
    }

    func buscar(){
        let busqueda:String = (txtBusqueda.text?.trim().lowercased())!
        if busqueda != ""{
            Items = ItemsPrincipal.filter({$0.Descripcion.lowercased().contains(busqueda) || $0.Districto.lowercased().contains(busqueda) })
            
        }else{
            Items = ItemsPrincipal
        }
        tabla.reloadData()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        buscar()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // MARK: - Tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let titulo:UILabel = cell?.viewWithTag(1) as! UILabel
        titulo.text = "\(Items[indexPath.row].Descripcion) - \(Items[indexPath.row].Districto)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = Items[indexPath.row]
        self.performSegue(withIdentifier: strSegue.Detalle, sender: item)
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
/*
extension String {
    
    func contains(_ find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(_ find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}*/
