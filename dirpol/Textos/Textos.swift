
//
//  Textos.swift
//  Proyecto
//
//  Created by DESAPP-1 on 16/03/17.
//  Copyright © 2017 Lisyx. All rights reserved.
//

import UIKit

func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}


extension String {
    
    //MARK: - Generales
    static let Si = NSLocalizedString("Si")
    static let No = NSLocalizedString("No")
    
    static let NoSeEncontraronDatos = NSLocalizedString("NoSeEncontraronDatos")
    static let ObteniendoInformacion = NSLocalizedString("ObteniendoInformacion")
    
    static let LaCuentaDeCorreoNoEsValida = NSLocalizedString("LaCuentaDeCorreoNoEsValida")
    
    
    static let CERRARSESION = NSLocalizedString("CERRARSESION")
    static let AlertaSesion = NSLocalizedString("AlertaSesion")
    
    static let Cargando = NSLocalizedString("Cargando")
    
    static let Aplicacion = NSLocalizedString("Aplicacion")
    static let Enterado = NSLocalizedString("Enterado")
    
    static let BusquedaAvanzada = NSLocalizedString("BusquedaAvanzada")
    static let AltoMandoPolicial = NSLocalizedString("AltoMandoPolicial")
    static let PanelUsuario = NSLocalizedString("PanelUsuario")
    static let AcercaDe = NSLocalizedString("AcercaDe")
    static let CerrarSesion = NSLocalizedString("CerrarSesion")
    
// MARK: - (Inicio de sesión, recupera)
    static let NoRecueraTuUsuario = NSLocalizedString("NoRecueraTuUsuario")
    static let NoRecueraTuPassword = NSLocalizedString("NoRecueraTuPassword")
    
    static let MensajePassword = NSLocalizedString("MensajePassword")
    static let MensajeUsuario = NSLocalizedString("MensajeUsuario")

    static let SeleccionaUnaOpcion = NSLocalizedString("SeleccionaUnaOpcion")
    static let Selecciona = NSLocalizedString("Selecciona")
    
    static let Alerta = NSLocalizedString("Alerta")
    static let TodosLosCamposSonObligatorios = NSLocalizedString("TodosLosCamposSonObligatorios")
    static let DebesAgregarUnCorreo = NSLocalizedString("DebesAgregarUnCorreo")
    static let FormatoCorreoInvalido = NSLocalizedString("FormatoCorreoInvalido")
    static let ParaContactarnosEsNecesario = NSLocalizedString("ParaContactarnosEsNecesario")
    
    
    static let LosCorreosNoCoinciden = NSLocalizedString("LosCorreosNoCoinciden")
    static let CorreoEnviadoCorrectamente = NSLocalizedString("CorreoEnviadoCorrectamente")
    static let ErrorEnElServicio = NSLocalizedString("ErrorEnElServicio")
    static let DebesTenerConexionInternet = NSLocalizedString("DebesTenerConexionInternet")
    static let LasContrasenasNoCoinciden = NSLocalizedString("LasContrasenasNoCoinciden")
    
    
    static let Cancelar = NSLocalizedString("Cancelar")
    
    
    static let contactos = NSLocalizedString("contactos")
}
