//
//  ListVCV.swift
//  dirpol
//
//  Created by Developer iOS on 8/4/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol ListDelegate {
    func setNivel(nivel : NivelOption, ubigeo : UbigeosModel)
}

class ListVC: UIViewController {
    var delegate : ListDelegate!
    @IBOutlet weak var table: UITableView!
    
    var nivel: NivelOption!
    var ubigeo : UbigeosModel!
    
    private var items: [UbigeosModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.getUbigeos()
    }
    
    private func getUbigeos() {
        SVProgressHUD.show()
        var ubigeoStr = ""
        if ubigeo != nil {
            ubigeoStr = ubigeo.ubigeo_id!
        }
        Singleton.instance.services.getUbigeos(nivel: "\(nivel.rawValue)", ubigeoSup: ubigeoStr) { (response) in
            if response != nil && response?.status == 200 {
                self.items = (response?.data)!
                self.table.reloadData()
                if self.items.isEmpty {
                    SVProgressHUD.showInfo(withStatus: "No se encontraron resultados")
                    SVProgressHUD.dismiss(withDelay: 4)
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                SVProgressHUD.showInfo(withStatus: "El servicio no responde, Intenta más tarde")
                SVProgressHUD.dismiss(withDelay: 4)
                self.dismiss(animated: true, completion: nil)
            }
            SVProgressHUD.dismiss()
        }
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

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let imageView = cell?.viewWithTag(1) as! UIImageView
        let lblName = cell?.viewWithTag(2) as! UILabel
        let item = items[indexPath.row]
        imageView.image = #imageLiteral(resourceName: "ic_uncheck")
        if let u = self.ubigeo {
            if u.ubigeo_id == item.ubigeo_id {
                imageView.image = #imageLiteral(resourceName: "ic_check")
            }
        }
        lblName.text = item.descripcion_ubigeo
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if self.delegate != nil {
                self.delegate.setNivel(nivel: self.nivel, ubigeo: self.items[indexPath.row])
            }
            self.dismiss(animated: true, completion: nil)
        }        
    }
    
}
