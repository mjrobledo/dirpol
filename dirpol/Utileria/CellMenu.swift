//
//  CellMenu.swift
//  Proyecto
//
//  Created by DESAPP-1 on 29/03/17.
//  Copyright © 2017 Lisyx. All rights reserved.
//

import UIKit

class CellMenu: UICollectionViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    var lblTitulo: UILabel!
    var lblIndicador: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        lblTitulo = UILabel(frame: CGRect(x:0, y:5, width: frame.size.width, height: frame.size.height/2))
        lblTitulo.font = UIFont.fTexto()
        lblTitulo.textAlignment = .center
        contentView.addSubview(lblTitulo)
        
        lblIndicador =  UILabel(frame:  CGRect(x: 0, y: frame.size.height-4, width: frame.size.width, height: 4))
            contentView.addSubview(lblIndicador)
       
     }      
    
}
