//
//  ViewController.swift
//  BrowserApp
//
//  Created by Tatsuo Yamashita on 2016/09/10.
//  Copyright © 2016年 Sakumiki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import WebKit
import LINEActivity

class MainWebViewController: UIViewController {

    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
    var actUrl: URL!
    
    @IBAction func actionButton(_ sender: UIBarButtonItem) {
        
        // 共有する項目
        let activityItems = [actUrl]
        
        
        // 初期化処理
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        activityVC.excludedActivityTypes = nil
        
        
        // UIActivityViewControllerを表示
        self.present(activityVC, animated: true, completion: nil)

    }
    
    
    var wkWebView = WKWebView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(wkWebView)
        let request = URLRequest(url: URL(string: "https://www.google.co.jp/")!)
        wkWebView.load(request)
        
        observeReadOnlyProperties(wkWebView)
        observeToolBarButtonItems()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let originY = UIApplication.shared.statusBarFrame.maxY
        wkWebView.frame = CGRect(
            x: 0,
            y: originY,
            width: self.view.bounds.width,
            height: toolBar.frame.minY - originY
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func observeReadOnlyProperties(_ wkWebView: WKWebView) {
        wkWebView.rx_title
            .shareReplay(1)
            .subscribeNext {
                print("title: \($0)")
            }
            .addDisposableTo(disposeBag)
        
        wkWebView.rx_URL
            .shareReplay(1)
            .subscribeNext {
                self.actUrl = $0 as URL!
                print("URL: \($0)")
            }
            .addDisposableTo(disposeBag)
        
        wkWebView.rx_estimatedProgress
            .shareReplay(1)
            .subscribeNext {
                print("estimatedProgress: \($0)")
            }
            .addDisposableTo(disposeBag)
        
        wkWebView.rx_loading
            .shareReplay(1)
            .subscribeNext {
                print("loading: \($0)")
            }
            .addDisposableTo(disposeBag)
        
        wkWebView.rx_canGoBack
            .shareReplay(1)
            .subscribeNext { [weak self] in
                self?.backButton.isEnabled = $0
            }
            .addDisposableTo(disposeBag)
        
        wkWebView.rx_canGoForward
            .shareReplay(1)
            .subscribeNext { [weak self] in
                self?.forwardButton.isEnabled = $0
            }
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func observeToolBarButtonItems() {
        backButton.rx.tap
            .shareReplay(1)
            .subscribeNext { [weak self] in
                self?.wkWebView.goBack()
            }
            .addDisposableTo(disposeBag)
        
        forwardButton.rx.tap
            .shareReplay(1)
            .subscribeNext { [weak self] in
                self?.wkWebView.goForward()
            }
            .addDisposableTo(disposeBag)
    }
    
}
