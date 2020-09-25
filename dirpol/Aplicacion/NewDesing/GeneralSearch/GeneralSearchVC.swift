//
//  GeneralSearchVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/29/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import SVProgressHUD

class GeneralSearchVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txtSearch: UITextField!
    
    @IBOutlet weak var btnBack: UIBarButtonItem!
    
    private var items: [EntitySearch] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.colorBack()
        table.register(UINib(nibName: "CellGeneralSearch", bundle: nil), forCellReuseIdentifier: "cell")
        table.estimatedRowHeight =  35
    }
    
    private func getEntity(name: String) {
        var request = RequestEntitySearch()
        request.nombre = name
        SVProgressHUD.show()
        print(request.toJSONString(prettyPrint: false))
        Singleton.instance.services.getEntity(request: request) { (response) in
            SVProgressHUD.dismiss()
            if response != nil && response?.status == 200 {
                self.items = (response?.entitySearch)!
                self.table.reloadData()
            }
        }
    }
    
    @IBAction func search(_ sender: Any) {
        if !txtSearch.text!.isEmpty {
            self.performSegue(withIdentifier: "segueSearchDetail", sender: nil)
        } else {
            print("is empty")
        }
    }
    

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Navigation
 
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueSearchDetail" {
            let vc = segue.destination as! GeneralSearchDetailVC
            vc.search = (txtSearch.text?.trim())!
        } else if segue.identifier ==  "segueMap" {
            let vc = segue.destination as! MapDetailVC
                vc.entityID = sender as? String
        }
    }
}

extension GeneralSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        table.isHidden = items.count == 0 ? true : false
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueMap", sender: items[indexPath.row].entidad_id)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CellGeneralSearch
        cell.lblName.text = items[indexPath.row].nombre
        
        return cell
    }
}

extension GeneralSearchVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let textStr = textField.text as NSString? {
            let txtAfterUpdate = textStr.replacingCharacters(in: range, with: string).filter { !$0.isNewline && !$0.isWhitespace }
        
            self.getEntity(name: txtAfterUpdate)
        }
        
        return true
    }
}
