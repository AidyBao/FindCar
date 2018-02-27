//
//  ZXRootRouter.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit



class ZXRootController: NSObject {
    
    class ZXUITabbarController: UITabBarController {
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            if let items = self.tabBar.items {
                for i in 0..<items.count {
                    let item = items[i]
                    item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
                }
            }
        }
    }

    
    private static var xxxTabbarVC:UITabBarController?
    class func zx_tabbarVC() -> UITabBarController! {
        guard let tabbarvc = xxxTabbarVC else {
            xxxTabbarVC = ZXUITabbarController()
            xxxTabbarVC?.tabBar.layer.shadowColor = UIColor.zx_colorWithHexString("4f8ee5").cgColor
            xxxTabbarVC?.tabBar.layer.shadowRadius = 5
            xxxTabbarVC?.tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
            xxxTabbarVC?.tabBar.layer.shadowOpacity = 0.25
            return xxxTabbarVC!
        }
        return tabbarvc
    }
    
    class func selectedNav() -> UINavigationController {
        var nav = self.zx_tabbarVC().selectedViewController as! UINavigationController
        if let presentedvc = nav.presentedViewController as? UINavigationController {
            nav = presentedvc
        }
        return nav
    }
    
    class func reload() {
        xxxTabbarVC = nil
        let tabbarvc = self.zx_tabbarVC()
        tabbarvc?.zx_addChildViewController(ZXHomePageViewController(), fromPlistItemIndex: 0)
        tabbarvc?.zx_addChildViewController(ZXTakePhotoPageViewController(), fromPlistItemIndex: 1)
        tabbarvc?.zx_addChildViewController(ZXPersonalCenterViewController(), fromPlistItemIndex: 2)
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            tabbarvc?.delegate = appDelegate
        }
    }
    
    class func appWindow() -> UIWindow? {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            return delegate.window
        }
        return nil
    }
}

extension UINavigationController {
    
    override open var prefersStatusBarHidden: Bool {
        return false
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override open var childViewControllerForStatusBarStyle: UIViewController? {
        return visibleViewController
        //self.topViewController
    }
    
    override open var childViewControllerForStatusBarHidden: UIViewController? {
        return visibleViewController
    }
}

