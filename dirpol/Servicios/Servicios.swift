//
//  Servicios.swift
//  Proyecto
//
//  Created by Miguel Robledo Pro on 01/07/17.
//  Copyright © 2017 Miguel Robledo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper



class Servicios: NSObject {
    func enviarMensaje(us:requestContacto, completion: @escaping (requesData?) -> ())
    {
        let manager = Alamofire.SessionManager.default
        
        let urlAux = "\(Api.url_app)/inserta"
        let parametros = us.toJSON()
        
        manager.request(urlAux,method: .post, parameters:parametros).responseObject { (response: DataResponse<requesData>) in
            let forecastArray:requesData = response.result.value!
            completion(forecastArray)
            
        }
    }
    
    
    
    func inicioSesion(usuario:RequestLogin, completion: @escaping (RespuestaLogin?) -> ())
    {
        let urlAux = "\(Api.url_app)/api/auth"
        let parametros = usuario.toJSON()
        let manager = Alamofire.SessionManager.default
        
        manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseObject { (response: DataResponse<RespuestaLogin>) in
            if response.response != nil && response.result.isSuccess {
                let forecastArray = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }
    
    func bloquearCuenta(usuario:String, completion: @escaping (respuestaGenerica?) -> ())
    {
        let urlAux = "\(Api.url_app)/api/user/block"
        let parametros = ["usuario":usuario]
        let manager = Alamofire.SessionManager.default
        
        
        manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseObject { (response: DataResponse<respuestaGenerica>) in
            if response.response != nil {
                let forecastArray = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
            
        }
    }
    
    // MARK: - Edita usuario
    func editarUsuario(usuario:Usuario, completion: @escaping (respuestaGenerica?) -> ())
    {
        let urlAux = "\(Api.url_app)/api/user/editar"
        let parametros = usuario.toJSON()
        let manager = Alamofire.SessionManager.default
        
        manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseObject { (response: DataResponse<respuestaGenerica>) in
            if response.response != nil {
                let forecastArray = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }
    
    // MARK: - Regiones
    func getRegiones(completion: @escaping ([Region]?) -> ())
    {
        let manager = Alamofire.SessionManager.default
        
        let urlAux = "\(Api.url_app)/api/region"
        let parametros = ["usuario":""]
        
        manager.request(urlAux,method: .get, parameters:parametros).responseArray { (response: DataResponse<[Region]>) in
            let forecastArray = response.result.value
            completion(forecastArray)
            
        }
    }
    
    func getProvincias(idRegion:Int, completion: @escaping ([Region]?) -> ())
    {
        let manager = Alamofire.SessionManager.default
        
        let urlAux = "\(Api.url_app)/api/region/provincia"
        
        let parametros = ["id_region":idRegion]
        
        manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseArray { (response: DataResponse<[Region]>) in
            
            let forecastArray = response.result.value
            completion(forecastArray)
            
        }
    }
    
    
    
    // MARK: - Recuperar usuario o password
    //correo: Correo con el que el usuario se registro
    //tipo : Define si se quiere recuperar el usuario o el password
    //ver la estructura "structServicio" ->  1 Recupera usuario
    //                                       2 Recupera password
    func recuperaUsuarioPassword(correo:String, tipo:Int, completion: @escaping (respuestaGenerica?) -> ())
    {
        let manager = Alamofire.SessionManager.default
        var urlAux = ""
        if tipo == structServicio.RecuperaUsuario {
            urlAux = "\(Api.url_app)/api/user/recuperarUsuario"
        }else{
            urlAux = "\(Api.url_app)/api/user/password"
        }
        
        let parametros = ["email":correo] as [String : Any]
        
        manager.request(urlAux,method: .post, parameters:parametros).responseObject { (response: DataResponse<respuestaGenerica>) in
            let forecastArray = response.result.value
            completion(forecastArray)
            
        }
    }
    
    
    func getBusquedaGoogle(texto:String, completa:Bool, completion: @escaping (RespuestaBGoogle?) -> ())
    {
        let urlAux = "\(Api.url_app)/api/instituciones"
        
        let parametros = ["txtBusqueda":texto, "busquedaCompleta" : completa] as [String : Any]
        let manager = Alamofire.SessionManager.default
        
        manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseObject { (response: DataResponse<RespuestaBGoogle>) in
            
            if response.result.isSuccess {
                    let forecastArray = response.result.value!
                    completion(forecastArray)
            }
            if response.result.isFailure{
                let d:RespuestaBGoogle = RespuestaBGoogle()
                d.Mensaje = structCodigo.Error
                completion(d)
            }
            
        }
    }
    
    
    
    //
    func getInstitucionesProvincia(id_provincia:Int,  completion: @escaping (RespuestaBGoogle?) -> ())
    {
        let urlAux = "\(Api.url_app)/api/institucion/districto"
        let parametros = ["id_provincia":id_provincia]
        let manager = Alamofire.SessionManager.default
        
        manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseObject { (response: DataResponse<RespuestaBGoogle>) in
            
            if response.result.isSuccess {
                let forecastArray = response.result.value!
                completion(forecastArray)
            }
            if response.result.isFailure{
                let d:RespuestaBGoogle = RespuestaBGoogle()
                d.Mensaje = structCodigo.Error
                completion(d)
            }
            
        }
    }
    
    
    
    
    func getInstitucion(id_institucion:Int,   completion: @escaping (respuestaInstitucion?) -> ())
    {
        let urlAux = "\(Api.url_app)/api/detalleInstitucion"
        
        let parametros = ["id_institucion":id_institucion]
        
        let manager = Alamofire.SessionManager.default
        
        manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseObject { (response: DataResponse<respuestaInstitucion>) in
            if response.response != nil && response.result.isSuccess {
                let forecastArray = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }
    
    func getInstitucionFuncionario(id_funcionario:Int,   completion: @escaping (respuestaInstitucion?) -> ())
    {
        let urlAux = "\(Api.url_app)/api/detalleInstitucionFuncionario"
        
        let parametros = ["id_funcionario":id_funcionario]
        
        let manager = Alamofire.SessionManager.default
        
        manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseObject { (response: DataResponse<respuestaInstitucion>) in
            if response.response != nil && response.result.isSuccess {
                let forecastArray = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }
    
    func getAltoMando(   completion: @escaping (RespuestaBGoogle?) -> ())
    {
        let urlAux = "\(Api.url_app)/api/altomando"
        
        let parametros = ["":""]
        
        let manager = Alamofire.SessionManager.default
        
        manager.request(urlAux,method: .get, parameters:parametros).responseObject { (response: DataResponse<RespuestaBGoogle>) in
            let forecastArray = response.result.value
            completion(forecastArray)
            
        }
    }

    func getInstitucionesBusqueda(request:RequestBusqueda,  completion: @escaping (RespuestaBGoogle?) -> ())
    {
        let urlAux = "\(Api.url_app)/api/institucion/districto"
        let parametros = request.toJSON()
        let manager = Alamofire.SessionManager.default
        
        manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseObject { (response: DataResponse<RespuestaBGoogle>) in
            
            if response.result.isSuccess {
                let forecastArray = response.result.value!
                completion(forecastArray)
            }
            if response.result.isFailure{
                let d:RespuestaBGoogle = RespuestaBGoogle()
                d.Mensaje = structCodigo.Error
                completion(d)
            }
        }
        
        
    }
    
    func getBusquedaAvanzada(request:RequestBusqueda,  completion: @escaping (RespuestaBAvanzada?) -> ())
    {
        let urlAux = "\(Api.url_app)/api/institucion/busqueda"
        let parametros = request.toJSON()
        let manager = Alamofire.SessionManager.default
        
        manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseObject { (response: DataResponse<RespuestaBAvanzada>) in
            
            if response.result.isSuccess {
                let forecastArray = response.result.value!
                completion(forecastArray)
            }
            if response.result.isFailure{
                let d:RespuestaBAvanzada = RespuestaBAvanzada()
                d.Mensaje = structCodigo.Error
                completion(d)
            }
        }
        
        
    }
}





class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

struct structServicio {
    static let RecuperaUsuario = 1
    static let RecuperaPassword = 2
}

