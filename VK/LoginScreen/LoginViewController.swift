//
//  LoginViewController.swift
//  VK
//
//  Created by Dmitrii Diadiushkin on 07.12.2020.
//

import UIKit
import WebKit

class LoginViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let webViewConfig = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7691034"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "friends,photos,wall,groups"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.126")
        ]
        guard let url = urlComponents.url else {
            print("URL Error")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            webView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
}

extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else { decisionHandler(.allow); return}
        
        let parameters = fragment.components(separatedBy: "&").map { $0.components(separatedBy: "=")}.reduce([String: String]()) {result, parameter in
            var dict = result
            let key = parameter[0]
            let value = parameter[1]
            dict[key] = value
            return dict
        }
        guard let token = parameters["access_token"],
              let userIdString = parameters["user_id"],
              let userId = Int(userIdString) else {
            decisionHandler(.allow)
            return
        }
        VKSession.shared.token = token
        VKSession.shared.userID = userId
        print("Show TabBar")
        
        decisionHandler(.cancel)
    }
}

extension LoginViewController: WKUIDelegate {
    
}
