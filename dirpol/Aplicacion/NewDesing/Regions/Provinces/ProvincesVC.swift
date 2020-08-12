//
//  ProvincesVC.swift
//  dirpol
//
//  Created by Developer iOS on 8/11/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class ProvincesVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var lblDepto: UILabel!
    
    @IBOutlet weak var txtSearch: UITextField!
    
    var depto = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblDepto.text = depto
        // Do any additional setup after loading the view.
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

extension ProvincesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = "Provinica \(indexPath.row)"
        cell?.textLabel?.font = UIFont().MontserratRegular(size: 12)
        cell?.textLabel?.textColor = UIColor.darkGray
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "segueDetail", sender: nil)
        }        
    }
    
    
}
