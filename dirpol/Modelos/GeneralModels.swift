//
//  GeneralModels.swift
//  dirpol
//
//  Created by MYB on 07/09/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import ObjectMapper

/*
 query:{"empresa_pais_id" :  "08db1649-6601-40af-bdfc-70830d296ed9"}
 limit:5
 ascending:1
 page:1
 byColumn:1
 */
struct BussinessRequest : Mappable {
    var query : Query?
    var limit : Int = 1
    var ascending : Int = 1
    var page : Int = 1
    var byColumn : Int = 1
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: Map) {
        query <- map["query"]
        limit <- map["limit"]
        ascending <- map["ascending"]
        page <- map["page"]
        byColumn <- map["byColumn"]
    }
}

struct Query : Mappable {
    var empresa_pais_id : String?
    var pais_id : String?
    var nivel : String?
    var id_ubigeo_superior : String?
    var tipo_entidad_id : String?
    
    init?(map: Map) {}
    init() {}
    mutating func mapping(map: Map) {
        empresa_pais_id <- map["empresa_pais_id"]
        pais_id <- map["pais_id"]
        nivel <- map["nivel"]
        id_ubigeo_superior <- map["id_ubigeo_superior"]
        tipo_entidad_id <- map["tipo_entidad_id"]
    }
}

struct ResponseBusiness : Mappable {
    var data : [Business]?
    var count : Int?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        data <- map["data"]
        count <- map["count"]
    }
}

struct BusinessR : Mappable {
    var empresa_pais_id = Api.BusinessCountryID
    
    init?(map: Map) {}
    init() { }
    mutating func mapping(map: Map) {
        empresa_pais_id <- map["empresa_pais_id"]
        
    }
}


struct Business : Mappable {
    var empresa_pais_id : String?
    var empresa_id : String?
    var pais_id : String?
    var nombre : String?
    var direccion1 : String?
    var direccion2 : String?
    var contacto : String?
    var telefono : String?
    var facebook : String?
    var whatsapp : String?
    var web : String?
    var email : String?
    var ruta_imagen_credencial : String?
    var ruta_marcador_ubigeo : String?
    var logo : String?
    var iniciales_credencial : String?
    var banco_pago : String?
    var ruta_logo_banco : String?
    var tipo_cuenta : String?
    var numera_cuenta : String?
    var numero_cuenta_interbancario : String?
    var comentarios_pago : String?
    var acerca_de : String?
    var nro_noticias_permitidas : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        empresa_pais_id <- map["empresa_pais_id"]
        empresa_id <- map["empresa_id"]
        pais_id <- map["pais_id"]
        nombre <- map["nombre"]
        direccion1 <- map["direccion1"]
        direccion2 <- map["direccion2"]
        contacto <- map["contacto"]
        telefono <- map["telefono"]
        facebook <- map["facebook"]
        whatsapp <- map["whatsapp"]
        web <- map["web"]
        email <- map["email"]
        ruta_imagen_credencial <- map["ruta_imagen_credencial"]
        ruta_marcador_ubigeo <- map["ruta_marcador_ubigeo"]
        logo <- map["logo"]
        iniciales_credencial <- map["iniciales_credencial"]
        banco_pago <- map["banco_pago"]
        ruta_logo_banco <- map["ruta_logo_banco"]
        tipo_cuenta <- map["tipo_cuenta"]
        numera_cuenta <- map["numera_cuenta"]
        numero_cuenta_interbancario <- map["numero_cuenta_interbancario"]
        comentarios_pago <- map["comentarios_pago"]
        acerca_de <- map["acerca_de"]
        nro_noticias_permitidas <- map["nro_noticias_permitidas"]
    }
}


struct RequestContact : Mappable {
    var email = ""
    var asunto = ""
    var mesaje = ""
    var nombres_apellidos = ""
    var empresa_pais_id = Api.BusinessCountryID
    var empresa_id = Api.BusinessID
    var pais_id = Api.CountryID
    
    init?(map: Map) {}
    init() { }
    mutating func mapping(map: Map) {
        email <- map["email"]
        asunto <- map["asunto"]
        mesaje <- map["mesaje"]
        nombres_apellidos <- map["nombres_apellidos"]
        empresa_pais_id <- map["empresa_pais_id"]
        empresa_id <- map["empresa_id"]
        pais_id <- map["pais_id"]
        
    }
}

struct ResponseGeneral : Mappable {
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
    }
    
    var status = 0
    var message = ""
}

 

