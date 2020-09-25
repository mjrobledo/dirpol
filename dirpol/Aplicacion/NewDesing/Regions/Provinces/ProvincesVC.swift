//
//  ProvincesVC.swift
//  dirpol
//
//  Created by Developer iOS on 8/11/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProvincesVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var lblDepto: UILabel!
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var imgBackground: UIImageView!
    
    var depto = ""
    var ubigeo : UbigeosModel!
    private var items: [UbigeosModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.colorBack()
        self.lblDepto.text = depto
        // Do any additional setup after loading the view.
        DispatchQueue.main.async {
            self.getUbigeos()
        }
    }
    
    private func getUbigeos() {
        SVProgressHUD.show()
        var ubigeoStr = ""
        if ubigeo != nil {
            ubigeoStr = ubigeo.ubigeo_id!
        }
        
        Singleton.instance.services.getUbigeos(nivel: "2", ubigeoSup: ubigeoStr) { (response) in
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.configScreen()
    }
    
    private func configScreen(){
        switch Api.config_app {
        case .Colombia:
            imgBackground.image = #imageLiteral(resourceName: "img_bacground_co")
        case .Peru:
            imgBackground.image = UIImage(named: "img_login")
        case .Mexico:
            imgBackground.image = UIImage(named: "img_login")
        }
    }

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueDetail" {
            let vc = segue.destination as! GeneralSearchDetailVC
            vc.ubigeoID = sender as! String
        }
    }
    
}

extension ProvincesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = items[indexPath.row].descripcion_ubigeo
        cell?.textLabel?.font = UIFont().MontserratRegular(size: 12)
        cell?.textLabel?.textColor = UIColor.darkGray
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let ubigeo_id = self.items[indexPath.row].ubigeo_id
            self.performSegue(withIdentifier: "segueDetail", sender: ubigeo_id )
        }        
    }
    
    
}
