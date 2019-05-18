//
//  CatVC.swift
//  QSMobileTest
//
//  Created by Rydus on 17/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import UIKit

class CatVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var jsonArray : [CatModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WSRequest();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //  MARK:   web request
    func WSRequest() {
        getJSon(slug: "categories") { (json) in
            self.jsonArray.removeAll()
            for arr in json.arrayValue {
                self.jsonArray.append(CatModel(json: arr))
            }
            self.tableView.reloadData()
        }
    }

    //  MARK:   TableView Delegates    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jsonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CatCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! CatCell
        
        Common.Log(str:self.jsonArray[indexPath.row].title)
        Common.Log(str:self.jsonArray[indexPath.row].description)
        
        cell.title.text = self.jsonArray[indexPath.row].title
        cell.desc.text = self.jsonArray[indexPath.row].description
        
        cell.accessoryType = .disclosureIndicator

        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let vc = storyboard!.instantiateViewController(withIdentifier: "ResVC") as! ResVC
         vc.slug = self.jsonArray[indexPath.row].slug
         self.navigationController!.pushViewController(vc, animated: true)
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let cell:CatCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! CatCell
        return cell.frame.size.height
    }
}
