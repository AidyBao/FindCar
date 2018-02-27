//
//  AppDelegate.swift
//  FindCar
//
//  Created by screson on 2017/12/15.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
    
        //WX
        WXApiRegist()
        
        #if DEBUG
            ZXNetwork.showRequestLog = true
        #endif
        //MARK: - UIConfig
        ZXStructs.loadUIConfig()
        //MARK: - Load Tabbar's controllers
        ZXRootController.reload()
        //MARK: - Set RootViewController
        ZXRouter.changeRootViewController(ZXLaunchViewController())
        //MARK: - Request Log
        //MARK: - OCR Token
        ZXOCRUtils.getToken(completion: { (_,_) in
            print(ZXOCRUtils.ACCESS_TOKEN ?? "")
        })
        //MARK: - Regist RemoteNotification
        self.registRemoteNotification()
        //MARK: - Regesit
        self.zx_addNotice()
        
        self.window?.makeKeyAndVisible()
        //
        self.preloadData()
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        ZXUser.zx_AutoLogin { (isAuto) in
            if !isAuto {
                ZXAlertUtils.showAlert(wihtTitle: nil, message: "登录已失效,请重新登录", buttonText: nil) {
                    ZXLoginViewController.show()
                    ZXRootController.zx_tabbarVC().selectedIndex = 0
                }
            }
        }
    }
    
    /// 此方法的作用是是否使用第三方键盘
    /// - Parameters:
    /// - application: application 对象
    /// - extensionPointIdentifier: 第三方键盘的标识
    /// - Returns: true 表示使用第三方键盘 fanse 表示不使用
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplicationExtensionPointIdentifier) -> Bool {
        /*
        let vc:UIViewController = ZXRootController.selectedNav()
        if vc is UINavigationController {
            for vc1 in vc.childViewControllers {
                if  vc1 is ZXLoginViewController || vc1 is ZXVerificationCodeViewController || vc1 is ZXInvitationCodeViewController  {
                    return false
                }
            }
        }
        */
        return false
    }
}

extension AppDelegate {
    
    func preloadData()  {
        ZXCommonViewModel.placeBeloningList { (success, code, errorMsg, pList, tList) in
            if success {
                ZXGlobalData.placeList = pList
                ZXGlobalData.typeList = tList
            }
        }
    }
}


extension AppDelegate: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let sIndex = tabBarController.viewControllers?.index(of: viewController) else {
            return true
        }
        if sIndex == 1 || sIndex == 2 {
            if !ZXUser.user.isLogin {
                ZXLoginViewController.show({
                    ZXRouter.tabbarSelect(at: sIndex)
                })
                return false
            }
        }

        if sIndex == 1 {
            if !ZXExampleShowViewController.showedBefore {
                ZXExampleShowViewController.showWithImageNames(["shotpic1", "shotpic2", "shotpic3", "shotpic4"], ["正确拍摄操作示例", "正确拍摄操作示例", "错误拍摄操作示例", "错误拍摄操作示例"], upoun: ZXRootController.zx_tabbarVC()) {
                    ZXExampleShowViewController.showed()
                    ZXRouter.tabbarShouldSelected(at: 1)
                }
                return false
            }
        }
        
        return UITabBarController.zx_tabBarController(tabBarController, shouldSelectViewController: viewController)
    }
}

extension AppDelegate: ZXPlateDetectDelegate {
    func zxTaskMatched(model: ZXTaskModel?, ocrNumber: String, inputPlateNumber: String?, imageUrl: String) {
        let nav = ZXRootController.selectedNav()
        var vcs = nav.viewControllers
        let _ = vcs.popLast()
        let detail = ZXTaskDetailViewController()
        detail.taskModel = model
        detail.fromCarMatch = true
        detail.zxplateImageUrl = imageUrl
        detail.ocrNumber = ocrNumber
        detail.inputPlateNumber = inputPlateNumber
        vcs.append(detail)
        nav.setViewControllers(vcs, animated: true)
    }
    
    func zxPlateDetect(model: ZXLicenseModel, image: UIImage?) {
        let confirmVC = ZXCardPlateConfirmViewController()
        confirmVC.checkType = .match
        confirmVC.delegate = self
        confirmVC.image = image
        confirmVC.plateModel = model
        ZXRootController.selectedNav().pushViewController(confirmVC, animated: true)
    }
    
}


