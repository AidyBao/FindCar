//
//  ZXLaunchViewController.swift
//  FindCar
//
//  Created by 120v on 2017/12/27.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXLaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取用户数据
        ZXUser.user.getUser()

        //判断登录状况
        rejudgeAutoLogin()
        
    }
    
    func rejudgeAutoLogin() {
        ZXUser.zx_AutoLogin { (isAuto) in
            if isAuto {
                self.updateUserInfo()
            }
            ZXRouter.changeRootViewController(ZXRootController.zx_tabbarVC())
        }
    }
    
    func updateUserInfo() {
        DispatchQueue.main.async {
            //1.获取设备信息
            ZXLoginManager.requestForEquipment()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
