/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Entidad_sedes : Mappable {
	var sede_id : String?
	var entidad_id : String?
	var tipo_establecimiento_id : String?
	var actividad_contribuyente_id : String?
	var ubigeo_id : String?
	var descripcion_sede : String?
	var direccion : String = ""
	var codigo_establecimiento_tributario : String?
	var tipo_establecimiento_auto : String?
	var actividad_economica_auto : String?
	var latitud : String?
	var longitud : String?
	var principal : Int?
	var activo : Int?
	var fecha_desde : String?
	var tipo_establecimiento : Tipo_establecimiento?
	var actividad_contribuyente : Actividad_contribuyente?
	var ubigeo : Ubigeo?
	var entidad_correo : [EntidadCorreo]?
	var entidad_personal : [EntidadPersonal]?
	var entidad_red_social : [EntidadRedSocial]?
	var entidad_sede_foto : [EntidadSedeFoto]?
	var entidad_sede_url : [EntidadSedeUrl]?
	var entidad_sede_telefono : [EntidadTelefono]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		sede_id <- map["sede_id"]
		entidad_id <- map["entidad_id"]
		tipo_establecimiento_id <- map["tipo_establecimiento_id"]
		actividad_contribuyente_id <- map["actividad_contribuyente_id"]
		ubigeo_id <- map["ubigeo_id"]
		descripcion_sede <- map["descripcion_sede"]
		direccion <- map["direccion"]
		codigo_establecimiento_tributario <- map["codigo_establecimiento_tributario"]
		tipo_establecimiento_auto <- map["tipo_establecimiento_auto"]
		actividad_economica_auto <- map["actividad_economica_auto"]
		latitud <- map["latitud"]
		longitud <- map["longitud"]
		principal <- map["principal"]
		activo <- map["activo"]
		fecha_desde <- map["fecha_desde"]
		tipo_establecimiento <- map["tipo_establecimiento"]
		actividad_contribuyente <- map["actividad_contribuyente"]
		ubigeo <- map["ubigeo"]
		entidad_correo <- map["entidad_correo"]
		entidad_personal <- map["entidad_personal"]
		entidad_red_social <- map["entidad_red_social"]
		entidad_sede_foto <- map["entidad_sede_foto"]
		entidad_sede_url <- map["entidad_sede_url"]
		entidad_sede_telefono <- map["entidad_sede_telefono"]
	}

    func getAddress() -> String {
        if self.ubigeo != nil {
            return "\(self.direccion) \((self.ubigeo?.descripcion_ubigeo)!)"
        }
        return "\(self.direccion)"
    }
}

struct EntidadCorreo : Mappable {
    var entidad_correo_id : String?
    var entidad_id : String?
    var sede_id : String?
    var correo : String?
    var principal : Int?
    
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        entidad_correo_id <- map["entidad_correo_id"]
        entidad_id <- map["entidad_id"]
        sede_id <- map["sede_id"]
        correo <- map["correo"]
        principal <- map["principal"]
    }
}


struct EntidadSedeFoto : Mappable {
    var entidad_foto_id : String?
    var entidad_id : String?
    var ruta_foto : String?
    var activo : Int?
    var principal : Int?
    
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        entidad_foto_id <- map["entidad_foto_id"]
        entidad_id <- map["entidad_id"]
        ruta_foto <- map["ruta_foto"]
        activo <- map["activo"]
        principal <- map["principal"]
    }
}

struct EntidadSedeUrl : Mappable {
    var entidad_sede_url_id : String?
    var entidad_id : String?
    var sede_id : String?
    var url : String?
    var principal : Int?
    var activo : Int?
    
    init?(map: Map) {
    }

    mutating func mapping(map: Map) {
        entidad_sede_url_id <- map["entidad_sede_url_id"]
        entidad_id <- map["entidad_id"]
        sede_id <- map["sede_id"]
        url <- map["url"]
        principal <- map["principal"]
        activo <- map["activo"]
    }
}
 
