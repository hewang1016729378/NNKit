//
//  UIWebPresentCtr.swift
//  NNIM
//
//  Created by 贺旺 on 2022/11/22.
//


import UIKit
import WebKit
import PanModal

open class UIWebPresentCtr: UIViewController {

    public lazy var configWeb: WKWebViewConfiguration = {
        let configWeb = WKWebViewConfiguration()
        var preference = WKPreferences()
        // 最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 5
        // 设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = true
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = false
        configWeb.preferences = preference
        // 是使用h5的视频播放器在线播放, 还是使用原生播放器全屏播放
        configWeb.allowsInlineMediaPlayback = true
        // 设置视频是否需要用户手动播放  设置为NO则会允许自动播放
        configWeb.mediaTypesRequiringUserActionForPlayback = WKAudiovisualMediaTypes.all
        // 设置是否允许画中画技术 在特定设备上有效
        configWeb.allowsPictureInPictureMediaPlayback = false

        return configWeb
    }()

    public var weburl: String = "" {
        didSet {
            if !weburl.starts(with: "https://") {
                weburl = "https://" + weburl
            }
            load()
        }
    }

    public var delayTime: Double = 0.0

    public var mytitle: String? {
        didSet {
            self.navigationItem.title = mytitle
        }
    }

    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1))
        progressView.progressTintColor = NNKitThemeColor
        progressView.trackTintColor = .white
        return progressView
    }()
    lazy var backImageView:UIImageView = {
        let imageView = UIView.createImageView(image: I$("ic_back"))
        return imageView
    }()

    lazy var wkwebView: WKWebView = {
        let wkweb = WKWebView(frame: CGRect(), configuration: self.configWeb)
        wkweb.navigationDelegate = self
        // 注册方法
        //        WKDelegateController * delegateController = [[WKDelegateController alloc]init];
        //        delegateController.delegate = self;
        //        let delegateController = WKDelegateController.init()
        return wkweb
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(wkwebView)
        self.view.addSubview(progressView)
        self.view.addSubview(backImageView)
        

        wkwebView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        backImageView.snp.makeConstraints { make in
            make.left.top.equalTo(16)
        }
        backImageView.addClick(on: self) { (self) in
            self.dismiss(animated: true)
        }

        addObserable()
    }


    private func addObserable() {
        let observingOptions = NSKeyValueObservingOptions.new
        wkwebView.addObserver(self, forKeyPath: "estimatedProgress", options: observingOptions, context: nil)
    }


    @objc func load() {
        if weburl.count > 0 {
            let eco = weburl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            guard let url = URL(string: eco ?? "") else { return }
            let req = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
            wkwebView.load(req)
        } else {
            return
        }
    }

    @objc func loadHtml(_ str: String) {
        if str.count > 0 {
            wkwebView.loadHTMLString(str, baseURL: nil)
        } else {
            return
        }
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.setProgress(Float(wkwebView.estimatedProgress), animated: true)
            if wkwebView.estimatedProgress < 1.0 {
                delayTime = 1.0 - wkwebView.estimatedProgress
                return
            }

            let seconds = DispatchTime.now().uptimeNanoseconds + UInt64(delayTime) * NSEC_PER_SEC
            let time = DispatchTime(uptimeNanoseconds: seconds)
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.progressView.progress = 0
            }
        }
    }
}

extension UIWebPresentCtr: WKUIDelegate, WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //        UIWindHud.hudLoading()
        print("didStartProvisionalNavigation")
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
        //        UIWindHud.hideHud()
        //        checkJs(webView)
    }

    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //        UIWindHud.hideHud()
        print("didFailProvisionalNavigation")
    }
}

extension UIWebPresentCtr: PanModalPresentable {
    public var panScrollable: UIScrollView? {
        return nil
    }
    public var shortFormHeight: PanModalHeight {
        return .contentHeight(UIConstant.screenHeight())
    }
    public var showDragIndicator: Bool {
        return false
    }
    public func shouldRespond(to panModalGestureRecognizer: UIPanGestureRecognizer) -> Bool {
        return false
    }
}
