//
//  ModeloServicios.swift
//  dirpol
//
//  Created by macbook on 21/09/18.
//  Copyright © 2018 gravittas. All rights reserved.
//

import UIKit
import ObjectMapper


class Region: NSObject , Mappable{
    
    var Id = 0
    var Nombre = ""
    var Latitud = 0.0
    var Longitud = 0.0
    
    var seleccionada = false
    func mapping(map: Map) {
        Id <- map["id"]
        Nombre <- map["nombre"]
        Latitud <- map["latitud"]
        Longitud <- map["longitud"]
    }
    override init() {}
    required init?(map: Map) {}
    
    func getRegionesDummies() -> [Region]{
        var regiones:[Region] = []
        
        let r = Region()
        r.Id = 1
        r.Nombre = "Amazonas"
        r.Latitud =  -12.117644912560646
        r.Longitud = -76.91938053437502
        regiones.append(r)
        
        let r2 = Region()
        r2.Id = 2
        r2.Nombre = "Ancash"
        r2.Latitud = -11.822090386905073
        r2.Longitud = -76.79303776093752
        regiones.append(r2)
        /*
        let r3 = Region()
        r3.Id = 3
        r3.Nombre = "Apurúmac"
        r3.Latitud = -12.455786972098084
        r3.Longitud = -76.51288639375002
        regiones.append(r3)
        
        let r4 = Region()
        r4.Id = 4
        r4.Nombre = "Arequipa"
        r4.Latitud = -11.0478158
        r4.Longitud = -78.0622028
        regiones.append(r4)
        
        let r5 = Region()
        r5.Id = 5
        r5.Nombre = "Ayacucho"
        r5.Latitud = -12.0478158
        r5.Longitud = -77.0622028
        regiones.append(r5)
        
        */
        return regiones
    }
    
    func getProvinciaDummies() -> [Region]{
        var regiones:[Region] = []
        
      /*  let r = Region()
        r.Id = 1
        r.Nombre = "Chachapoyas"
        r.Latitud = -12.117644912560646
        r.Longitud = -76.91938053437502
        regiones.append(r)
        
        let r2 = Region()
        r2.Id = 2
        r2.Nombre = "Bagua"
        r2.Latitud = -11.822090386905073
        r2.Longitud = -76.79303776093752
        regiones.append(r2)
        
        let r3 = Region()
        r3.Id = 3
        r3.Nombre = "Condorcanqui"
        r3.Latitud = -12.455786972098084
        r3.Longitud = -76.51288639375002
        regiones.append(r3)
        
        let r4 = Region()
        r4.Id = 4
        r4.Nombre = "Luya"
        r4.Latitud = -11.0478158
        r4.Longitud = -78.0622028
        regiones.append(r4)
        
        let r5 = Region()
        r5.Id = 5
        r5.Nombre = "Utcubamba"
        r5.Latitud = -12.0478158
        r5.Longitud = -77.0622028
        regiones.append(r5)
        
        */
        return regiones
    }
    
}

// MARK: - Inicio de sesion
/*class RequestLogin: NSObject , Mappable{
    var usuario = ""
    var password = ""
    
    func mapping(map: Map) {
        usuario <- map["usuario"]
        password <- map["password"]
    }
    override init() {}
    required init?(map: Map) {}
}*/

class RespuestaLogin: NSObject , Mappable{
    var Mensaje = ""
    var Codigo = "0"
    var Usuario:Usuario!
    
    func mapping(map: Map) {
        Mensaje <- map["mensaje"]
        Codigo <- map["codigo"]
        Usuario <- map["datos"]
    }
    override init() {}
    required init?(map: Map) {}
}

class RespuestaBGoogle: NSObject , Mappable{
    var Mensaje = ""
    var Codigo = "0"
    var Datos:[InstitucionFuncionario] = []
    
    func mapping(map: Map) {
        Mensaje <- map["mensaje"]
        Codigo <- map["codigo"]
        Datos <- map["datos"]
    }
    override init() {}
    required init?(map: Map) {}
}

class InstitucionFuncionario: NSObject , Mappable{
    var Id = 0
    var Nombre = ""
    var Tipo = 0
    var IdInstDistricto = 0
    
    func mapping(map: Map) {
        Id <- map["id"]
        Nombre <- map["nombre"]
        Tipo <- map["tipo"]
        IdInstDistricto <- map["idInstitucion"]
    }
    
    override init() {}
    required init?(map: Map) {}
}


class Usuario: NSObject , Mappable{
    var Id = 0
    var Nombre = ""
    var Email = ""
    var Username = ""
    var Password = ""
    
    func mapping(map: Map) {
        Id <- map["id"]
        Nombre <- map["nombre"]
        Email <- map["email"]
        Username <- map["username"]
        Password <- map["password"]
    }
    override init() {}
    required init?(map: Map) {}

    func getUsuarioPrueba() -> Usuario {
        let Us = Usuario()
        Us.Email = "29884@dirpol.com.pe"
        Us.Id = 989
        Us.Nombre = "CLINICA AREQUIPA S.A."
        Us.Username = "29884"
        
        return Us
    }
}


// MARK: - Instituciones
class respuestaInstitucion: NSObject , Mappable{
    var Mensaje = ""
    var Codigo = "0"
    var Datos:Institucion!
    
    func mapping(map: Map) {
        Mensaje <- map["mensaje"]
        Codigo <- map["codigo"]
        Datos <- map["datos"]
    }
    override init() {}
    required init?(map: Map) {}
}

class Institucion: NSObject , Mappable{
    var Id = ""
    var Telefonos:[String] = []
    var Direccion = ""
    var Cargo = ""
    var NombreFuncionario = ""
    var Districto = ""
    
    var Latitud = 0.0
    var Longitud = 0.0
    var Descripcion = ""
    
    func mapping(map: Map) {
        Id <- map["id"]
        Telefonos <- map["telefonos"]
        Descripcion <- map["descripcion"]
        Direccion <- map["direccion"]
        Cargo <- map["cargo"]
        NombreFuncionario <- map["funcionario"]
        Districto <- map["districto"]
        
        Latitud <- map["latitud"]
        Longitud <- map["longitud"]
        
    }
    override init() {}
    required init?(map: Map) {}
}


class requesData: NSObject , Mappable{
    
    var Mensaje = ""
    func mapping(map: Map) {
        Mensaje <- map["mensaje"]
    }
    override init() {}
    required init?(map: Map) {}
}

class respuestaGenerica: NSObject , Mappable{
    
    var Mensaje = ""
    var Codigo = "0"
    func mapping(map: Map) {
        Mensaje <- map["mensaje"]
        Codigo <- map["codigo"]
    }
    override init() {}
    required init?(map: Map) {}
}

// MARK: - Contactanos
class requestContacto: NSObject , Mappable{
    var Nombre = ""
    var Email = ""
    var Contacto = ""
    var Tema = ""
    var Mensaje = ""
    func mapping(map: Map) {
        Nombre <- map["nombre"]
        Email <- map["email"]
        Contacto <- map["contacto"]
        Tema <- map["tema"]
        Mensaje <- map["mensaje"]
    }
    override init() {}
    required init?(map: Map) {}
}


// MARK: * Provincia - Instituciones
class respuestaProvInst: NSObject , Mappable{
    var Mensaje = ""
    var Codigo = "0"
    var Datos:Institucion!
    
    func mapping(map: Map) {
        Mensaje <- map["mensaje"]
        Codigo <- map["codigo"]
        Datos <- map["datos"]
    }
    override init() {}
    required init?(map: Map) {}
}


// MARK: - Direccion
class Direccion: NSObject , Mappable{
    var Id = ""
    var Institucion = ""
    var Direccion = ""
    var Latitud = ""
    var Longitud = ""
    var IdDistrito = ""
    var Distrito = ""
    
    func mapping(map: Map) {
        Id <- map["id"]
        Institucion <- map["institucion"]
        Direccion <- map["direccion"]
        Latitud <- map["lat"]
        Longitud <- map["lng"]
        IdDistrito <- map["idDistricto"]
        Distrito <- map["districto"]
    }
    override init() {}
    required init?(map: Map) {}
    
    
}


// MARK: - Busqueda avanzada
class RequestBusqueda: NSObject , Mappable{
    var TextoBusqueda = ""
    var Entrada = 1
    var IdCategoria :[Int] = []
    
    func mapping(map: Map) {
        TextoBusqueda <- map["texto"]
        Entrada <- map["entrada"]
        IdCategoria <- map["idProvincia"]
    }
    override init() {}
    required init?(map: Map) {}
    
    
}

class RespuestaBAvanzada: NSObject , Mappable{
    var Mensaje = ""
    var Codigo = "0"
    var Datos:[Institucion] = []
    
    func mapping(map: Map) {
        Mensaje <- map["mensaje"]
        Codigo <- map["codigo"]
        Datos <- map["datos"]
    }
    override init() {}
    required init?(map: Map) {}
}






/*
 '1', 'Amazonas', '-12.117644912560646', '-76.91938053437502'
 '2', 'Ancash', '-11.822090386905073', '-76.79303776093752'
 '3', 'ApurÃ­mac', '-12.455786972098084', '-76.51288639375002'
 '4', 'Arequipa', '-12.0478158', '-77.0622028'
 '5', 'Ayacucho', '-12.0478158', '-77.0622028'

 */
