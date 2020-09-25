//
//  Singleton.swift
//  dirpol
//
//  Created by Developer iOS on 7/18/20.
//  Copyright © 2020 gravittas. All rights reserved.
//

import UIKit

class Singleton {
    
    static let instance = Singleton()
    
    var menuTable: UITableView!
    var services = Services()
    var business: Business!
    var user: User!
    var imgCredential = ""
    var codeAcred  = ""
    var avatar: String!
    private init()
    {
       
    }
    
}
