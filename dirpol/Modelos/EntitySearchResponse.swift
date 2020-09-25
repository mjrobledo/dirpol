/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct RequestEntitySearch : Mappable {
    var limit = 10
    var offsset = 0
    var nombre = ""
    var pais_id = Api.CountryID
    var ubigeo_id = ""
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: Map) {
        limit <- map["limit"]
        offsset <- map["offsset"]
        nombre <- map["nombre"]
        pais_id <- map["pais_id"]
        ubigeo_id <- map["ubigeo_id"]
    }
}

struct EntitySearchResponse : Mappable {
	var entitySearch : [EntitySearch]?
	var count : Int?
	var limit : String?
	var offsset : String?
	var status : Int?

	init?(map: Map) { }

	mutating func mapping(map: Map) {
		entitySearch <- map["data"]
		count <- map["count"]
		limit <- map["limit"]
		offsset <- map["offsset"]
		status <- map["status"]
	}
}

struct EntitySearch : Mappable {
    var entidad_id : String?
    var nombre : String?
    var razon_social : String?
    var direccion : String?
    var telefonos : [String]?
    var foto : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        entidad_id <- map["entidad_id"]
        nombre <- map["nombre"]
        razon_social <- map["razon_social"]
        direccion <- map["direccion"]
        telefonos <- map["telefonos"]
        foto <- map["foto"]
    }

}
