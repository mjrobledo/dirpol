//
//  ListadoTemaVC.swift
//  dirpol
//
//  Created by macbook on 18/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import  SVProgressHUD

protocol listadoDelegate {
    func opcionSeleccionada(id:Int, nombre:String)
    
    func regionesSeleccionadas(ids:[Int], nombre:String)
}

class ListadoTemaVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var viewForm: UIView!
    var delegateListado:listadoDelegate!

    @IBOutlet weak var btnSleeciona: UIButton!
    @IBOutlet weak var lblTitulo: UILabel!
    var Items:[ItemTabla] = []
    
    //var regiones:[Region] = []
    
    var pantallaPadre = strPantalla.Contacto
    
    
    @IBOutlet weak var tabla: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        if pantallaPadre == strPantalla.Contacto{
            viewForm.frame = CGRect(x: 0, y: 0, width: viewForm.frame.width, height: 185)
            viewForm.center = self.view.center
            
            lblTitulo.text = .SeleccionaUnaOpcion
            Items.append(ItemTabla(id: 1, nombre: "General"))
            Items.append(ItemTabla(id: 2, nombre: "Bloqueo cuenta"))
            Items.append(ItemTabla(id: 3, nombre: "Otro"))
            tabla.reloadData()
            btnSleeciona.isHidden = true
        }else{
            lblTitulo.text = .Selecciona
            if regiones.count > 0{
                return
            }
            SVProgressHUD.show()
            Servicios().getRegiones { regionResult in
                SVProgressHUD.dismiss()
                if regionResult != nil{
                    regiones = regionResult!
                    self.tabla.reloadData()
                }
            }
        }
    }
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pantallaPadre == strPantalla.Contacto{
            return Items.count
        }else{
            return regiones.count
        }
            
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let titulo:UILabel = cell?.viewWithTag(1) as! UILabel
        
        if pantallaPadre == strPantalla.Contacto{
            titulo.text = Items[indexPath.row].nombre
        }else{
             titulo.text = regiones[indexPath.row].Nombre
            if regiones[indexPath.row].seleccionada{
                cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
            }else{
                cell?.accessoryType = UITableViewCell.AccessoryType.none
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if pantallaPadre == strPantalla.Contacto{
            let item = Items[indexPath.row]
        
            if delegateListado != nil{
                self.delegateListado.opcionSeleccionada(id: item.id, nombre: item.nombre)
            }
            self.dismiss(animated: true, completion: nil)
        }else{
            
            //let item = regiones[indexPath.row]
            regiones[indexPath.row].seleccionada = !regiones[indexPath.row].seleccionada
            let arr:[Region] = regiones.filter({ $0.seleccionada })
            let ar = arr.map({ $0.Nombre })
            let ids:[Int] = arr.map({ $0.Id })
            self.delegateListado.regionesSeleccionadas(ids: ids, nombre: ar.joined(separator: ","))
            //self.dismiss(animated: true, completion: nil)
            self.tabla.reloadData()
        }
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

class ItemTabla{
    var id:Int = 0
    var nombre:String = ""
    init(id:Int, nombre:String) {
        self.id = id
        self.nombre = nombre
    }
}

struct strPantalla{
    static var Contacto = 1
    static var BusquedaAvanzada = 2
    
    
}
