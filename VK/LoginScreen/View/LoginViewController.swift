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
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let presenter: LoginViewOutput
    
    init(presenter: LoginViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        guard let request = createURLRequest() else {
            print("Request error")
            return
        }
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
    
    func createURLRequest() -> URLRequest? {
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
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}

extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        presenter.serverResponce(responce: navigationResponse)
        decisionHandler(.cancel)
    }
}

extension LoginViewController: LoginViewInput {
    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOK)
        self.present(alert, animated: true, completion: nil)
    }
}
