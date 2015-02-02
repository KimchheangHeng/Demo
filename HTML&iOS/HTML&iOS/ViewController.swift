//
//  ViewController.swift
//  HTML&iOS
//
//  Created by Emiaostein on 15/2/2.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1. load local html
        let res = NSBundle.mainBundle().pathForResource("web/index", ofType: "html")
        let url = NSURL(fileURLWithPath: res!)
        let request = NSURLRequest(URL: url!)
        
        webView.delegate = self
        
        webView.loadRequest(request)
        
    }
}

// MAARK: IBAction
extension ViewController {
    
    @IBAction func addContent(sender: AnyObject) {
        
        let js = "var p = document.createElement(\'p\'); \np.innerText = \'new Line\';\ndocument.body.appendChild(p);"
        webView.stringByEvaluatingJavaScriptFromString(js)
    }
    
}

// MAARK: webViewDelegate
extension ViewController : UIWebViewDelegate {
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        println("webViewDidFinishLoad")
//        webView.stringByEvaluatingJavaScriptFromString("alert('hello')")

    }
}