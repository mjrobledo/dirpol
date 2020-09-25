/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Pais : Mappable {
	var pais_id : String?
	var descripcion : String?
	var nacionalidad : String?
	var abreviatura : String?
	var codigo_area : String?
	var bandera : String?
	var mascara_telefono_fijo : String?
	var mascara_telefono_celular : String?
	var latitud : String?
	var longitud : String?
	var activo : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		pais_id <- map["pais_id"]
		descripcion <- map["descripcion"]
		nacionalidad <- map["nacionalidad"]
		abreviatura <- map["abreviatura"]
		codigo_area <- map["codigo_area"]
		bandera <- map["bandera"]
		mascara_telefono_fijo <- map["mascara_telefono_fijo"]
		mascara_telefono_celular <- map["mascara_telefono_celular"]
		latitud <- map["latitud"]
		longitud <- map["longitud"]
		activo <- map["activo"]
	}

}