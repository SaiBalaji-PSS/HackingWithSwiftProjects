//
//  BrowserVC.swift
//  Challenge2
//
//  Created by Sai Balaji on 29/06/20.
//

import UIKit
import WebKit

class BrowserVC: UIViewController,WKNavigationDelegate {
    
    var webView: WKWebView!
    var websitename: String!
    var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.largeTitleDisplayMode = .never
        
        
        //WebView set up
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
        //WebView render
        let url = URL(string: "https://"+websitename+".com")
        webView.load(URLRequest(url: url!))
        
        
        //Toolbar items
        
        navigationController?.isToolbarHidden = false
        
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let refreshbtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(WKWebView.reload))
        
        
        let forwardbtn = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(WKWebView.goForward))
        
        let backwardbtn = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(WKWebView.goBack))
        
        progressView = UIProgressView(progressViewStyle:.default)
        progressView.sizeToFit()
        
        let progressbarbtn = UIBarButtonItem(customView: progressView)
        
        
        
        toolbarItems = [forwardbtn,backwardbtn,spacer,refreshbtn,progressbarbtn]
        
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
      
        
        
        
        
    
    }
    
    
    
    override  func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress"
        {
            progressView.progress = Float(webView.estimatedProgress)
           
        }
        
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }


}
