/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct EntidadTelefono : Mappable {
	var entidad_telefono_id : String?
	var entidad_id : String?
	var sede_id : String?
	var tipo_telefono_id : String?
	var telefono : String?
	var anexo : String?
	var principal : Int?
	var activo : Int?
	var tipo_telefono : Tipo_telefono?

	init?(map: Map) {
	}

	mutating func mapping(map: Map) {

		entidad_telefono_id <- map["entidad_telefono_id"]
		entidad_id <- map["entidad_id"]
		sede_id <- map["sede_id"]
		tipo_telefono_id <- map["tipo_telefono_id"]
		telefono <- map["telefono"]
		anexo <- map["anexo"]
		principal <- map["principal"]
		activo <- map["activo"]
		tipo_telefono <- map["tipo_telefono"]
	}
}

struct Tipo_telefono : Mappable {
    var tipo_telefono_id : String?
    var descripcion : String?
    var activo : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        tipo_telefono_id <- map["tipo_telefono_id"]
        descripcion <- map["descripcion"]
        activo <- map["activo"]
    }

}
