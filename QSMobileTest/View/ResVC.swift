//
//  ResVC.swift
//  QSMobileTest
//
//  Created by Rydus on 18/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import UIKit
import SwiftyJSON

class ResVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var slug = String()
    
    var jsonArray : [ResModel] = []
    
    var isSortAsc = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WSRequest();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_down"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(sortButtonTapped(sender:)))
        
        //  mistake in json tag : slug extra s in there
        if Common.isEqual(slug, "vacation-spots") {
            slug = "vacation-spot"
        }
        self.title = slug.uppercased()
    }
    
    @objc func sortButtonTapped(sender: UIBarButtonItem) {
        isSortAsc = !isSortAsc
        if isSortAsc {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_down"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(sortButtonTapped(sender:)))
        }
        else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow_up"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(sortButtonTapped(sender:)))
        }
        jsonArray = JsonParser.sortResources(jsonArray, isSortAsc)
        self.tableView.reloadData()
    }
    
    //  MARK:   web request
    func WSRequest() {
        getJSon(slug: slug) { (json) in
            self.jsonArray.removeAll()
            for arr in json.arrayValue {
                self.jsonArray.append(ResModel(json: arr))
            }
            self.tableView.reloadData()
        }
    }
    
    //  MARK:   TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ResCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! ResCell

        cell.photo.kf.setImage(with: URL(string:self.jsonArray[indexPath.row].photo), options: [
            .transition(.fade(1)),
            .cacheOriginalImage
            ])
        cell.title.text = self.jsonArray[indexPath.row].title
        cell.desc.text = self.jsonArray[indexPath.row].description.stripOutHtml()
        
        cell.accessoryType = .disclosureIndicator

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var addrModel:[AddressModel] = []
        for arr in self.jsonArray[indexPath.row].addresses.arrayValue {
            addrModel.append(AddressModel(json: arr))
        }
        
        /*var contModel:[ContactModel] = []
        for arr in self.jsonArray[indexPath.row].contactInfo {
            let dic = JSON([arr.key, arr.value])
            contModel.append(ContactModel(dic: dic))
        }*/
        
        //Common.Log(str: contModel.description)
        
        let vc = storyboard!.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        vc.array = [
            addrModel,
            //contModel,
            /*self.jsonArray[indexPath.row].contactInfo,
            self.jsonArray[indexPath.row].bizHours,
            self.jsonArray[indexPath.row].socialMedia*/
            ]
        vc.slug = slug
        vc.resTitle = self.jsonArray[indexPath.row].title
        vc.resDetails = self.jsonArray[indexPath.row].description.stripOutHtml() ?? ""  //  nil colesnil operator incase of empty data in desc
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let cell:ResCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! ResCell
        return cell.frame.size.height
    }
}

