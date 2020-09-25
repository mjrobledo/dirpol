/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct TypeEntityResponse : Mappable {
	var data : [TypeEntity]?
	var count : Int?
	var status : Int?

	init?(map: Map) { }

	mutating func mapping(map: Map) {
		data <- map["data"]
		count <- map["count"]
		status <- map["status"]
	}
}

class TypeEntity : Mappable {
    var tipo_entidad_id : String?
    var descripcion : String?
    var ruta_icono_seleccionado : String?
    var ruta_icono_deseleccionado : String?
    var ruta_icono_marcador : String?
    var pais_id : String?

    var selected = false
    required init?(map: Map) { }

    func mapping(map: Map) {

        tipo_entidad_id <- map["tipo_entidad_id"]
        descripcion <- map["descripcion"]
        ruta_icono_seleccionado <- map["ruta_icono_seleccionado"]
        ruta_icono_deseleccionado <- map["ruta_icono_deseleccionado"]
        ruta_icono_marcador <- map["ruta_icono_marcador"]
        pais_id <- map["pais_id"]
    }

}


class UbigeosResponse : Mappable {
    var data : [UbigeosModel] = []
    var count = 0
    var status = 0
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        data <- map["data"]
        count <- map["count"]
        status <- map["status"]
    }
}

class UbigeosModel : Mappable {
    var ubigeo_id : String?
    var pais_id : String?
    var id_ubigeo_superior : String?
    var codigo_ubigeo : String?
    var ubigeo_id_padre : String?
    var descripcion_ubigeo : String?
    var latitud : String?
    var longitud : String?
    var nivel : Int?
    var nivel_geografico_id : String?

    required init?(map: Map) { }
    init() { }
    func mapping(map: Map) {
        ubigeo_id <- map["ubigeo_id"]
        pais_id <- map["pais_id"]
        id_ubigeo_superior <- map["id_ubigeo_superior"]
        codigo_ubigeo <- map["codigo_ubigeo"]
        ubigeo_id_padre <- map["ubigeo_id_padre"]
        descripcion_ubigeo <- map["descripcion_ubigeo"]
        latitud <- map["latitud"]
        longitud <- map["longitud"]
        nivel <- map["nivel"]
        nivel_geografico_id <- map["nivel_geografico_id"]
    }
}


struct ResponseNivel : Mappable {
    var data : [NivelModel]?
    var count : Int?
    var status : Int?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        data <- map["data"]
        count <- map["count"]
        status <- map["status"]
    }
}

struct NivelModel : Mappable {
    var nivel_geografico_id = ""
    var pais_id = ""
    var descripcion = ""
    var nivel : Int?
    
    init?(map: Map) {}
    init() {}
    mutating func mapping(map: Map) {
        nivel_geografico_id <- map["nivel_geografico_id"]
        pais_id <- map["pais_id"]
        descripcion <- map["descripcion"]
        nivel <- map["nivel"]
    }
}


class SedesResponse : Mappable {
    var data : [SedeModel] = []
    var count = 0
    var status = 0
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        data <- map["data"]
        count <- map["count"]
        status <- map["status"]
    }
}

class SedeModel : Mappable {
    var entidad_id : String?
    var razon_social : String?
    var pais_id : String?
    var ubigeo_id : String?
    
    var latitud : String?
    var longitud : String?
    var tipo_entidad_id : String?
    var ruta_icono_marcador : String?

    required init?(map: Map) { }

    func mapping(map: Map) {
        entidad_id <- map["entidad_id"]
        razon_social <- map["razon_social"]
        pais_id <- map["pais_id"]
        ubigeo_id <- map["ubigeo_id"]
        
        
        latitud <- map["latitud"]
        longitud <- map["longitud"]
        tipo_entidad_id <- map["tipo_entidad_id"]
        ruta_icono_marcador <- map["ruta_icono_marcador"]
    }
}
