//
//  Services.swift
//  dirpol
//
//  Created by Developer iOS on 9/2/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper


class Services: NSObject {

    var accessToken = ""
    static var manager = Alamofire.SessionManager.default
    
    override init() {
        Services.manager = Alamofire.SessionManager.default
    }
    
    static func getHeader() -> [String : String] {
        return   ["Authorization": "Bearer \(Singleton.instance.services.accessToken)" ]
    }
    
    func login(user:RequestLogin, completion: @escaping (ResponseLogin?) -> ())
    {
        let urlAux = "\(Api.url_app)\(ApiService.login.rawValue)"
        let parametros = user.toJSON()
         
        Services.manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseObject { (response: DataResponse<ResponseLogin>) in
            if response.response != nil && response.result.isSuccess {
                let forecastArray: ResponseLogin = response.result.value!
                Singleton.instance.services.accessToken = forecastArray.access_token
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }
    
    func getUser( completion: @escaping (ResponseUser?) -> ())
    {
        let urlAux = "\(Api.url_app)\(ApiService.account.rawValue)"
        
        Services.manager.request(urlAux,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Services.getHeader() ).responseObject { (response: DataResponse<ResponseUser>) in
            
            if response.result.isSuccess {
                let forecastArray: ResponseUser = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }
    
    
    func setUserPanel(request: RequestPanel, completion: @escaping (ResponsePanel?) -> ())
    {
        let urlAux = "\(Api.url_app)\(ApiService.account.rawValue)"
         
        
        
        Services.manager.request(urlAux,method: .post, parameters: request.toJSON(), encoding: JSONEncoding.default, headers: Services.getHeader() ).responseObject { (response: DataResponse<ResponsePanel>) in
            
            if response.result.isSuccess {
                let forecastArray: ResponsePanel = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }
    
    func recoveryUser(email: String, type: String, completion: @escaping (ResponsePanel?) -> ())
    {
        var urlAux = "\(Api.url_app)\(ApiService.recoveryUser.rawValue)"
        if type == "password" {
             urlAux = "\(Api.url_app)\(ApiService.recoveryPassword.rawValue)"
        }
        
        
        let userEmail = ["email" : email]
        
        Services.manager.request(urlAux,method: .post, parameters: userEmail, encoding: JSONEncoding.default, headers: nil ).responseObject { (response: DataResponse<ResponsePanel>) in
            
            if response.result.isSuccess {
                let forecastArray: ResponsePanel = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }

    //MARK: - CONTACT US
    func setContact(request: RequestContact, completion: @escaping (ResponseGeneral?) -> ())
    {
        let urlAux = "\(Api.url_app)\(ApiService.contact.rawValue)"
        
        Services.manager.request(urlAux,method: .post, parameters: request
            .toJSON(), encoding: JSONEncoding.default, headers: Services.getHeader() ).responseObject { (response: DataResponse<ResponseGeneral>) in
            
            if response.result.isSuccess {
                let forecastArray: ResponseGeneral = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }
    
    // MARK: - Entity
    func getEntityDetailM(entidad_id: String, completion: @escaping (ResponseEntityM?) -> ())
    {
        let urlAux = "\(Api.url_app)\(ApiService.entityDetail.rawValue)\(entidad_id)"
    
        Services.manager.request(urlAux, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Services.getHeader() ).responseObject (completionHandler: { (response: DataResponse<ResponseEntityM>) in
            
            if response.result.isSuccess {
                let forecastArray: ResponseEntityM = response.result.value!
                completion(forecastArray)
                
            } else {
                completion(nil)
            }
        })
       }
    
    // MARK: - Regiones
    func getTypeEntity( completion: @escaping (TypeEntityResponse?) -> ())
      {
          var urlAux = "\(Api.url_app)\(ApiService.entityType.rawValue)" 
          
          urlAux = urlAux.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
          
          Services.manager.request(urlAux,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Services.getHeader() ).responseObject { (response: DataResponse<TypeEntityResponse>) in
              
              if response.result.isSuccess {
                  let forecastArray: TypeEntityResponse = response.result.value!
                  completion(forecastArray)
              }else{
                  completion(nil)
              }
          }
      }
    
//MARK: - GENERAL
    
    func getEntity(request: RequestEntitySearch, completion: @escaping (EntitySearchResponse?) -> ())
    {
        let urlAux = "\(Api.url_app)\(ApiService.entitySearch.rawValue)"
        
        Services.manager.request(urlAux,method: .post, parameters: request
            .toJSON(), encoding: JSONEncoding.default, headers: Services.getHeader() ).responseObject { (response: DataResponse<EntitySearchResponse>) in
            
            if response.result.isSuccess {
                let forecastArray: EntitySearchResponse = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }
    
    func getBussiness(method : HTTPMethod, header: [String : String]?, completion: @escaping (ResponseBusiness?) -> ())
    {
       // let p = BusinessR().toJSONString(prettyPrint: false)
        //var params = BussinessRequest()
        var query = Query()
        query.empresa_pais_id = Api.BusinessCountryID
        //params.query = query
        
        let queryStr : String = (query.toJSONString()?.replacingOccurrences(of: "\\", with: ""))!
        print(queryStr)
        var urlAux  = "\(Api.url_app)\(ApiService.businessCountry.rawValue)".replacingOccurrences(of: "{}", with: queryStr)
        
        urlAux = urlAux.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Services.manager.request(urlAux, method: method, parameters: nil, encoding: JSONEncoding.default, headers: header ).responseObject (completionHandler: { (response: DataResponse<ResponseBusiness>) in
            
            if response.result.isSuccess {
                let forecastArray: ResponseBusiness = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        })
    }
    
    
    
    func getNiveles( completion: @escaping (ResponseNivel?) -> ())
    {
        var query = Query()
        query.pais_id = Api.CountryID
        
        let queryStr : String = (query.toJSONString()?.replacingOccurrences(of: "\\", with: ""))!
        print(queryStr)
        var urlAux  = "\(Api.url_app)\(ApiService.niveles.rawValue)".replacingOccurrences(of: "{}", with: queryStr)
        
        urlAux = urlAux.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Services.manager.request(urlAux, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Services.getHeader() ).responseObject (completionHandler: { (response: DataResponse<ResponseNivel>) in
            
            if response.result.isSuccess {
                let forecastArray: ResponseNivel = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        })
    }
    
    func getUbigeos(nivel: String, ubigeoSup : String?, completion: @escaping (UbigeosResponse?) -> ())
    {
        var query = Query()
        query.pais_id = Api.CountryID
        query.nivel = nivel
        if !ubigeoSup!.isEmpty {
            query.id_ubigeo_superior = ubigeoSup
        }
        
        let queryStr : String = (query.toJSONString()?.replacingOccurrences(of: "\\", with: ""))!
        print(queryStr)
        var urlAux  = "\(Api.url_app)\(ApiService.ubigeos.rawValue)".replacingOccurrences(of: "{}", with: queryStr)
        
        urlAux = urlAux.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        Services.manager.request(urlAux, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Services.getHeader() ).responseObject (completionHandler: { (response: DataResponse<UbigeosResponse>) in
            
            if response.result.isSuccess {
                let forecastArray: UbigeosResponse = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        })
    }
    
   func getSedes(tipo_entidad_id: String, completion: @escaping (SedesResponse?) -> ())
   {
       var query = Query()
       query.pais_id = Api.CountryID
       query.tipo_entidad_id = tipo_entidad_id
       
       
       let queryStr : String = (query.toJSONString()?.replacingOccurrences(of: "\\", with: ""))!
       print(queryStr)
       var urlAux  = "\(Api.url_app)\(ApiService.sedes.rawValue)".replacingOccurrences(of: "{}", with: queryStr)
       
       urlAux = urlAux.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
       
       Services.manager.request(urlAux, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Services.getHeader() ).responseObject (completionHandler: { (response: DataResponse<SedesResponse>) in
           
           if response.result.isSuccess {
               let forecastArray: SedesResponse = response.result.value!
               completion(forecastArray)
           }else{
               completion(nil)
           }
       })
   }
}


