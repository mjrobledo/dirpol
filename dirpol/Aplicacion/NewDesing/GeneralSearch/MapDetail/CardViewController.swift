//
//  CardViewController.swift
//  CardViewAnimation
//
//  Created by Brian Advent on 26.10.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit

protocol CardViewControllerDelegate {
    func selectedDirectory(people : EntidadPersonal)
    func selectedPhotos()
}

class CardViewController: UIViewController {
    var delegate: CardViewControllerDelegate!
    
    @IBOutlet weak var handleArea: UIView!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var imgUpDown: UIImageView!
        
    var detailList: [DetailCell] = []
    
    var phones : [String] = []
    var webs : [String] = []
    var emails : [String] = []
    var socials : [String] = []
    var principalPhone = ""
    var principalWeb = ""
    var principalEmail = ""
    var principalSocial = ""
    var principalRepre : EntidadPersonal!
    
    var typeEntity = ""
    var division = ""
    
    var entity : Entidad_sedes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "CellListMap", bundle: nil), forCellReuseIdentifier: "cellList")
        table.register(UINib(nibName: "CellDirectAccess", bundle: nil), forCellReuseIdentifier: "cellActions")
        table.register(UINib(nibName: "CellHeaderMap", bundle: nil), forCellReuseIdentifier: "cellHeader")
        if Api.config_app == .Peru {
            table.register(UINib(nibName: "CellStation", bundle: nil), forCellReuseIdentifier: "cellDirectory")
        } else {
            table.register(UINib(nibName: "CellStation_co", bundle: nil), forCellReuseIdentifier: "cellDirectory")
        }
        
        table.estimatedRowHeight = 40
        //self.setData()
    }
    /*
    private func setData() {
        let dcH: DetailCell = DetailCell(type: .Header, list: [""])
        let dcA: DetailCell = DetailCell(type: .Actions, list: [""])
        let dcT: DetailCell = DetailCell(type: .Tel, list: phones)
        let dcW: DetailCell = DetailCell(type: .Web, list: [])
        let dcE: DetailCell = DetailCell(type: .Email, list: [])
        let dcD: DetailCell = DetailCell(type: .Address, list: [])
        let dcR: DetailCell = DetailCell(type: .SocialMedia, list: [])
        let dcDir: DetailCell = DetailCell(type: .Directory, list: ["", "", "", "", "", "", ""])
        //self.detailList = [dcH, dcA, dcT, dcW, dcE, dcD, dcR, dcDir]
                
        self.table.reloadData()
    }*/
    
    func configForm() {
        let dcH: DetailCell = DetailCell(type: .Header, list: [""])
        let dcA: DetailCell = DetailCell(type: .Actions, list: [""])
        self.detailList.append(dcH)
        self.detailList.append(dcA)
        
        if let phones = entity.entidad_sede_telefono {
            if let principalPhone = phones.first(where: { $0.principal == 1 }) {
                self.principalPhone = principalPhone.telefono!
            }
            let dcT: DetailCell = DetailCell(type: .Tel, list: phones.map({ $0.telefono! }))
            self.detailList.append(dcT)
            //self.setPhones(phones: phones.map({ $0.telefono! }))
        }
        if let urls = entity.entidad_sede_url {
            if let url = urls.first(where: { $0.principal == 1 }) {
                self.principalWeb = url.url!
            }
          //  self.setWebs(webs: urls.map({ $0.url! }))
            let dcW: DetailCell = DetailCell(type: .Web, list: urls.map({ $0.url! }))
            self.detailList.append(dcW)
        }
        if let emails = entity.entidad_correo {
            if let email = emails.first(where: { $0.principal == 1 }) {
                self.principalEmail = email.correo!
            }
           // self.setEmails(emails: emails.map({ $0.correo! }))
            let dcE: DetailCell = DetailCell(type: .Email, list: emails.map({ $0.correo! }))
            self.detailList.append(dcE)
        }
        if let socials = entity.entidad_red_social { 
            if let social = socials.first(where: { $0.principal == 1 }) {
                self.principalSocial = social.direccion!
            }
            
            //self.setSocials(socials: socials.map({ $0.direccion! }))
            let dcR: DetailCell = DetailCell(type: .SocialMedia, list: socials.map({ $0.direccion! }))
            dcR.socials = socials
            self.detailList.append(dcR)
        }
        
        let dcD: DetailCell = DetailCell(type: .Address, list: [entity.getAddress()])
        self.detailList.append(dcD)
        
        if let represD = entity.entidad_personal {
            if let repre = represD.first(where: { $0.principal == 1 }) {
                self.principalRepre = repre
            }
            let dcR: DetailCell = DetailCell(type: .Directory, list: represD.map({ $0.sede_id! }))
            dcR.peoples = represD
           
            self.detailList.append(dcR)
        }
        
        self.table.reloadData()
    }
}


extension CardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.detailList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.detailList[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let sec = self.detailList[indexPath.section]
               
               switch sec.type {
               case .Tel, .Web, .Email, .Address:
                   let cell = tableView.dequeueReusableCell(withIdentifier: "cellList") as! CellListMap
                   cell.imgIcon.cornerRadius = 0
                    if indexPath.row > 0 {
                       cell.imgIcon.isHidden = true
                    } else {
                       cell.imgIcon.isHidden = false
                   }
                   cell.imgIcon.image = sec.type.getIcon()
                   cell.lblName.text = sec.list[indexPath.row]
                   return cell
               case .SocialMedia :
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cellList") as! CellListMap
                    cell.imgIcon.isHidden = false
                    if let icon =
                        sec.socials[indexPath.row].red_social {
                        let urlSM: String = icon.ruta_icono!
                        cell.imgIcon.imageFromServerURL(urlString: urlSM, defaultImage: sec.type.getIcon())
                        cell.imgIcon.cornerRadius = cell.imgIcon.frame.width / 2
                    } else {
                        cell.imgIcon.image = sec.type.getIcon()
                    }
                    cell.lblName.text = sec.list[indexPath.row]
                    return cell
               case .Header:
                   let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader") as! CellHeaderMap
                   cell.lblName.text = typeEntity
                   cell.lblDivision.text = division
                   return cell
               case .Actions:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellActions") as! CellDirectAccess
                cell.viewTel.isHidden = principalPhone.isEmpty
                cell.viewWeb.isHidden = principalWeb.isEmpty
                cell.viewEmail.isHidden = principalEmail.isEmpty
                cell.viewSocial.isHidden = principalSocial.isEmpty
                cell.viewRepre.isHidden = (principalRepre != nil)
                cell.viewPhoto.isHidden = entity.entidad_sede_foto?.count == 0
                cell.delegate = self
                // cell.viewWeb.isHidden = true
                return cell
               case .Directory:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cellDirectory") as! CellStation
                    cell.initCell(people: sec.peoples[indexPath.row], address: entity.getAddress())
                    return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sec = self.detailList[indexPath.section]
        
        switch sec.type {
        case .Tel, .Web, .Email, .SocialMedia, .Address :
          return UITableView.automaticDimension
        case .Header:
            return 151
        case .Actions:
            return 60
        case .Directory:
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1))
        let label = UILabel(frame: CGRect(x: 22, y: 0, width: tableView.frame.width - 44, height: 1))
        view.addSubview(label)
        label.primaryColor = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0 :
            return 0
        default :
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sec = self.detailList[indexPath.section]
        if sec.type == .Directory {
            self.delegate.selectedDirectory(people: sec.peoples[indexPath.row])
        }
    }
}

extension CardViewController: DirectAccessDelegate {
    func repre(identifier: Int) {
        print("Repre")
    }
    
    func call(identifier: Int) {
        print("Call")
        Util.llamar(tel: self.principalPhone, viewController: self)
    }
    
    func web(identifier: Int) {
        print("WEB")
    }
    
    func eMail(identifier: Int) {
        print("EMAIL")
    }
    
    func photo(identifier: Int) {
        print("Foto")
        self.delegate.selectedPhotos()
    }
    
    func socialMedia(identifier: Int) {
        print("Social Media")
    }
    
    
}

class DetailCell {
    var type: TypeCellDetail = .Tel
    var list: [String] = []
    var peoples : [EntidadPersonal]!
    var socials : [EntidadRedSocial]!
    
    init(type: TypeCellDetail, list: [String]) {
        self.type = type
        self.list = list
    }
}

enum TypeCellDetail {
    case Tel
    case Web
    case Email
    case SocialMedia
    case Address
    case Header
    case Actions
    case Directory
    
    func getIcon() -> UIImage {
        switch self {
        case .Tel: return UIImage(named: "ic_call_\(Api.config_app.getShortName())")!
        case .Web: return UIImage(named: "ic_web_\(Api.config_app.getShortName())")!
        case .Email: return UIImage(named: "ic_mail_\(Api.config_app.getShortName())")!
        case .SocialMedia: return UIImage(named: "ic_search_\(Api.config_app.getShortName())")!
        case .Address: return UIImage(named: "ic_address_\(Api.config_app.getShortName())")!
        case .Header: return #imageLiteral(resourceName: "ic_logo_3")
        case .Actions: return #imageLiteral(resourceName: "ic_logo_3")
        case .Directory: return UIImage()
        }
    }
}
 
