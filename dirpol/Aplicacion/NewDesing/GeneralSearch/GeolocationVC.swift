//
//  PoliciesVC.swift
//  dirpol
//
//  Created by MYB on 02/08/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class GeolocationVC: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        table.register(UINib(nibName: "CellStation", bundle: nil), forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let svc = segue.destination as! OfficialsVC
            svc.providesPresentationContextTransitionStyle = true;
            svc.definesPresentationContext = true;
            svc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
    }
    

}

extension GeolocationVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueRepresentative", sender: nil)
    }
    
}
