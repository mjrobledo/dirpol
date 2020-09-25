//
//  OfficialsVC.swift
//  dirpol
//
//  Created by MYB on 09/08/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class OfficialsVC: UIViewController {
    @IBOutlet weak var table: UITableView!
    
    var people : EntidadPersonal!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPositionCompany: UILabel!
    @IBOutlet weak var lblDescriptionPosition: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblName.text = people.personal?.getName()
        lblPositionCompany.text = people.cargo?.descripcion_cargo
        lblDescriptionPosition.text = people.descripcion_cargo
        
        table.register(UINib(nibName: "CellOfficials", bundle: nil), forCellReuseIdentifier: "cell")
        table.estimatedRowHeight = 40
        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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

extension OfficialsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let p = people.personal {
            return p.personalTelefonos.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellOfficials
        cell.cornerRadius = 8
        let p = people.personal?.personalTelefonos[indexPath
            .row]
        cell.lblName.text = p?.telefono
        
        return cell
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableView.automaticDimension
    }
    
     
    
}

