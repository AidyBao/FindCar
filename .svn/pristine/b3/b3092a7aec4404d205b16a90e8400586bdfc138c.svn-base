//
//  ZXWebViewViewController.swift
//  YDHYK
//
//  Created by 120v on 2017/11/3.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXWebViewViewController: ZXUIViewController {
    
    var webUrl:String = ""
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var topView: UIView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.white
        self.webView.backgroundColor = UIColor.zx_backgroundColor
        self.webView.scrollView.isScrollEnabled = true
        
        if webUrl.isEmpty == false {
            self.webView.loadRequest(URLRequest.init(url: URL.init(string: webUrl)!))
        }else{
            ZXAlertUtils.showAlert(wihtTitle: "提示", message: "访问出错了", buttonText: "确定", action: {
                self.dismissAction()
            })
        }
        ZXHUD.showLoading(in: self.view, text: "", delay: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: - Dismiss
    @IBAction func dismissAction() -> Void {
        if (self.navigationController != nil) {
            self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override open var prefersStatusBarHidden: Bool {
//        return false
//    }
//
//    override open var preferredStatusBarStyle: UIStatusBarStyle {
//        return .default
//    }
}

extension ZXWebViewViewController:UIWebViewDelegate{
    //MARK: - WebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.topView.backgroundColor = UIColor.zx_tintColor
        ZXHUD.hide(for: self.view, animated: true)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        ZXHUD.hide(for: self.view, animated: true)
        ZXHUD.showFailure(in: self.view, text: "访问失败", delay: ZX.HUDDelay)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let strUrl = request.url?.absoluteString
        let arrURL = (strUrl?.components(separatedBy: "#"))! as NSArray
        if arrURL.isKind(of: NSArray.classForCoder()) && arrURL.count >= 2{
            let urlTypeString = arrURL.lastObject as! String
            let arrAURLType = urlTypeString.components(separatedBy: "&") as NSArray
            let index:NSInteger = NSInteger.init(arrAURLType.lastObject as! String)!
            switch index {
            case 0:
                self.dismissAction()
                return false
            default:
                break
            }
        }
        return true
    }
}



