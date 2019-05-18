//
//  HttpMgr.swift
//  QSMobileTest
//
//  Created by Rydus on 18/05/2019.
//  Copyright © 2019 Rydus. All rights reserved.
//

import UIKit
import Alamofire
import APESuperHUD
import SwiftyJSON

//  MARK: Http Manager
//  SingleTon Design Pattern to access globally from anywhere via shared instance without to create class instance.
final class HttpMgr {
    
    static var shared = HttpMgr()
    
    //  MARK:   Upload Data To The Web Server
    func get(uri:String, completion: @escaping (_ result: JSON)->()) {
        
        let serialQueue = DispatchQueue(label: "quickseries.mobile.test")
        serialQueue.sync {
            
            DispatchQueue.main.async() {
                //  Add Hud
                APESuperHUD.show(style: .loadingIndicator(type: .standard), title: nil, message: "Please wait...")
            }
            
            //  Requesting to server...
            Common.Log(str: uri)
            Alamofire.request(uri, method: .get, parameters: nil, encoding: JSONEncoding.default)
                .responseData { res in
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        APESuperHUD.dismissAll(animated: true)
                    })
                    
                    do {
                        //  Checking server response...
                        let json = try JSON(data: (res.data!))
                        Common.Log(str:json.description)
                        //  call back response
                        completion(json as JSON);
                    }
                    catch {
                        DispatchQueue.main.async() {
                            let alertController = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alertController.addAction(OKAction)
                        }
                    }
                }
        }
    }
    
    //  MARK:   Download Image/Binary From Web Server
    func getImage(uri: String, completion: @escaping (Data) -> ()) {
        
        let serialQueue = DispatchQueue(label: "com.test.mySerialQueue")
        serialQueue.sync {
            /*Alamofire.request(uri).responseData { (response) in
                if response.error != nil {
                    print(response.result)
                    // Show the downloaded image:
                    if let data = response.data {
                        completion(data)
                    }
                }
            }*/
            
            let picUrl = URL(string: uri)!
            
            // Creating a session object with the default configuration.
            // You can read more about it here https://developer.apple.com/reference/foundation/urlsessionconfiguration
            let session = URLSession(configuration: .default)
            
            // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
            let downloadPicTask = session.dataTask(with: picUrl) { (data, response, error) in
                // The download has finished.
                if let e = error {
                    Common.Log(str: "Error downloading picUrl: \(e)")
                } else {
                    // No errors found.
                    // It would be weird if we didn't have a response, so check for that too.
                    if let res = response as? HTTPURLResponse {
                        Common.Log(str: "Downloaded picUrl with response code \(res.statusCode)")
                        if let imageData = data {
                            // Finally convert that Data into an image and do what you wish with it.
                            //let image = UIImage(data: imageData)
                            // Do something with your image.
                            completion(imageData)
                        } else {
                            Common.Log(str: "Couldn't get image: Image is nil")
                        }
                    } else {
                        Common.Log(str: "Couldn't get response code for some reason")
                    }
                }
            }
            
            downloadPicTask.resume()
        }
    }
}
