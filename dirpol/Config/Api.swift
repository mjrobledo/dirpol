//
//  Api.swift
//  dirpol
//
//  Created by Developer iOS on 7/7/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import Foundation

class Api {
    static var config_app: VersionCountry = .Peru
    static var url_app: String = ""
    static var ProvideAPIKey: String = ""
    static var BusinessCountryID = ""
    static var BusinessID = ""
    static var CountryID = ""
    
    static func config() {
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
           nsDictionary = NSDictionary(contentsOfFile: path)
            
            Api.config_app = VersionCountry(rawValue: nsDictionary!["CONFIG_APP"] as! String)!
            print(Api.config_app.rawValue)
            Api.url_app = nsDictionary!["URL_APP"] as! String
            print(Api.url_app)
            Api.ProvideAPIKey = nsDictionary!["ProvideAPIKey_APP"] as! String
            Api.BusinessCountryID = nsDictionary!["BusinessCountryID"] as! String
            Api.BusinessID = nsDictionary!["BusinessID"] as! String
            Api.CountryID = nsDictionary!["CountryID"] as! String
        }
    }
}

enum VersionCountry: String {
    case Colombia = "Colombia"
    case Peru = "Peru"
    case Mexico = "Mexico"
    
    func getShortName() -> String {
        switch self {
        case .Colombia:
            return "co"
        case .Peru:
            return "pe"
        case .Mexico:
            return "mx"
        }
    }
}

