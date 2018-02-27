//
//  ZXLoginViewController.swift
//  FindCar
//
//  Created by 120v on 2017/12/27.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXLoginViewController: UIViewController {
    
    static func show(_ login:(ZXEmpty)? = nil) {
        var vc:UIViewController = ZXRootController.selectedNav()
        while (vc.presentedViewController != nil) {
            vc = vc.presentedViewController!
        }
        ZXGlobalData.loginProcessed = false
        vc.present(UINavigationController.init(rootViewController: ZXLoginViewController()), animated: true, completion: nil)
    }
    
    @IBOutlet weak var statusTopH: NSLayoutConstraint!
    @IBOutlet weak var titleLB: UILabel!    
    @IBOutlet weak var telLb: UILabel!
    @IBOutlet weak var telText: UITextField!
    @IBOutlet weak var geliLine: UIView!
    @IBOutlet weak var noteLB: UILabel!
    @IBOutlet weak var userAgreementBtn: UIButton!
    @IBOutlet weak var getVerCode: UIButton!
    @IBOutlet weak var feigeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUIStyle()
        
        self.setCommitButton(false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        if self.telText.text?.count == 11,(self.telText.text?.zx_mobileValid())! {
            self.setCommitButton(true)
        }else{
            self.setCommitButton(false)
        }
    }
    
    //MARK: - UI
    func setUIStyle() {
        if UIDevice.zx_DeviceSizeType() == .s_5_8_Inch {
            statusTopH.constant = 20.0 + 24.0
        }
        
        self.titleLB.textColor = UIColor.zx_textColorTitle
        self.titleLB.font = UIFont.boldSystemFont(ofSize: 29.0)
        
        self.telLb.textColor = UIColor.zx_textColorTitle
        self.telLb.font = UIFont.boldSystemFont(ofSize: 19.0)
        
        self.telText.textColor = UIColor.zx_textColorTitle
        self.telText.font = UIFont.boldSystemFont(ofSize: 29.0)
        self.telText.becomeFirstResponder()
        
        self.noteLB.textColor = UIColor.zx_textColorMark
        self.noteLB.font = UIFont.systemFont(ofSize: 12.0)
        
        self.feigeView.backgroundColor = UIColor.zx_textColorMark
        
        self.userAgreementBtn.setTitleColor(UIColor.zx_textColorMark, for: .normal)
        self.userAgreementBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        
        self.getVerCode.setTitleColor(UIColor.white, for: .normal)
        self.getVerCode.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        self.telText.resignFirstResponder()
        self.dismiss(animated: false) {
            //避免动画过程中,其他接口检测
            ZXGlobalData.loginProcessed = true
        }
    }
    
    //MARK: - 下一步
    @IBAction func getVerCodeAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.setCommitButton(false)
        if self.telText.text?.count != 0 {
            if (self.telText.text?.zx_mobileValid())! {
                self.requestForGetCode()
            }else{
                ZXHUD.showFailure(in: self.view, text: "请输入正确的手机号", delay: ZX.HUDDelay)
            }
        }else{
            ZXHUD.showFailure(in: self.view, text: "请填写手机号", delay: ZX.HUDDelay)
        }
    }
    
    //MARK: - 用户协议
    @IBAction func userAgreementAction(_ sender: UIButton) {
        telText.resignFirstResponder()
        let webVC:ZXWebViewViewController = ZXWebViewViewController.init()
        webVC.title = "药店云用户协议"
        webVC.webUrl = "\(ZXURLConst.Api.url)" + ":" + "\(ZXURLConst.Api.port)" + "/" + "\(ZXURLConst.Web.serviceItems)"
        self.navigationController?.pushViewController(webVC, animated: false)
    }
    
    fileprivate func setCommitButton(_ enable:Bool) {
        if enable {
            self.getVerCode.isEnabled = true
        } else {
            self.getVerCode.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        telText.resignFirstResponder()
    }
    
    //MARK: - 获取验证码
    func requestForGetCode() {
        var dict: Dictionary<String,Any> = Dictionary()
        if self.telText.text?.count != 0 {
            dict["tel"] = self.telText.text
        }
        ZXHUD.showLoading(in: self.view, text: "", delay: nil)
        
        ZXLoginManager.requestForGetCode(telText.text!) { (success, status, content, errMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            self.setCommitButton(true)
            if status == ZXAPI_SUCCESS {
                if let codeStr = content["smsCode"],let isNew = content["isNew"] {
                    ZXHUD.showSuccess(in: self.view, text: "验证码已发送", delay: ZX.HUDDelay)
                    let verCodeView = ZXVerificationCodeViewController()
                    
                    verCodeView.verCode = String(describing: codeStr)
                    verCodeView.tel = self.telText.text!
                    verCodeView.isNew = String(describing: isNew)
                    self.navigationController?.pushViewController(verCodeView, animated: true)
                }
            }else{
                ZXNetwork.errorCodeParse(status, httpError: {
                    ZXHUD.showFailure(in: self.view, text: "连接失败请检查网络或重试", delay: ZX.HUDDelay)
                }, serverError: {
                    ZXHUD.showFailure(in: self.view, text: errMsg ?? "", delay: ZX.HUDDelay)
                })
            }
        }
    }
}

extension ZXLoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.telText {
            let cs = CharacterSet.init(charactersIn: "0123456789").inverted
            let filtered = string.components(separatedBy: cs).joined(separator: "")
            if string != filtered {
                return false
            }
            if range.location + string.count > 11 {
                ZXHUD.showFailure(in: self.view, text: "手机号不能大于11位！", delay: ZX.HUDDelay)
                return false
            }
            let str = textField.text ?? ""
            let str2 = (str as NSString).replacingCharacters(in: range, with: string)
            if str2.count == 1 && str2 != "1" {
                return false
            }
        }
        
        if range.location + string.count == 11 {
            setCommitButton(true)
        }else{
            setCommitButton(false)
        }
        return true
    }
}
