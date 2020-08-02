//
//  BusquedaAvanzadaVC.swift
//  dirpol
//
//  Created by macbook on 19/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

class BusquedaAvanzadaVC: UIViewController, listadoDelegate, UITextFieldDelegate {

    var Instituciones:[Institucion] = []
    
    @IBOutlet weak var txtCategoria: UITextField!
    @IBOutlet weak var txtBusqueda: UITextField!
    
    @IBOutlet weak var imgTodasPalabras: UIImageView!
    @IBOutlet weak var imgAlgunasPalabras: UIImageView!
    @IBOutlet weak var imgPalabrasExactas: UIImageView!
    
    @IBOutlet weak var viewTodasPalabras: UIView!
    @IBOutlet weak var viewAlgunasPalabras: UIView!
    @IBOutlet weak var viewPalabrasExactas: UIView!
    
    let reqBusqueda = RequestBusqueda()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for item in regiones{
            item.seleccionada = false
        }
        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.todas(sender:)))
        self.viewTodasPalabras.addGestureRecognizer(gesture)
        
        let gesture1 = UITapGestureRecognizer(target: self, action:  #selector(self.algunas(sender:)))
        self.viewAlgunasPalabras.addGestureRecognizer(gesture1)
        
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector(self.exactas(sender:)))
        self.viewPalabrasExactas.addGestureRecognizer(gesture2)
        
         let tap1 = UITapGestureRecognizer(target: self, action: #selector(ocultarTeclado))
        self.view.addGestureRecognizer(tap1)
        
        reqBusqueda.Entrada = structTipoBusqueda.Todas
    }
    @objc func ocultarTeclado(){
        self.view.endEditing(true)
    }
    
    @objc func todas(sender : UITapGestureRecognizer) {
        imgTodasPalabras.image = #imageLiteral(resourceName: "ic_radio_on")
        imgAlgunasPalabras.image = #imageLiteral(resourceName: "ic_radio_off")
        imgPalabrasExactas.image = #imageLiteral(resourceName: "ic_radio_off")
        reqBusqueda.Entrada = structTipoBusqueda.Todas
    }
    @objc func algunas(sender : UITapGestureRecognizer) {
        imgTodasPalabras.image = #imageLiteral(resourceName: "ic_radio_off")
        imgAlgunasPalabras.image = #imageLiteral(resourceName: "ic_radio_on")
        imgPalabrasExactas.image = #imageLiteral(resourceName: "ic_radio_off")
        reqBusqueda.Entrada = structTipoBusqueda.Algunas
    }
    @objc func exactas(sender : UITapGestureRecognizer) {
        imgTodasPalabras.image = #imageLiteral(resourceName: "ic_radio_off")
        imgAlgunasPalabras.image = #imageLiteral(resourceName: "ic_radio_off")
        imgPalabrasExactas.image = #imageLiteral(resourceName: "ic_radio_on")
        reqBusqueda.Entrada = structTipoBusqueda.Exactas
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.ocultarTeclado()
        return true
    }
    
    
    @IBAction func volver(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func SeleccionaTema(_ sender: Any) {
        self.performSegue(withIdentifier: strSegue.Listado, sender: nil)
        
    }
    @IBAction func Buscar(_ sender: Any) {
        reqBusqueda.TextoBusqueda = (txtBusqueda.text?.trim())!
        
        if reqBusqueda.TextoBusqueda.trim() == ""{
            Util().enviarAlerta(mensaje: "Por favor, ingrese un valor para realizar la búsqueda", titulo: "Alerta", controller: self)
            return
        }
        if reqBusqueda.IdCategoria.count == 0 {
            Util().enviarAlerta(mensaje: "Por favor, seleccione uno o más distritos para realizar la búsqueda con mayor precisión", titulo: "Alerta", controller: self)
            return
        }
        
        getDatosServicio()
        
        //
        
    }
    
    func getDatosServicio(){
        SVProgressHUD.show()
        Servicios().getBusquedaAvanzada(request: reqBusqueda) { resp  in
            SVProgressHUD.dismiss()
            if resp != nil && resp?.Datos != nil {
                self.Instituciones = (resp?.Datos)!
                if self.Instituciones.count == 0{
                    SVProgressHUD.showInfo(withStatus: "No se encontraron resultados")
                    SVProgressHUD.dismiss(withDelay: 4)
                }else{
                    self.performSegue(withIdentifier: strSegue.DetalleBAvanzada, sender: nil)
                }
            }else{
                SVProgressHUD.showError(withStatus: "Error en el servicio")
                SVProgressHUD.dismiss(withDelay: 4)
            }
        }
    }
    
    
    func opcionSeleccionada(id: Int, nombre: String) {
        txtCategoria.text = nombre
        //reqBusqueda.Categoria = nombre
        //reqBusqueda.IdCategoria = id
    }
    
    func regionesSeleccionadas(ids: [Int], nombre: String) {
      txtCategoria.text = nombre
        reqBusqueda.IdCategoria = ids
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == strSegue.Listado{
            let svc = segue.destination as! ListadoTemaVC
            svc.delegateListado = self
            svc.pantallaPadre = strPantalla.BusquedaAvanzada
            svc.providesPresentationContextTransitionStyle = true;
            svc.definesPresentationContext = true;
            svc.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
        }else{
            if segue.identifier == strSegue.DetalleBAvanzada{
                let svc = segue.destination as! DetalleBAvanzadaVC
                svc.Items = self.Instituciones
                svc.ItemsPrincipal = self.Instituciones
            }
        }
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

struct structTipoBusqueda {
    static let Todas = 1
    static let Algunas = 2
    static let Exactas = 3
}
