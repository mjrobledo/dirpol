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

    var dirpol_colombia : String?
    var dirpol_colombia_codigo_acreditado : String?
    var avatar : String?
    
    var dirpolUrlCredential : String {
        if dirpol_peru != nil {
            return dirpol_peru!
        } else if dirpol_colombia != nil {
            return dirpol_colombia!
        }
        return ""
    }
    
    var codigoAcreditado : String {
        if dirpol_peru_codigo_acreditado != nil {
            return dirpol_peru_codigo_acreditado!
        } else if dirpol_colombia_codigo_acreditado != nil {
            return dirpol_colombia_codigo_acreditado!
        }
        return ""
    }
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        usuario <- map["usuario"]
        dirpol_peru <- map["dirpol_peru"]
        dirpol_peru_codigo_acreditado <- map["dirpol_peru_codigo_acreditado"]
        
        dirpol_colombia <- map["dirpol_colombia"]
        dirpol_colombia_codigo_acreditado <- map["dirpol_colombia_codigo_acreditado"]
        avatar <- map["avatar"]
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
    var image: UIImage?
    
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

    func getName() -> String {
        return "\((nombres)!) \((apellidos)!)"
    }
    
    var days: Int {
           let calendar = NSCalendar.current
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: self.fecha_caducidad!.date)
           let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day!
       }
}

struct RequestLogin : Mappable {
    var usuario = ""
    var password = ""
    var remember_me = 0
    var empresa_pais_id = Api.BusinessCountryID
    var empresa_id = Api.BusinessID
    var pais_id = Api.CountryID
    var imei = ""
    
    init?(map: Map) {   }
    init() { }

       mutating func mapping(map: Map) {
        usuario <- map["usuario"]
        password <- map["password"]
        remember_me <- map["remember_me"]
        empresa_pais_id <- map["empresa_pais_id"]
        empresa_id <- map["empresa_id"]
        pais_id <- map["pais_id"]
        imei <- map["imei"]
    }
}

struct ResponseLogin : Mappable {
    var access_token = ""
    var token_type = ""
    var expires_at = ""
    
    var status = 500
    var message = ""
    
    init?(map: Map) {   }
    init() { }

    mutating func mapping(map: Map) {
        access_token <- map["access_token"]
        token_type <- map["token_type"]
        token_type <- map["token_type"]
       
        status <- map["status"]
        message <- map["message"]
    }
}

struct RequestPanel : Mappable {
    var password : String?
    var password_confirmation : String?
    var email = ""
    var cambiar_password = 0
    var email_confirmation = ""
    var empresa_id = Api.BusinessID
    
    init?(map: Map) {   }
    init() { }

    mutating func mapping(map: Map) {
        password <- map["password"]
        password_confirmation <- map["password_confirmation"]
        email <- map["email"]
        email_confirmation <- map["email_confirmation"]
        empresa_id <- map["empresa_id"]
        cambiar_password <- map["cambiar_password"]
    }
}

struct ResponsePanel : Mappable {
    var message = ""
    var errors : ResponseErrorsLogin?
    
    
    init?(map: Map) {   }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
        errors <- map["errors"]
    }
}


struct ResponseErrorsLogin : Mappable {
    var password : [String] = []
    var usuario : [String] = []
    var email : [String] = []
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        password <- map["password"]
        usuario <- map["usuario"]
        email <- map["email"]
    }

}


struct ErrorsLogin : Mappable {
    var usuario : [String]?
    var password : [String]?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {
        usuario <- map["usuario"]
        password <- map["password"]
    }

}


struct ResponsePhoto : Mappable {
    var status : Int?
    var message : String?
    var photoUrl : String?

    init?(map: Map) {

    }
    mutating func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        photoUrl <- map["data"]
    }

}
