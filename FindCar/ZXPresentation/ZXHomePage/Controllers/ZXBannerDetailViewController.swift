//
//  ZXBannerDetailViewController.swift
//  FindCar
//
//  Created by 120v on 2018/1/12.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXBannerDetailViewController: ZXUIViewController {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backViewH: NSLayoutConstraint!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var dateLBTopGap: NSLayoutConstraint!
    
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var dateLB: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var isBanner: Bool = false
    
    var contentStr: String  = ""
    var titleStr: String    = ""
    var dataStr: String     = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.backgroundColor = UIColor.zx_backgroundColor
        webView.scrollView.isScrollEnabled = true
        
        titleLB.font = UIFont.systemFont(ofSize: 25.0)
        titleLB.textColor = UIColor.zx_textColorTitle
        
        dateLB.font = UIFont.zx_subTitleFont
        dateLB.textColor = UIColor.zx_textColorBody
        
        self.navigationItem.title = "公告详情"
        
        self.webView.scrollView.isScrollEnabled = false
       
        ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: nil)
        if contentStr.isEmpty == false {
            webView.loadHTMLString(contentStr, baseURL: nil)
        }else{
            dateLB.isHidden = true
            titleLB.isHidden = true
            dateLB.isHidden = true
            ZXAlertUtils.showAlert(wihtTitle: "提示", message: "访问地址不存在", buttonText: "确定", action:{
                self.navigationController?.popViewController(animated: true)
            })
            ZXHUD.hide(for: self.view, animated: true)
        }
    }
    
    func setUI() {
        if isBanner {
            dateLB.isHidden = true
            dateLBTopGap.constant = 0
        }
        
        if titleStr.isEmpty == false {
            titleLB.text = titleStr
        }
        
        if dataStr.isEmpty == false {
            dateLB.text = dataStr
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension ZXBannerDetailViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        ZXHUD.hide(for: self.view, animated: true)
        
        self.setUI()
        
        self.scrollView.contentSize = CGSize.init(width: self.view.frame.size.width, height: webView.scrollView.contentSize.height + self.titleView.height)
        self.backViewH.constant = self.scrollView.frame.size.height
        self.view.layoutIfNeeded()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        ZXHUD.hide(for: self.view, animated: true)
        self.scrollView.contentSize = CGSize.init(width: self.view.frame.size.width, height: webView.scrollView.contentSize.height + self.titleView.height)
        self.backViewH.constant = self.scrollView.frame.size.height
        self.view.layoutIfNeeded()
    }
}
