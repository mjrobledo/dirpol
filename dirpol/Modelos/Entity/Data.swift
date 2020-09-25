/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct EntityM : Mappable {
	var entidad_id : String?
	var pais_id : String?
	var tipo_entidad_id : String?
	var relevancia_entidad_id : String?
	var estado_contribuyente_id : String?
	var condicion_contribuyente_id : String?
	var entidad_dependiente : String?
	var tipo_contribuyente_id : String?
	var seccion_empresa_id : String?
	var razon_social : String?
	var descripcion : String?
	var nombre_comercial : String?
	var codigo_tributario : String?
	var visible : Int?
	var fecha_inicio_actividad : String?
	var pais : Pais?
	var tipos_entidad : Tipos_entidad?
	var relevancia_entidad : Relevancia_entidad?
	var estado_contribuyente : Estado_contribuyente?
	var condicion_contribuyente : Condicion_contribuyente?
	var tipo_contribuyente : Tipo_contribuyente?
	var seccion_empresa : Seccion_empresa?
	var entidad_sedes : [Entidad_sedes]?
	var entidad_actividad : [Entidad_actividad]?
	var entidad_numero_empleado : [Entidad_numero_empleado]?
	var entidad_padron_contribuyente : [Entidad_padron_contribuyente]?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		entidad_id <- map["entidad_id"]
		pais_id <- map["pais_id"]
		tipo_entidad_id <- map["tipo_entidad_id"]
		relevancia_entidad_id <- map["relevancia_entidad_id"]
		estado_contribuyente_id <- map["estado_contribuyente_id"]
		condicion_contribuyente_id <- map["condicion_contribuyente_id"]
		entidad_dependiente <- map["entidad_dependiente"]
		tipo_contribuyente_id <- map["tipo_contribuyente_id"]
		seccion_empresa_id <- map["seccion_empresa_id"]
		razon_social <- map["razon_social"]
		descripcion <- map["descripcion"]
		nombre_comercial <- map["nombre_comercial"]
		codigo_tributario <- map["codigo_tributario"]
		visible <- map["visible"]
		fecha_inicio_actividad <- map["fecha_inicio_actividad"]
		pais <- map["pais"]
		tipos_entidad <- map["tipos_entidad"]
		relevancia_entidad <- map["relevancia_entidad"]
		estado_contribuyente <- map["estado_contribuyente"]
		condicion_contribuyente <- map["condicion_contribuyente"]
		tipo_contribuyente <- map["tipo_contribuyente"]
		seccion_empresa <- map["seccion_empresa"]
		entidad_sedes <- map["entidad_sedes"]
		entidad_actividad <- map["entidad_actividad"]
		entidad_numero_empleado <- map["entidad_numero_empleado"]
		entidad_padron_contribuyente <- map["entidad_padron_contribuyente"]
	}

    
}
