//
//  ZXAboutViewController.swift
//  FindCar
//
//  Created by 120v on 2018/1/9.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXAboutViewController: ZXUIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var tel: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "关于"
        self.view.backgroundColor = UIColor.zx_subTintColor
        
        tableView.register(UINib.init(nibName: String.init(describing: ZXAboutRootCell.self), bundle: nil), forCellReuseIdentifier: ZXAboutRootCell.ZXAboutRootCellID)
        tableView.register(UINib.init(nibName: String.init(describing: ZXAboutHeaderCell.self), bundle: nil), forCellReuseIdentifier: ZXAboutHeaderCell.ZXAboutHeaderCellID)
        
        requestForTel()
    }
    
    //MARK: - 获取电话号码
    func requestForTel() {
        ZXLoginManager.requestForGetTel { (succ, code, str, telStr) in
            if telStr.count > 0 {
                self.tel = telStr
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ZXAboutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: ZXAboutHeaderCell = tableView.dequeueReusableCell(withIdentifier: ZXAboutHeaderCell.ZXAboutHeaderCellID, for: indexPath) as! ZXAboutHeaderCell
            return cell
        }
        let cell: ZXAboutRootCell = tableView.dequeueReusableCell(withIdentifier: ZXAboutRootCell.ZXAboutRootCellID, for: indexPath) as! ZXAboutRootCell
        cell.loadData(indexPath)
        return cell
    }
}

extension ZXAboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 253.0
        }
        return 55.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1://联系方式
            if tel.count > 0 {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: "telprompt://\(tel)")!, options: [:], completionHandler: nil)
                }else{
                    UIApplication.shared.openURL(URL(string: "telprompt://\(tel)")!)
                }
            }else{
                ZXHUD.showText(in: self.view, text: "暂无联系方式", delay: ZX.HUDDelay)
            }
        case 2://用户协议
            let webVC:ZXWebViewViewController = ZXWebViewViewController.init()
            webVC.title = "药店云用户协议"
            webVC.webUrl = "\(ZXURLConst.Api.url)" + ":" + "\(ZXURLConst.Api.port)" + "/" + "\(ZXURLConst.Web.serviceItems)"
            self.navigationController?.pushViewController(webVC, animated: false)
        case 3://分享
            /*
            let popView = ZXPopView.loadNib()
            popView.delegate = self
            popView.show()
             */
            print("333")
            let vc = ZXShareViewController()
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
}

extension ZXAboutViewController: ZXShareViewDelegate {
    func shareWeiXinFriends() {
        if WXApi.openWXApp() {
            ZXShare.shareToWX(taskModel: ZXTaskModel(), wxScene: WXSceneSession, shareType:.download)
        }else{
            ZXHUD.showFailure(in: self.view, text: "未安装微信客户端！", delay: ZX.HUDDelay)
        }
    }
    
    func shareWeiXinFriendsCircle() {
        if WXApi.openWXApp() {
            ZXShare.shareToWX(taskModel: ZXTaskModel(), wxScene: WXSceneTimeline, shareType:.download)
        }else{
            ZXHUD.showFailure(in: self.view, text: "未安装微信客户端！", delay: ZX.HUDDelay)
        }
    }
}

/*
extension ZXAboutViewController: ZXPopViewDelegate {
    func shareWeiXinFriends() {
        if WXApi.openWXApp() {
            ZXShare.shareToWX(taskModel: ZXTaskModel(), wxScene: WXSceneSession, shareType:.download)
        }else{
            ZXHUD.showFailure(in: self.view, text: "未安装微信客户端！", delay: ZX.HUDDelay)
        }
    }
    
    func shareWeiXinFriendsCircle() {
        if WXApi.openWXApp() {
            ZXShare.shareToWX(taskModel: ZXTaskModel(), wxScene: WXSceneTimeline, shareType:.download)
        }else{
            ZXHUD.showFailure(in: self.view, text: "未安装微信客户端！", delay: ZX.HUDDelay)
        }
    }
}
 */
