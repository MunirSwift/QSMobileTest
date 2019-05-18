//
//  BaseVC.swift
//  MovieTest
//
//  Created by Rydus on 18/04/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import UIKit
import ReachabilitySwift
import SwiftyJSON
import Kingfisher

class BaseVC: UIViewController {
    
    var isNetAvailable = true
    let reachability = Reachability()!
    
    deinit {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(ReachabilityChangedNotification)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: ReachabilityChangedNotification, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            Common.Log(str: "could not start reachability notifier")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    //  MARK:   Custom Methods
    
    //  with completion handler inside GCD Thread
    func getJSon(slug:String, completion: @escaping (_ result: JSON)->()) {
        // Move to a background thread to do some long running work
        DispatchQueue.global(qos: .userInitiated).async {
            HttpMgr.shared.get(uri: Server.Url.replacingOccurrences(of: "#slug#", with: slug)) { (json) in
                 // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    completion(json)
                }
            }
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        Common.Log(str:reachability.currentReachabilityString)
        switch reachability.currentReachabilityString.lowercased() {
        case "wifi":
            Common.Log(str:"Reachable via WiFi")
            isNetAvailable = true
            break
        case "cellular":
            Common.Log(str:"Reachable via Cellular")
            isNetAvailable = true
            break
        default:
            Common.Log(str:"Network not reachable")
            DispatchQueue.main.async {
                self.showAlert(msg:"Sorry, internet is not available")
            }
            isNetAvailable = false
            break
        }
    }
    
    func showAlert(msg:String) {
        let alert = UIAlertController(title:nil, message:msg, preferredStyle:.alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        self.navigationController?.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            alert.dismiss(animated:true)
        }
    }
    
}

//  MARK: https://stackoverflow.com/questions/25983558/stripping-out-html-tags-from-a-string
extension String {
    
    func stripOutHtml() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
}
