/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Sector_entidad : Mappable {
	var sector_entidad_id : String?
	var segmento_entidad_id : String?
	var poder_gobierno_id : String?
	var descripcion_sector : String?
	var activo : Int?
	var poder_gobierno : Poder_gobierno?
	var segmento_entidad : Segmento_entidad?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		sector_entidad_id <- map["sector_entidad_id"]
		segmento_entidad_id <- map["segmento_entidad_id"]
		poder_gobierno_id <- map["poder_gobierno_id"]
		descripcion_sector <- map["descripcion_sector"]
		activo <- map["activo"]
		poder_gobierno <- map["poder_gobierno"]
		segmento_entidad <- map["segmento_entidad"]
	}

}