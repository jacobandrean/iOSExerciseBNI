//
//  PromoDetailViewController.swift
//  PromoModule
//
//  Created by J Andrean on 20/06/24.
//

import UIKit
import UIModule
import WebKit

protocol PromoDetailDisplayLogic: AnyObject {
    var interactor: PromoDetailBusinessLogic! { get set }
    var presenter: PromoDetailPresentationLogic! { get set }
    
    func displayWebView(request: URLRequest)
}

class PromoDetailViewController: BaseVC {
    var webView: WKWebView!

    var interactor: PromoDetailBusinessLogic!
    var presenter: PromoDetailPresentationLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.getWebViewUrlString()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(webView)
    }
}

extension PromoDetailViewController: PromoDetailDisplayLogic {
    func displayWebView(request: URLRequest) {
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.load(request)
    }
}

extension PromoDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
}
