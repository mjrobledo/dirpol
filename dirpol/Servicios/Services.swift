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
    
    static func getHeader() -> [String : String] {
        return   ["Authorization": "Bearer \(Singleton.instance.services.accessToken)" ]
    }
    
    func login(user:RequestLogin, completion: @escaping (ResponseLogin?) -> ())
    {
        let urlAux = "\(Api.url_app)\(ApiService.login.rawValue)"
        let parametros = user.toJSON()
        let manager = Alamofire.SessionManager.default
        
        manager.request(urlAux,method: .post, parameters:parametros, encoding: JSONEncoding.default, headers:[:] ).responseObject { (response: DataResponse<ResponseLogin>) in
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
         
        let manager = Alamofire.SessionManager.default
        
        
        manager.request(urlAux,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Services.getHeader() ).responseObject { (response: DataResponse<ResponseUser>) in
            
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
         
        let manager = Alamofire.SessionManager.default
        
        manager.request(urlAux,method: .post, parameters: request.toJSON(), encoding: JSONEncoding.default, headers: Services.getHeader() ).responseObject { (response: DataResponse<ResponsePanel>) in
            
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
        
        let manager = Alamofire.SessionManager.default
        let userEmail = ["email" : email]
        
        manager.request(urlAux,method: .post, parameters: userEmail, encoding: JSONEncoding.default, headers: nil ).responseObject { (response: DataResponse<ResponsePanel>) in
            
            if response.result.isSuccess {
                let forecastArray: ResponsePanel = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }
}


