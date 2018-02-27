//
//  ZXInvitationCodeViewController.swift
//  FindCar
//
//  Created by 120v on 2017/12/27.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXInvitationCodeViewController: UIViewController {
    
    @IBOutlet weak var statusTopH: NSLayoutConstraint!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var telTitleLB: UILabel!
    @IBOutlet weak var telLB: UIButton!
    @IBOutlet weak var geliView: UIView!
    @IBOutlet weak var telViewGap: NSLayoutConstraint!
    
    var tel: String = ""
    var verCode: String = ""
    var verCodeView: ZXCodeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()

        addVerCodeView()
        
        addNoticeLB()
        
        requestForTel()
        
        zx_addKeyboardNotification()
    }
    
    func setUI() {
        if UIDevice.zx_DeviceSizeType() == .s_5_8_Inch {
            statusTopH.constant = 20.0 + 24.0
        }
        
        telTitleLB.font = UIFont.zx_titleFont(14.0)
        telTitleLB.textColor = UIColor.zx_textColorTitle
        
        telLB.setTitleColor(UIColor.zx_tintColor, for: .normal)
        telLB.titleLabel?.font = UIFont.zx_titleFont(14.0)
        telLB.setTitle("", for: .normal)
        telLB.isEnabled = false
        
        geliView.backgroundColor = UIColor.zx_tintColor
    }
    
    //MARK: - 输入框
    func addVerCodeView() {
        verCodeView = ZXCodeView.init(frame: CGRect.init(x: 22, y: titleLB.frame.maxY + 30.0, width: ZXBOUNDS_WIDTH - 44, height: 50.0), count: 6, margin: 12, boardType: .otherPad)
        verCodeView?.delegate = self
        view.addSubview(verCodeView!)
    }
    
    func addNoticeLB() {
        let notice = UILabel.init(frame: CGRect.init(x: 22, y: (verCodeView?.frame.maxY)! + 10, width: ZXBOUNDS_WIDTH - 44, height: 21.0))
        notice.textColor = UIColor.zx_textColorMark
        notice.font = UIFont.systemFont(ofSize: 12.0)
        notice.text = "没有邀请码？询问好友获取他分享的邀请码"
        view.addSubview(notice)
    }
    
    override func zx_keyboardWillShow(duration dt: Double, userInfo: Dictionary<String, Any>) {
        let endRect = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
        UIView.animate(withDuration: dt) {
            self.telViewGap.constant = endRect.height + 10
        }
    }
    
    override func zx_keyboardWillHide(duration dt: Double, userInfo: Dictionary<String, Any>) {
        UIView.animate(withDuration: dt) {
            self.telViewGap.constant = 10
        }
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - 电话
    @IBAction func telAction(_ sender: UIButton) {
        if let tel = self.telLB.titleLabel?.text,tel.count > 0 {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "telprompt://\(tel)")!, options: [:], completionHandler: nil)
            }else{
                UIApplication.shared.openURL(URL(string: "telprompt://\(tel)")!)
            }
        }else{
            ZXHUD.showText(in: self.view, text: "暂无联系方式", delay: ZX.HUDDelay)
        }
    }
    
    //MARK: - 获取电话号码
    func requestForTel() {
        ZXLoginManager.requestForGetTel { (succ, code, str, tel) in
            if tel.count > 0 {
                self.telLB.setTitle(tel, for: .normal)
                self.telLB.isEnabled = true
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        verCodeView?.resignResponder()
    }
}

//MARK: - ZXCodeViewDelegate
extension ZXInvitationCodeViewController: ZXCodeViewDelegate {
    func zxCodeViewCode(codeView: ZXCodeView, code: String) {
        self.reaquestForBindTel(code, codeView)
    }
}

//MARK: - HTTP
extension ZXInvitationCodeViewController {
    
    //MARK: - 邀请码绑定手机号
    func reaquestForBindTel(_ invitCode: String,_ codeView: ZXCodeView) {
        ZXHUD.showLoading(in: self.view, text: "登录中...", delay: nil)
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.User.bindTel), params: ["tel":tel,"invitationCode":invitCode], method: .post) { (succ, code, content, str, zxerror) in
            ZXHUD.hide(for: self.view, animated: true)
            if succ {
                if code == ZXAPI_SUCCESS {
                    ZXHUD.showSuccess(in: self.view, text: "登录成功", delay: ZX.HUDDelay)
                    NotificationCenter.zxpost.loginSuccess()
                    if let data = content["data"] as? Dictionary<String,Any> {
                        //保存用户登录信息
                        ZXUser.user.save(data)
                    }
                    //更新用户个人信息
                    self.updateUserInfo()
                    //
                    self.changeRootController()
                    
                    codeView.resignResponder()
                }else{
                    ZXHUD.showFailure(in: self.view, text: "邀请码验证失败", delay: ZX.HUDDelay)
                    codeView.clean()
                }
            }else if code != ZXAPI_LOGIN_INVALID{
                ZXNetwork.errorCodeParse(code, httpError: {
                    ZXHUD.showFailure(in: self.view, text: "连接失败请检查网络或重试", delay: ZX.HUDDelay)
                }, serverError: {
                    ZXHUD.showFailure(in: self.view, text: (zxerror?.errorMessage)!, delay: 2.0)
                })
                codeView.clean()
            }
        }
    }
    
    func changeRootController() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            self.dismiss(animated: true, completion: {
            })
        })
    }
    
    func updateUserInfo() {
        DispatchQueue.main.async {
            //1.获取设备信息
            ZXLoginManager.requestForEquipment()
        }
    }
}
