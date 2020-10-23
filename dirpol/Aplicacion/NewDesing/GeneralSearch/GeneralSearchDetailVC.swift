//
//  GeneralSearchDetail.swift
//  dirpol
//
//  Created by Developer iOS on 7/29/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

class GeneralSearchDetailVC: UIViewController {
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var viewCount: UIView!
    @IBOutlet weak var lblCount: UILabel!
    
    var search = ""
    var ubigeoID = ""
    private var items: [EntitySearch] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.colorBack()
        txtSearch.text = search
        
        table.register(UINib(nibName: "CellGeneralSearchDetail", bundle: nil), forCellReuseIdentifier: "cell")
        self.getEntity(name: self.search)
    }
 
    private func getEntity(name: String) {
        var request = RequestEntitySearch()
        request.nombre = name
        request.limit = 30
        request.ubigeo_id = ubigeoID
        SVProgressHUD.show()
        print(request.toJSONString(prettyPrint: false))
        Singleton.instance.services.getEntity(request: request) { (response) in
            SVProgressHUD.dismiss()
            if response != nil && response?.status == 200 {
                self.items = (response?.entitySearch)!
                self.table.reloadData()
                
               // self.viewCount.isHidden = self.items.isEmpty
                self.lblCount.text = "\(self.items.count) Resultados"
            } else {
                Util().enviarAlerta(mensaje: .ErrorEnElServicio, titulo: .Alerta, controller: self)
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier ==  "segueMap" {
            let vc = segue.destination as! MapDetailVC
            vc.entityID = sender as? String
        }
    }
    

}

extension GeneralSearchDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellGeneralSearchDetail
        let item = items[indexPath.row]
        if let photoURL = item.foto {
            cell.imgPhoto.imageFromServerURL(urlString: photoURL, defaultImage: UIImage(named: "LOGO2"))
        } else {
            cell.imgPhoto.image = UIImage(named: "LOGO2")
        }
        cell.lblName.text = item.nombre
        cell.lblAddress.text = item.direccion
        cell.lblPhone.text = item.telefonos?.joined(separator: ",")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "segueMap", sender: items[indexPath.row].entidad_id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 120
    }
    
}

extension UINavigationBar {
    func colorBack () {
           switch Api.config_app {
           case .Colombia:
               self.tintColor = UIColor.cYelowCo()
           case .Peru:
               self.tintColor = .cgreenMenu()
           case .Mexico:
               self.tintColor = UIColor.white
           }
       }
}

extension GeneralSearchDetailVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let textStr = textField.text as NSString? {
            let txtAfterUpdate = textStr.replacingCharacters(in: range, with: string).filter { !$0.isNewline && !$0.isWhitespace }
        
            self.getEntity(name: txtAfterUpdate)
        }
        
        return true
    }
}

