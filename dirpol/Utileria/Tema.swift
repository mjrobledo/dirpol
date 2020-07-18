//
//  Tema.swift
//  Proyecto
//
//  Created by Ing. Miguel de Jesús Robleso on 15/03/17.
//  Copyright © 2017 Miguel Robledo. All rights reserved.
// 
// Esta clase es utilizada para anadir el tema de la aplicacion
// (Colores, Tipos de letra, imagenes, fondos de color)
//

import UIKit

struct Tema {
    
    static func configuraApariencia() {
        let navBarFont = UIFont.systemFont(ofSize: 15)
            //UIFont.systemFont(ofSize: 14.0)
       // UIFont.systemFont(ofSize: 17.0)
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.isTranslucent = false
        navBarAppearance.titleTextAttributes = [kCTForegroundColorAttributeName : UIColor.white, kCTFontAttributeName : navBarFont] as [NSAttributedStringKey : Any]
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.tintColor = UIColor.white
        navBarAppearance.barTintColor = UIColor.cPrincipal()
        
    }
}

extension UIFont{
    
    class func fTexto() -> UIFont{
        return UIFont.systemFont(ofSize: 12)
    }
    
}
extension UIColor {
    class func cPrincipal() -> UIColor {
        return UIColor(red: 45/255, green: 81/255, blue: 46/255, alpha: 1.0)
    }
    
    class func cEnfatizar() -> UIColor {
        return UIColor(red: 230/255, green: 0/255, blue: 124/255, alpha: 1.0)
    }
    
    class func cSecundarioV1() -> UIColor {
        return UIColor(red: 216/255, green: 240/255, blue: 224/255, alpha: 1.0)
    }
    class func cSecundarioV2() -> UIColor {
        return UIColor(red: 102/255, green: 196/255, blue: 133/255, alpha: 1.0)
    }
    class func cSecundarioV3() -> UIColor {
        return UIColor(red: 51/255, green: 176/255, blue: 92/255, alpha: 1.0)
    }
    class func cSecundarioV4() -> UIColor {
        return UIColor(red: 0/255, green: 105/255, blue: 34/255, alpha: 1.0)
    }
    class func cSecundarioR1() -> UIColor {
        return UIColor(red: 237/255, green: 28/255, blue: 36/255, alpha: 1.0)
    }
    class func cSecundarioR2() -> UIColor {
        return UIColor(red: 204/255, green: 11/255, blue: 19/255, alpha: 1.0)
    }
    
    class func cSecundarioN1() -> UIColor {
        return UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }
    class func cSecundarioN2() -> UIColor {
        return UIColor(red: 40/255, green: 42/255, blue: 43/255, alpha: 1.0)
    }
    class func cSecundarioN3() -> UIColor {
        return UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
    }
    class func cSecundarioN4() -> UIColor {
        return UIColor(red: 85/255, green:85/255, blue: 85/255, alpha: 1.0)
    }
    class func cSecundarioN5() -> UIColor {
        return UIColor(red: 134/255, green: 134/255, blue: 134/255, alpha: 1.0)
    }
    
    class func cSecundarioG81() -> UIColor {
        return UIColor(red: 81/255, green: 81/255, blue: 81/255, alpha: 1.0)
    }
    
    class func cSecundarioG81Alpha() -> UIColor {
        return UIColor(red: 81/255, green: 81/255, blue: 81/255, alpha: 7.0)
    }
    
    class func cSecundarioG1() -> UIColor {
        return UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
    }
    class func cSecundarioG2() -> UIColor {
        return UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
    }
    class func cSecundarioG3() -> UIColor {
        return UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1.0)
    }
    class func cSecundarioG4() -> UIColor {
        return UIColor(red: 255/255, green:255/255, blue: 255/255, alpha: 1.0)
    }
    
    
    
}
