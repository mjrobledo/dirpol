/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Entidad_numero_empleado : Mappable {
	var entidad_numero_empleado_id : String?
	var entidad_id : String?
	var periodo_tributario : String?
	var numero_trabajadores : String?
	var numero_pensionistas : String?
	var numero_prestadores_servicios : String?
	var principal : Int?
	var activo : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		entidad_numero_empleado_id <- map["entidad_numero_empleado_id"]
		entidad_id <- map["entidad_id"]
		periodo_tributario <- map["periodo_tributario"]
		numero_trabajadores <- map["numero_trabajadores"]
		numero_pensionistas <- map["numero_pensionistas"]
		numero_prestadores_servicios <- map["numero_prestadores_servicios"]
		principal <- map["principal"]
		activo <- map["activo"]
	}

}