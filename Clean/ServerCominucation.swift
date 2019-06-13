//
//  ServerCominucation.swift
//  Clean
//
//  Created by James on 7/8/17.
//  Copyright © 2017 James. All rights reserved.
//

import Foundation
import  UIKit


class Server {
    var dataString = ""
    
    public func sendHTTPrequsetWithData(_ data: [String:Any], _ link : String){
        
        var request = URLRequest(url: URL(string: link)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        
        print(request.httpBody!.base64EncodedString())
        URLSession.shared.dataTask(with:request, completionHandler: {(data, response, error) in
            print (NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            if error != nil {
                print(error ?? "")
            } else {
                do {
                    guard let json = ((try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]) as [String : Any]??) else { return }
                    
                    guard let errors = json?["errors"] as? [[String: Any]] else { return }
                    if errors.count > 0 {
                        print(error ?? "")
                        return
                    } else {
                        // show confirmation
                    }
                }
            }
        }).resume()

    }
    
    func sendHTTPrequsetWitouthData(_ link: String) -> String {
        var url : URL?
        if let encoded = link.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        {
           url = URL(string: encoded)
        }
        let request = URLRequest(url: url! ,cachePolicy: .reloadIgnoringLocalCacheData)
        
        
        let urlconfig = URLSessionConfiguration.default
        urlconfig.timeoutIntervalForRequest = TimeInterval(10)
        urlconfig.timeoutIntervalForResource = TimeInterval(10)
        
        let session = URLSession(configuration: urlconfig)
        var dataReceived: NSData = NSData()
        let sem = DispatchSemaphore(value: 0)
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil{
                print("Error -> \(String(describing: error))")
               self.dataString = ""
                 sem.signal()
                return
            }
            
            dataReceived = data! as NSData
          
            self.dataString = NSString(data: dataReceived as Data,encoding : String.Encoding.utf8.rawValue)! as String
              
            
            sem.signal()
        }
        
        task.resume()
        
        // This line will wait until the semaphore has been signaled
        // which will be once the data task has completed
        sem.wait()
        return dataString
    }

    
}
