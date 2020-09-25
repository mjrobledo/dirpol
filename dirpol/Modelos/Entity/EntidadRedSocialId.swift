/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct EntidadRedSocial : Mappable {
	var entidad_red_social_id : String?
	var red_social_id : String?
	var entidad_id : String?
	var sede_id : String?
	var direccion : String?
	var principal : Int?
	var activo : Int?
	var red_social : Red_social?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		entidad_red_social_id <- map["entidad_red_social_id"]
		red_social_id <- map["red_social_id"]
		entidad_id <- map["entidad_id"]
		sede_id <- map["sede_id"]
		direccion <- map["direccion"]
		principal <- map["principal"]
		activo <- map["activo"]
		red_social <- map["red_social"]
	}

}
