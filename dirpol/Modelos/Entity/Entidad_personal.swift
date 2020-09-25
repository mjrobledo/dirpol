/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct EntidadPersonal : Mappable {
	var entidad_personal_id : String?
	var entidad_id : String?
	var sede_id : String?
	var cargo_id : String?
	var area_administrativa_id : String?
	var descripcion_cargo : String?
	var fecha_desde : String?
	var principal : Int?
	var activo : Int?
	var cargo : Cargo?
	var area_administrativa : Area_administrativa?
    var personal : Personal?
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		entidad_personal_id <- map["entidad_personal_id"]
		entidad_id <- map["entidad_id"]
		sede_id <- map["sede_id"]
		cargo_id <- map["cargo_id"]
		area_administrativa_id <- map["area_administrativa_id"]
		descripcion_cargo <- map["descripcion_cargo"]
		fecha_desde <- map["fecha_desde"]
		principal <- map["principal"]
		activo <- map["activo"]
		cargo <- map["cargo"]
		area_administrativa <- map["area_administrativa"]
        personal <- map["personal"]
	}
    
    

}

struct Personal : Mappable {
    var personal_id : String?
    var tipo_documento_identidad_id : String?
    var titulo_id : String?
    var numero_documento : String = ""
    var apellido_paterno : String = ""
    var apellido_materno : String = ""
    var nombres : String = ""
    
    var activo : Int?
    var titulo : Titulo?
    var personalTelefonos: [PersonalTelefonos] = []
    
    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        personal_id <- map["personal_id"]
        tipo_documento_identidad_id <- map["tipo_documento_identidad_id"]
        titulo_id <- map["titulo_id"]
        numero_documento <- map["numero_documento"]
        apellido_paterno <- map["apellido_paterno"]
        apellido_materno <- map["apellido_materno"]
        nombres <- map["nombres"]
        
        activo <- map["activo"]
        titulo <- map["titulo"]
        personalTelefonos <- map["personal_telefonos"]
    }
    
    func getName() -> String {
        return "\(nombres) \(apellido_paterno) \(apellido_materno)"
    }
}

struct Titulo : Mappable {
    init?(map: Map) { }
    
    var titulo_id : String?
    var descripcion : String?
    var abreviatura : String?
    var observacion : String?
    
    mutating func mapping(map: Map) {
        titulo_id <- map["titulo_id"]
        descripcion <- map["descripcion"]
        abreviatura <- map["abreviatura"]
        observacion <- map["observacion"]
    }
}

struct PersonalTelefonos : Mappable {
    init?(map: Map) { }
    
    var entidad_telefono_id : String?
    var telefono : String?
    var anexo : String?
    var principal : Int?
    
    mutating func mapping(map: Map) {
        entidad_telefono_id <- map["entidad_telefono_id"]
        telefono <- map["telefono"]
        anexo <- map["anexo"]
        principal <- map["principal"]
    }
}



