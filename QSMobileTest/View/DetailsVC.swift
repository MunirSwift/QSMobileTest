//
//  DetailsVC.swift
//  QSMobileTest
//
//  Created by Rydus on 18/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import UIKit
import MessageUI
import SwiftyJSON
import MapKit

class DetailsVC: BaseVC,
UITableViewDelegate, UITableViewDataSource,MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var array: [Any] = []
    
    var slug = String()
    var resTitle = String()
    var resDetails = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = String(format: "%@ Details", slug)
        lbTitle.text = resTitle;
        lbDesc.text = resDetails;
        
        self.tableView.register(UINib(nibName: "AddressesCell", bundle: nil), forCellReuseIdentifier: "cell1")
        self.tableView.register(UINib(nibName: "ContactInfoCell", bundle: nil), forCellReuseIdentifier: "cell2")
        self.tableView.register(UINib(nibName: "BizHoursCell", bundle: nil), forCellReuseIdentifier: "cell3")
        self.tableView.register(UINib(nibName: "SocialMediaCell", bundle: nil), forCellReuseIdentifier: "cell4")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    //  MARK:   TableView Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
            case 0:
                return "Address"
            case 1:
                return "Contact Information"
            case 2:
                return "Business Hours"
            case 3:
                return "Social Media"
            default:
                return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            let model = self.array[section] as! [AddressModel]
            return model.count
        }
        if section==1 {
            let model = self.array[section] as! [ContactModel]
            return model.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.section) {
            case 0:
                
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell1") as! AddressesCell
                
                if let model = self.array[indexPath.section] as? [AddressModel] {
                    cell.lbAddress.text = String(format: "%@ %@ %@ %@ %@",
                                                 model[indexPath.row].address1 ,
                                                 model[indexPath.row].city ,
                                                 model[indexPath.row].state ,
                                                 model[indexPath.row].zipCode ,
                                                 model[indexPath.row].country)
                    
                    cell.btnPin.tag = indexPath.row
                    cell.btnPin.addTarget(self, action: #selector(AddressMapClicked(sender:)), for: .touchUpInside)
                }
                
                return cell
            
            case 1:
                
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell2") as! ContactInfoCell
                
                if let model = self.array[indexPath.section] as? [ContactModel] {

                    Common.Log(str: model[indexPath.row].phoneNumber)
                    
                    /*cell.lbFax.text = model[indexPath.row].faxNumber as? String
                    cell.lbPhone.text = model[indexPath.row].phoneNumber as? String
                    cell.lbWeb.text = model[indexPath.row].website as? String
                    cell.lbEmail.text = model[indexPath.row].email as? String
                    cell.lbTollFree.text = model[indexPath.row].tollFree as? String*/
                    
                    /*cell.btnWeb.tag = indexPath.row
                    cell.btnWeb.addTarget(self, action: #selector(ContactWebClicked(sender:)), for: .touchUpInside)
                    
                    cell.btnEmail.tag = indexPath.row
                    cell.btnEmail.addTarget(self, action: #selector(ContactEmailClicked(sender:)), for: .touchUpInside)
                    
                    cell.btnPhCall.tag = indexPath.row
                    cell.btnPhCall.addTarget(self, action: #selector(ContactPhoneClicked(sender:)), for: .touchUpInside)
                    
                    cell.btnTFCall.tag = indexPath.row
                    cell.btnTFCall.addTarget(self, action: #selector(ContactPhoneClicked(sender:)), for: .touchUpInside)
                    
                    cell.btnPhSms.tag = indexPath.row
                    cell.btnPhSms.addTarget(self, action: #selector(ContactSMSClicked(sender:)), for: .touchUpInside)
                    
                    cell.btnTFSms.tag = indexPath.row
                    cell.btnTFSms.addTarget(self, action: #selector(ContactSMSClicked(sender:)), for: .touchUpInside)*/
                }
                
                return cell
            
            case 2:
                //let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell3") as! BizHoursCell
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell3") as! BizHoursCell

                cell.lbSat.text = "asdfasdfasdfas sadfasd"
                /*let bizHoursModel = self.array[indexPath.section] as! BizHoursModel
                cell.lbSun.text = String(format: "%@ - $%@", bizHoursModel.sunday["from"].stringValue, bizHoursModel.sunday["to"].stringValue)
                cell.lbMon.text = String(format: "%@ - $%@", bizHoursModel.monday["from"].stringValue, bizHoursModel.monday["to"].stringValue)
                cell.lbTue.text = String(format: "%@ - $%@", bizHoursModel.tuesday["from"].stringValue, bizHoursModel.tuesday["to"].stringValue)
                cell.lbWed.text = String(format: "%@ - $%@", bizHoursModel.wednesday["from"].stringValue, bizHoursModel.wednesday["to"].stringValue)
                cell.lbThr.text = String(format: "%@ - $%@", bizHoursModel.thrusday["from"].stringValue, bizHoursModel.thrusday["to"].stringValue)
                cell.lbFri.text = String(format: "%@ - $%@", bizHoursModel.friday["from"].stringValue, bizHoursModel.friday["to"].stringValue)
                cell.lbSat.text = String(format: "%@ - $%@", bizHoursModel.saturday["from"].stringValue, bizHoursModel.saturday["to"].stringValue)*/
                return cell
            case 3:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath) as! SocialMediaCell
                
                /*cell.btnFB.tag = indexPath.row
                cell.btnFB.addTarget(self, action: #selector(SocialFBClicked(sender:)), for: .touchUpInside)
                
                cell.btnTW.tag = indexPath.row
                cell.btnTW.addTarget(self, action: #selector(SocialTWClicked(sender:)), for: .touchUpInside)
                
                cell.btnYT.tag = indexPath.row
                cell.btnYT.addTarget(self, action: #selector(SocialYTClicked(sender:)), for: .touchUpInside)*/
                
                return cell
            default:
                return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        switch (indexPath.section) {
            case 0:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell1") as! AddressesCell
                return cell.frame.size.height
            case 1:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell2") as! ContactInfoCell
                return cell.frame.size.height
            case 2:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell3") as! BizHoursCell
                return cell.frame.size.height
            case 3:
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell4") as! SocialMediaCell
                return cell.frame.size.height
            default:
                return 0
        }
    }
    
    //  MARK:   Address:    Selector Design Pattern start from here..
    @objc func AddressMapClicked(sender:UIButton) {
        
        let addressModel = self.array[sender.tag] as! [AddressModel]
        let lat = addressModel[0].gps["latitude"].floatValue
        let lng = addressModel[0].gps["longitude"].floatValue
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))))
        source.name = "Source"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lng))))
        destination.name = "Destination"
        
        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    //  MARK:   Contact Info:    Selector Design Pattern start from here..
    /*@objc func ContactWebClicked(sender:UIButton) {
        let contactModel = self.array[sender.tag] as! ContactInfoModel
        guard let url = URL(string: contactModel.website) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func ContactEmailClicked(sender:UIButton) {
        let contactModel = self.array[sender.tag] as! ContactInfoModel
        let url = URL(string: "mailto:\(contactModel.email)")
        UIApplication.shared.openURL(url!)
    }
    
    @objc func ContactPhoneClicked(sender:UIButton) {
        let contactModel = self.array[sender.tag] as! ContactInfoModel
        guard let number = URL(string: "tel://" + contactModel.phoneNumber) else { return }
        UIApplication.shared.open(number)
    }
    
    @objc func ContactSMSClicked(sender:UIButton) {
        let contactModel = self.array[sender.tag] as! ContactInfoModel
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = [contactModel.phoneNumber]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    //  MARK: Social Media Info:    Selector Design Pattern start from here..
    @objc func SocialFBClicked(sender:UIButton) {
        let socialModel = self.array[sender.tag] as! SocialModel
        guard let url = URL(string: socialModel.facebook) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func SocialTWClicked(sender:UIButton) {
        let socialModel = self.array[sender.tag] as! SocialModel
        guard let url = URL(string: socialModel.twitter) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func SocialYTClicked(sender:UIButton) {
        let socialModel = self.array[sender.tag] as! SocialModel
        guard let url = URL(string: socialModel.youtubeChannel) else { return }
        UIApplication.shared.open(url)
    }*/
    
    //  MARK:   Message Composer Delegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
}


