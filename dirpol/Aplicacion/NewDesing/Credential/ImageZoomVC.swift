//
//  ImageZoomVC.swift
//  dirpol
//
//  Created by MYB on 02/08/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class ImageZoomVC: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var myCollectionView: UICollectionView!
    @IBOutlet weak var btnClose: UIButton!
    var imgArray: [String] = []
    var passedContentOffset = IndexPath()
    
    override func viewDidLoad() {
    super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.btnClose.setTitleColor(.cPrincipal(), for: .normal)
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal

        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(ImagePreviewFullViewCell.self, forCellWithReuseIdentifier: "Cell")
        myCollectionView.isPagingEnabled = true
        DispatchQueue.main.async {
            self.myCollectionView.selectItem(at: self.passedContentOffset, animated: false, scrollPosition: .left)
            }
        self.view.addSubview(myCollectionView)
        self.view.sendSubviewToBack(myCollectionView)
        myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if let tabBarController = window?.rootViewController as? UITabBarController {
            if let tabBarViewControllers = tabBarController.viewControllers {
                if let projectsNavigationController = tabBarViewControllers[1] as? UINavigationController {
                    if projectsNavigationController.visibleViewController is ImageZoomVC {
                        return .all
                    }
                }
            }
        }
        return .landscape
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImagePreviewFullViewCell

                
                //cell.imgView.image = imgArray[indexPath.row]
        cell.imgView.imageFromServerURL(urlString: imgArray[indexPath.row], defaultImage: UIImage(named: "LOGO2"))
                return cell
            }

            override func viewWillLayoutSubviews() {
                super.viewWillLayoutSubviews()

                guard let flowLayout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
                flowLayout.itemSize = myCollectionView.frame.size
                flowLayout.invalidateLayout()

                myCollectionView.collectionViewLayout.invalidateLayout()
            }

            override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
                super.viewWillTransition(to: size, with: coordinator)
                let offset = myCollectionView.contentOffset
                let width = myCollectionView.bounds.size.width

                let index = round(offset.x / width)
                let newOffset = CGPoint(x: index * size.width, y: offset.y)

                myCollectionView.setContentOffset(newOffset, animated: false)

                coordinator.animate(alongsideTransition: { (context) in
                    self.myCollectionView.reloadData()

                    self.myCollectionView.setContentOffset(newOffset, animated: false)
                }, completion: nil)
            }
        }


        class ImagePreviewFullViewCell: UICollectionViewCell, UIScrollViewDelegate {
            var scrollImg: UIScrollView!
            var imgView: UIImageView!

            override init(frame: CGRect) {
                super.init(frame: frame)

                scrollImg = UIScrollView()
                scrollImg.delegate = self
                scrollImg.alwaysBounceVertical = false
                scrollImg.alwaysBounceHorizontal = false
                scrollImg.showsVerticalScrollIndicator = true
                scrollImg.flashScrollIndicators()

                scrollImg.minimumZoomScale = 1.0
                scrollImg.maximumZoomScale = 4.0

                let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
                doubleTapGest.numberOfTapsRequired = 2
                scrollImg.addGestureRecognizer(doubleTapGest)

                self.addSubview(scrollImg)

                imgView = UIImageView()
                imgView.image = UIImage(named: "user3")
                scrollImg.addSubview(imgView!)
                imgView.contentMode = .scaleAspectFit
            }

            @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
                if scrollImg.zoomScale == 1 {
                    scrollImg.zoom(to: zoomRectForScale(scale: scrollImg.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
                } else {
                    scrollImg.setZoomScale(1, animated: true)
                }
            }

            func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
                var zoomRect = CGRect.zero
                zoomRect.size.height = imgView.frame.size.height / scale
                zoomRect.size.width = imgView.frame.size.width / scale
                let newCenter = imgView.convert(center, from: scrollImg)
                zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
                zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
                return zoomRect
            }

            func viewForZooming(in scrollView: UIScrollView) -> UIView? {
                return self.imgView
            }

            override func layoutSubviews() {
                super.layoutSubviews()
                scrollImg.frame = self.bounds
                imgView.frame = self.bounds
            }

            override func prepareForReuse() {
                super.prepareForReuse()
                scrollImg.setZoomScale(1, animated: true)
            }

            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            
            
        }
