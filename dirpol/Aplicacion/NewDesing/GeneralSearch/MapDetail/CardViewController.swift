//
//  CardViewController.swift
//  CardViewAnimation
//
//  Created by Brian Advent on 26.10.18.
//  Copyright © 2018 Brian Advent. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {

    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var imgUpDown: UIImageView!
        
    var detailList: [DetailCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "CellListMap", bundle: nil), forCellReuseIdentifier: "cellList")
        table.register(UINib(nibName: "CellDirectAccess", bundle: nil), forCellReuseIdentifier: "cellActions")
        table.register(UINib(nibName: "CellHeaderMap", bundle: nil), forCellReuseIdentifier: "cellHeader")
        
        self.setData()
    }
    
    private func setData() {
        let dcH: DetailCell = DetailCell(type: .Header, list: [""])
        let dcA: DetailCell = DetailCell(type: .Actions, list: [""])
        let dcT: DetailCell = DetailCell(type: .Tel, list: ["(01) 135-4566", "(01) 456-4658", "(01) 568-45678"])
        let dcW: DetailCell = DetailCell(type: .Web, list: ["www.comisaria.com"])
        let dcE: DetailCell = DetailCell(type: .Email, list: ["comisaria@gmail.com", "comisaria2@gmail.com"])
        let dcD: DetailCell = DetailCell(type: .Adreess, list: ["Av. Canaval y Moreyra cdra. 6 \n Plaza 30 de Agosto - San Isidro"])
        let dcR: DetailCell = DetailCell(type: .SocialMedia, list: ["www.facebook.com/mateopumacahua"])
        
        self.detailList = [dcH, dcA, dcT, dcW, dcE, dcD, dcR]
        self.table.reloadData()
    }
}


extension CardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.detailList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.detailList[section].list.count
        /* switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 3
        }*/
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let sec = self.detailList[indexPath.section]
               
               switch sec.type {
               case .Tel, .Web, .Email, .SocialMedia, .Adreess:
                   let cell = tableView.dequeueReusableCell(withIdentifier: "cellList") as! CellListMap
                    if indexPath.row > 0 {
                       cell.imgIcon.isHidden = true
                    }
                   cell.imgIcon.image = sec.type.getIcon()
                   cell.lblName.text = sec.list[indexPath.row]
                   return cell
               case .Header:
                   let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader")
                   return cell!
               case .Actions:
                   let cell = tableView.dequeueReusableCell(withIdentifier: "cellActions") as! CellDirectAccess
                   cell.delegate = self
                   // cell.viewWeb.isHidden = true
                    return cell
               }
        /*
        switch indexPath.section {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellHeader")
            return cell!
        case 1:
             let cell = tableView.dequeueReusableCell(withIdentifier: "cellActions") as! CellDirectAccess
            // cell.viewWeb.isHidden = true
             return cell
            
        default:
             let cell = tableView.dequeueReusableCell(withIdentifier: "cellList") as! CellListMap
             if indexPath.row > 0 {
                cell.imgIcon.isHidden = true
             }
            return cell
        }*/
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
       switch indexPath.section {
       case 0 :
            return 151
       case 1:
            return 60
        default:
            return 44
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
}

extension CardViewController: DirectAccessDelegate {
    func call(identifier: Int) {
        print("Call")
    }
    
    func web(identifier: Int) {
        print("WEB")
    }
    
    func eMail(identifier: Int) {
        print("EMAIL")
    }
    
    func photo(identifier: Int) {
        print("Foto")
    }
    
    func socialMedia(identifier: Int) {
        print("Social Media")
    }
    
    
}

struct DetailCell {
    var type: TypeCellDetail = .Tel
    var list: [String] = []
}

enum TypeCellDetail {
    case Tel
    case Web
    case Email
    case SocialMedia
    case Adreess
    case Header
    case Actions
    
    func getIcon() -> UIImage {
        switch self {
        case .Tel: return #imageLiteral(resourceName: "ic_tel")
        case .Web: return #imageLiteral(resourceName: "ic_web")
        case .Email: return #imageLiteral(resourceName: "ic_mail")
        case .SocialMedia: return #imageLiteral(resourceName: "ic_search")
        case .Adreess: return #imageLiteral(resourceName: "ic_web")
        case .Header: return #imageLiteral(resourceName: "ic_logo_3")
        case .Actions: return #imageLiteral(resourceName: "ic_logo_3")
        }
    }
}
