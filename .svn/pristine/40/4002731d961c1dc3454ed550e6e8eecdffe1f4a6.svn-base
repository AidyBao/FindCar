//
//  ZXUIViewController.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/20.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXUIViewController: UIViewController {
    
    var onceLoad = false
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.zx_clearNavbarBackButtonTitle()
        ZXRouter.checkLastCacheRemoteNotice()
    }
    override open var prefersStatusBarHidden: Bool {
        return false
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .default
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

