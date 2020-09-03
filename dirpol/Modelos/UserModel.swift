//
//  UserModel.swift
//  dirpol
//
//  Created by Developer iOS on 9/2/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import ObjectMapper
 

struct ResponseUser : Mappable {
    var usuario : User?
    var dirpol_peru : String?
    var dirpol_peru_codigo_acreditado : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        usuario <- map["usuario"]
        dirpol_peru <- map["dirpol_peru"]
        dirpol_peru_codigo_acreditado <- map["dirpol_peru_codigo_acreditado"]
    }

}

struct User : Mappable {
    var usuario_id : String?
    var tipo_documento_identidad_id : String?
    var entidad_id : String?
    var sexo : String?
    var correlativo_credencial : String?
    var usuario : String?
    var nombres : String?
    var apellidos : String?
    var telefono : String?
    var imei : String?
    var facebook_id : String?
    var google_id : String?
    var direccion : String?
    var codigo_postal : String?
    var email : String?
    var password : String?
    var credencial : Int?
    var fecha_nacimiento : String?
    var ultimo_acceso : String?
    var fecha_alta : String?
    var fecha_caducidad : String?
    var razon_social : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        usuario_id <- map["usuario_id"]
        tipo_documento_identidad_id <- map["tipo_documento_identidad_id"]
        entidad_id <- map["entidad_id"]
        sexo <- map["sexo"]
        correlativo_credencial <- map["correlativo_credencial"]
        usuario <- map["usuario"]
        nombres <- map["nombres"]
        apellidos <- map["apellidos"]
        telefono <- map["telefono"]
        imei <- map["imei"]
        facebook_id <- map["facebook_id"]
        google_id <- map["google_id"]
        direccion <- map["direccion"]
        codigo_postal <- map["codigo_postal"]
        email <- map["email"]
        password <- map["password"]
        credencial <- map["credencial"]
        fecha_nacimiento <- map["fecha_nacimiento"]
        ultimo_acceso <- map["ultimo_acceso"]
        fecha_alta <- map["fecha_alta"]
        fecha_caducidad <- map["fecha_caducidad"]
        razon_social <- map["razon_social"]
    }

}

struct RequestLogin : Mappable {
    var usuario = ""
    var password = ""
    var remember_me = 0
    var empresa_pais_id = Api.BusinessCountryID
    var empresa_id = Api.BusinessID
    var pais_id = Api.CountryID
    
    init?(map: Map) {   }
    init() { }

       mutating func mapping(map: Map) {
        usuario <- map["usuario"]
        password <- map["password"]
        remember_me <- map["remember_me"]
        empresa_pais_id <- map["empresa_pais_id"]
        empresa_id <- map["empresa_id"]
        pais_id <- map["pais_id"]
    
    }
}

struct ResponseLogin : Mappable {
    var access_token = ""
    var token_type = ""
    var expires_at = ""
    
    init?(map: Map) {   }
    init() { }

    mutating func mapping(map: Map) {
        access_token <- map["access_token"]
        token_type <- map["token_type"]
        token_type <- map["token_type"]
    }
}

 
