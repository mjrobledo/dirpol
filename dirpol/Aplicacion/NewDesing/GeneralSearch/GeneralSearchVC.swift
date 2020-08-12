//
//  GeneralSearchVC.swift
//  dirpol
//
//  Created by Developer iOS on 7/29/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class GeneralSearchVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var imgLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(UINib(nibName: "CellGeneralSearch", bundle: nil), forCellReuseIdentifier: "cell")

    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

extension GeneralSearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 30
        table.isHidden = count == 0 ? true : false
        
        return count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueSearchDetail", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        return cell!
    }
    
}
