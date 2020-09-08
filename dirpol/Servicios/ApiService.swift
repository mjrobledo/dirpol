//
//  Api.swift
//  dirpol
//
//  Created by MYB on 29/08/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

enum ApiService : String {
    case login  = "/api/login"
    case account = "/api/cuenta"
    case recoveryUser = "/api/recuperar/usuario"
    case recoveryPassword = "/api/recuperar/clave"
    case logout = "/api/auth/logout"
    case business = "/api/empresas?query={}&limit=5&ascending=1&page=1&byColumn=1"
    case country = "/api/paises?query={}&limit=5&ascending=1&page=1&byColumn=1"
    case businessCountry = "/api/empresas-pais?query={}&limit=5&ascending=1&page=1&byColumn=1"
}
