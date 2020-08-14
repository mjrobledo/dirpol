//
//  GalleryVC.swift
//  dirpol
//
//  Created by MYB on 12/08/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class GalleryVC: UIViewController {

    @IBOutlet weak var collGallery: UICollectionView!
    
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        images.append(UIImage(named: "1")!)
        images.append(UIImage(named: "2")!)
        images.append(UIImage(named: "3")!)
        images.append(UIImage(named: "4")!)
        images.append(UIImage(named: "5")!)
            
        
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

extension GalleryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let img = cell.viewWithTag(1) as! UIImageView
        img.image = images[indexPath
            .row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let img = images[indexPath.row]
        
        return CGSize(width: img.size.width , height: img.size.height)
    }
    
}
