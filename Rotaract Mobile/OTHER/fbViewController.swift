//
//  fbViewController.swift
//  Rotaract Mobile
//
//  Created by Jonathan Gurusinghe on 6/21/18.
//  Copyright © 2018 Jonathan Gurusinghe. All rights reserved.
//

import UIKit

class fbViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self as UIWebViewDelegate;
        if let url = Bundle.main.url(forResource: "facebook", withExtension: "html") {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
        
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        activity.startAnimating()
        
        NSLog("the Webview is starting to load")
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.stopAnimating()
        activity.isHidden = true;
        
        NSLog("the Webview is stopped")
        
        
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activity.stopAnimating()
        activity.isHidden=true;
        print("Webview fail with error \(error)");
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        switch navigationType {
        case .linkClicked:
            // Open links in Safari
            guard let url = request.url else { return true }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // openURL(_:) is deprecated in iOS 10+.
                UIApplication.shared.openURL(url)
            }
            return false
        default:
            // Handle other navigation types...
            return true
        }
    }
    
    @IBAction func facebook(sender: AnyObject)
    {
        if let URL = NSURL(string:"fb://page?id=125830470794906"){
            UIApplication.shared.openURL(URL as URL)
        }
        
    }
    
    @IBAction func instagram(sender: AnyObject)
    {
        if let URL = NSURL(string:"instagram://user?username=rotaract_iit"){
            UIApplication.shared.openURL(URL as URL)
        }
    }
    


    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
}

