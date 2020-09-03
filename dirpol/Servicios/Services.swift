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
        let header = ["Authorization": "Bearer \(Singleton.instance.services.accessToken)" ]
        //manager.session.configuration.httpAdditionalHeaders = [
          //  "Authorization": "Bearer \(Singleton.instance.services.accessToken)" ]
        
      /*  manager.request(urlAux, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.isSuccess {
                print(response)
            } else {
                print(response.error)
            }
            
        }*/
        
        manager.request(urlAux,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header ).responseObject { (response: DataResponse<ResponseUser>) in
            
            if response.result.isSuccess {
                let forecastArray: ResponseUser = response.result.value!
                completion(forecastArray)
            }else{
                completion(nil)
            }
        }
    }
}


