//
//  CollMenu.swift
//  Proyecto
//
//  Created by DESAPP-1 on 30/03/17.
//  Copyright © 2017 Lisyx. All rights reserved.
//

import UIKit

@objc protocol MenuDelegate {
    func menuSeleccionado(index:Int)
}

class CollMenu: UICollectionView,  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var delegateMenu:MenuDelegate?
    
    var menu:[String] = ["Menu 1","Menu 2", "Menu 3"]
        var menuSelec = 0
    var imagenes = false
    
    func initClass(){
        self.register(CellMenu.self, forCellWithReuseIdentifier: "CellMenu")
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
    }
    
    override func draw(_ rect: CGRect) {
        initClass()
        
        self.delegate = self
        self.dataSource = self
        self.reloadData()
    }
    
    /***********************************************************************************
     *                              Metodos de CollectionView                          *
     ***********************************************************************************/
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellMenu", for: indexPath) as! CellMenu
        
            cell.lblTitulo.text = menu[indexPath.row]
            cell.lblTitulo.textColor = UIColor.cPrincipal()
            if menuSelec == indexPath.row{
                cell.lblIndicador.backgroundColor = UIColor.cPrincipal()
                cell.lblTitulo.font = UIFont.boldSystemFont(ofSize: 15)
            }else{
                cell.lblIndicador.backgroundColor = UIColor.clear
                cell.lblTitulo.font = UIFont.systemFont(ofSize: 14)
            }
        
        return cell
        
           }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuSelec = indexPath.row
        self.reloadData()
        delegateMenu?.menuSeleccionado(index: indexPath.row)
    }
    
    /** Devuelve el tamaño de la celda dependeiendo la cantidad de columnas y filas que se requiera*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numero_col:CGFloat = CGFloat(menu.count)
        let numero_fila:CGFloat = 1
        
        
        /* Divide el ancho del collectionView entre el número de columnas menos el esapcio entre celdas*/
        let anchura = (collectionView.bounds.size.width/numero_col) - 1
        
        /* Divide el alto del collectionView entre el número de columnas menos el esapcio entre celdas*/
        let altura = (collectionView.bounds.size.height/numero_fila)
        return CGSize(width: anchura , height: altura)
    }

    
    /*****************************      FIN COLLECTIONVIEW          *****************************/
    

}
