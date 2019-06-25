//
//  WebViewController.swift
//  News Gateway
//
//  Created by Taotao Ma on 6/24/19.
//  Copyright © 2019 Taotao Ma. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var articleURL: String = ""
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: articleURL)!
        webView.load(URLRequest(url: url))
    }
    
}
