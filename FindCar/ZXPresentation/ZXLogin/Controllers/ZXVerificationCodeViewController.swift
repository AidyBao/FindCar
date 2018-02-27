//
//  ZXVerificationCodeViewController.swift
//  FindCar
//
//  Created by 120v on 2017/12/27.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXVerificationCodeViewController: UIViewController {
    
    @IBOutlet weak var statusTopH: NSLayoutConstraint!
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var telLB: UILabel!
    @IBOutlet weak var inputLB: UILabel!
    @IBOutlet weak var getVerCode: ZXCountDownButton!
    var verCodeView: ZXCodeView?
    
    var verCode: String = ""
    var tel:     String = ""
    var isNew:   String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIStyle()
        
        addVerCodeView()
        
        addCountDownBtn()
        
        //监听从后台返回前台是时间变化
        NotificationCenter.default.addObserver(self, selector: #selector(refreshDate), name: ZXNotification.UI.enterForeground.zx_noticeName(), object: nil)
    }
    
    func setUIStyle() {
        if UIDevice.zx_DeviceSizeType() == .s_5_8_Inch {
            statusTopH.constant = 20.0 + 24.0
        }
        
        titleLB.textColor = UIColor.zx_textColorTitle
        titleLB.font = UIFont.boldSystemFont(ofSize: 29.0)
        
        telLB.textColor = UIColor.zx_textColorTitle
        telLB.font = UIFont.boldSystemFont(ofSize: 29.0)
        telLB.text = "手机\(tel)"
        
        inputLB.textColor = UIColor.zx_textColorTitle
        inputLB.font = UIFont.boldSystemFont(ofSize: 19.0)
        
        getVerCode.setTitleColor(UIColor.zx_textColorTitle, for: .normal)
        getVerCode.titleLabel?.font = UIFont.systemFont(ofSize: 19.0)
    }
    
    func addCountDownBtn() {
        getVerCode.maxCount = 60
        getVerCode.start()
    }
    
    //MARK: - 输入框
    func addVerCodeView() {
        verCodeView = ZXCodeView.init(frame: CGRect.init(x: 22, y: getVerCode.frame.maxY + 30.0, width: 264, height: 50.0), count: 4, margin: 10, boardType: .numberPad)
        verCodeView?.delegate = self
        view.addSubview(verCodeView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         verCodeView?.clean()
    }

    @IBAction func backAction(_ sender: UIButton) {
        getVerCode.reset()
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - 重新获取验证码
    @IBAction func getVerCodeAction(_ sender: ZXCountDownButton) {
        verCodeView?.clean()
       
        requestForGetCode()
    }
    
    //MARK: - 监听从后台返回前台是时间变化
    @objc func refreshDate() {
        if getVerCode.isCouting,ZXGlobalData.inoutCount > 0,getVerCode.currentCount > 0 {
            var temp = getVerCode.currentCount - ZXGlobalData.inoutCount
            temp = temp < 0 ? 0 : temp
            getVerCode.maxCount = temp
            getVerCode.start()
        }
    }
    
    //MARK: - 判断是否自动登录
    func judgeAutoLogoin(_ codeView: ZXCodeView) {
        if isNew == "1" {//未注册
            let invitVC = ZXInvitationCodeViewController()
            invitVC.tel = tel
            invitVC.verCode = verCode
            navigationController?.pushViewController(invitVC, animated: true)
        }else{//已注册
            requestForLogin(codeView)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        verCodeView?.resignResponder()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: ZXNotification.UI.enterForeground.zx_noticeName(), object: nil)
    }
}

//MARK: - ZXCodeViewDelegate
extension ZXVerificationCodeViewController: ZXCodeViewDelegate {
    func zxCodeViewCode(codeView: ZXCodeView, code: String) {
        if code == verCode {
            verCodeView?.resignResponder()            
            getVerCode.reset()
            requestForVerificationCode(codeView)
        }else{
            ZXHUD.showLoading(in: self.view, text: "", delay: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                ZXHUD.hide(for: self.view, animated: true)
                ZXHUD.showFailure(in: self.view, text: "验证码输入错误,请重新输入", delay: ZX.HUDDelay)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.verCodeView?.clean()
                }
            }
        }
    }
}

//MARK: - Http
extension ZXVerificationCodeViewController {
    //MARK: - 获取验证码
    func requestForGetCode() {
        var dict: Dictionary<String,Any> = Dictionary()
        if tel.isEmpty == false {
            dict["tel"] = self.tel
        }
        ZXHUD.showLoading(in: self.view, text: "", delay: nil)
        ZXLoginManager.requestForGetCode(tel) { (success, status, content, errMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            if status == ZXAPI_SUCCESS {
                if let codeStr = content["smsCode"],let isNew = content["isNew"] {
                    self.getVerCode.start()
                    ZXHUD.showSuccess(in: self.view, text: "验证码已发送", delay: ZX.HUDDelay)
                    self.verCode = String(describing: codeStr)
                    self.isNew = String(describing: isNew)
                }
            }else{
                ZXNetwork.errorCodeParse(status, httpError: {
                    ZXHUD.showFailure(in: self.view, text: "连接失败请检查网络或重试", delay: ZX.HUDDelay)
                }, serverError: {
                    ZXHUD.showFailure(in: self.view, text: errMsg ?? "", delay: ZX.HUDDelay)
                })
                self.getVerCode.reset()
            }
        }
    }
    
    //MARK: - 校验验证码
    func requestForVerificationCode(_ codeView: ZXCodeView) {
        var dict: Dictionary<String,Any> = Dictionary()
        if tel.isEmpty == false {
            dict["tel"] = self.tel
        }
        
        if verCode.isEmpty == false {
            dict["verificationCode"] = verCode
        }
        ZXHUD.hide(for: self.view, animated: true)
        ZXHUD.showLoading(in: self.view, text: "登录中...", delay: nil)
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.User.verCode), params: dict, method: .post) { (succ, code, content, str, zxerror) in
            ZXHUD.hide(for: self.view, animated: true)
            if succ {
                if code == ZXAPI_SUCCESS {
                    self.judgeAutoLogoin(codeView)
                }else{
                    ZXHUD.showFailure(in: self.view, text: "验证码过期,请重新获取", delay: ZX.HUDDelay)
                    codeView.clean()
                }
            }else{
                ZXHUD.showFailure(in: self.view, text: (zxerror?.errorMessage)!, delay: ZX.HUDDelay)
                codeView.clean()
            }
        }
    }
    
    //MARK: - 登录
    func requestForLogin(_ codeView: ZXCodeView) ->Void{
        ZXHUD.hide(for: self.view, animated: true)
        ZXHUD.showLoading(in: self.view, text: "登录中...", delay: nil)
        ZXLoginManager.requestForLogin(tel, success: { (succ, code, content, errMsg) in
            ZXHUD.hide(for: self.view, animated: true)
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
                
                codeView.clean()
            }
        }) { (code, errMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            if code != ZXAPI_LOGIN_INVALID {
                ZXNetwork.errorCodeParse(code, httpError: {
                    ZXHUD.showFailure(in: self.view, text: "连接失败请检查网络或重试", delay: ZX.HUDDelay)
                }, serverError: {
                    ZXHUD.showFailure(in: self.view, text: errMsg, delay: 2.5)
                })
            }
            codeView.clean()
        }
    }
    
    func changeRootController() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            self.dismiss(animated: true, completion: {
            })
        })
    }
    
    func updateUserInfo() {
        //1.获取设备信息
        ZXLoginManager.requestForEquipment()
    }
}
