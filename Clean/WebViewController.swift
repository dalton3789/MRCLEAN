//
//  WebViewController.swift
//  Clean
//
//  Created by James on 7/11/17.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var videoView: UIWebView!
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activity.startAnimating()
        videoView.loadRequest(URLRequest(url: URL(string: "https://cleanhome.com.vn")!))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //func webViewDidStartLoad(_ : UIWebView){
        
    //}
    
    func webViewDidFinishLoad(_ : UIWebView){
        activity.stopAnimating()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
