//
//  GalleryVC.swift
//  dirpol
//
//  Created by MYB on 12/08/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import Alamofire

class GalleryVC: UIViewController {

    @IBOutlet weak var collGallery: UICollectionView!
    
    
    var photos : [EntidadSedeFoto] = []
    var typeEntity = ""
    var division = ""
    private var photoPrincipal : EntidadSedeFoto!
    private var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoPrincipal = photos.first(where: { $0.principal == 1 })
        
        collGallery.register(UINib(nibName: "CellHeader", bundle: nil), forCellWithReuseIdentifier: "cellHeader")
        collGallery.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "cellPhoto")
        
        images.append(UIImage(named: "1")!)
        images.append(UIImage(named: "2")!)
        images.append(UIImage(named: "3")!)
        images.append(UIImage(named: "4")!)
        images.append(UIImage(named: "5")!)
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "segueZoom" {
            let svc = segue.destination as! ImageZoomVC
            let fotos : [String] = photos.map({ $0.ruta_foto! })
            svc.imgArray = fotos
        }
    }
    

}

extension GalleryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = photos[indexPath.row]
        
        if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellHeader", for: indexPath) as! CellHeader
            cell.lblType.text = self.typeEntity
            cell.lblDivision.text = self.division
            return cell
        }
        
        let cell :PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPhoto", for: indexPath) as! PhotoCell
        cell.imgGallery.image = UIImage(named: "LOGO2")
        cell.imgGallery.downloaded(from: item.ruta_foto!)
        
        
        //let img = cell.viewWithTag(1) as! UIImageView
        
        //img.image = photos[indexPath.row]
        //img.downloaded(from: item.ruta_foto!)
         
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueZoom", sender: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.row {
        case 0, 2:
            let size =  (collectionView.frame.height / 3) - 20
            print(CGSize(width: collectionView.frame.width - 3 , height: size))
            return CGSize(width: collectionView.frame.width - 3 , height: size)
        case 1:
            print(CGSize(width: collectionView.frame.width , height: 120))
            return CGSize(width: collectionView.frame.width , height: 120)
        
        default:
            let size =  (collectionView.frame.width / 3) - 3
            print(size)
            return CGSize(width: size, height: size)
        }
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
