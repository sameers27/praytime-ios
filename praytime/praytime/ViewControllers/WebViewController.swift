//
//  WebViewController.swift
//  praytime
//
//  Created by Sameer on 12/25/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    var url: URL?
    private let webview = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.largeTitleDisplayMode = .never
        guard let url = url else { return }
        webview.delegate = self
        view.addSubview(webview)
        webview.translatesAutoresizingMaskIntoConstraints = false
        webview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webview.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        webview.loadRequest(URLRequest(url: url))
        print(url.absoluteString)
    }
}

extension WebViewController: UIWebViewDelegate {
    
}
