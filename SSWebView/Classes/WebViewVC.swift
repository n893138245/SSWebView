//
//  WebViewVC.swift
//  Christie-uv-light
//
//  Created by Sansi Mac on 2021/8/6.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {
    /// 网络地址。默认地址为“百度”
    var url: String = "https://www.baidu.com/"
    /// 进度默认色。默认色为“白色”
    var trackTintColor: UIColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) // 若不设置进度默认色，系统会有默认色。本想使用系统默认色，奈何。此处做法，参考微信/支付宝
    /// 进度执行色。默认色为“iPhone Safari浏览器进度条色“蓝色””
    var tintColor: UIColor = #colorLiteral(red: 0, green: 0.462745098, blue: 0.9764705882, alpha: 1) // 色值取自于iPhone Safari浏览器进度条执行色
    let kEstimatedProgress = "estimatedProgress" // 监听字段

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) // 一般会有系统默认色。不注释，会有影响
        view.addSubview(webView)
        webView.addSubview(progressView)
        webView.addObserver(self, forKeyPath: kEstimatedProgress, options: NSKeyValueObservingOptions.new, context: nil) // 开启监测
    }
    
    lazy var webView: WKWebView = {
        let kStatusBarH = UIApplication.shared.statusBarFrame.size.height //状态栏高度x:44
        let kNavigationBarH = UINavigationController.init().navigationBar.frame.height  //导航栏Bar高度
        let kNavigationH = (kStatusBarH + kNavigationBarH)
        let webView = WKWebView.init(frame: CGRect(x: 0, y: kNavigationH, width: view.frame.size.width, height: view.frame.size.height-kNavigationH))
//        webView.backgroundColor = view.backgroundColor
        webView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        let urlStr: NSURL = NSURL(string: url) ?? NSURL()
        let request = NSURLRequest(url: urlStr as URL)
        // 目的：减少使用"!"，因不可控因素可能导致crash
//        let urlStr = NSURL(string: url)
//        let request = NSURLRequest(url: urlStr! as URL)
        webView.load(request as URLRequest)
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let view = UIProgressView.init(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 1))
        view.trackTintColor = trackTintColor // 默认色
        view.tintColor = tintColor // 执行色
        view.progress = 0.0 // 默认进度值
        return view
    }()
    // 监测中
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == kEstimatedProgress {
            progressView.alpha = 1.0
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            if webView.estimatedProgress >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.4, options: .curveEaseInOut, animations: {
                    self.progressView.alpha = 0.0
                }){ (finished) in
                    self.progressView.alpha = 0.0
                }
            }
        }
    }
    
    /// 设置参数
    /// - Parameters:
    ///   - urlString: 网络地址
    ///   - progressTintColor: 进度执行色
    ///   - progressTrackTintColor: 进度默认色
    ///   - navTitle: 导航标题
    func setUrl(urlString: String, progressTintColor: UIColor? = nil, progressTrackTintColor: UIColor? = nil, navTitle: String) { // 函数名解释：1.“?”此参数可为nil 2. “? = nil”调用此函数时就可以不选择此参数名
        url = urlString
        tintColor = progressTintColor ?? #colorLiteral(red: 0, green: 0.462745098, blue: 0.9764705882, alpha: 1) // 若为：UIColor()，则会crash
        trackTintColor = progressTrackTintColor ?? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        title = navTitle
    }
    //MARK:- 跳转至浏览器
    /// 跳转至iPhone Safari浏览器。目的：浏览器功能有：阅读模式、字体大小、翻译……
    func jumpiPhoneSafariBrowser(url: String) {
        let urlHandle: URL = URL.init(string: url) ?? URL(fileURLWithPath: "")
        if !UIApplication.shared.canOpenURL(urlHandle) {
            let alert = UIAlertController.init(title: "URL error", message: nil, preferredStyle: .alert) // 网址错误，无法跳转至浏览器，请检查网址
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            UIApplication.shared.windows.last?.rootViewController?.present(alert, animated: true, completion: nil) // 留意此句代码
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(urlHandle, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
        }
    }
}

extension WebViewVC : WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //展示
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //隐藏
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //隐藏
        //报错
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //隐藏
    }
}
