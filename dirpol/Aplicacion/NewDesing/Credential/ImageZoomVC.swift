//
//  ImageZoomVC.swift
//  dirpol
//
//  Created by MYB on 02/08/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class ImageZoomVC: UIViewController , UIScrollViewDelegate{

    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var imgPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrolView.delegate = self
        scrolView.minimumZoomScale = 1.0
        scrolView.maximumZoomScale = 10.0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return imgPhoto
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
