//
//  ZXConfirmViewController.swift
//  FindCar
//
//  Created by screson on 2017/12/19.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXConfirmViewController: ZXUIViewController {
    
    var image: UIImage?
    var model: ZXLicenseModel? {
        didSet {
            self.txtNumber.text = model?.number
            self.lbColor.text = model?.color?.description()
        }
    }

    @IBOutlet weak var imgvPlate: UIImageView!
    @IBOutlet weak var txtNumber: UITextField!
    @IBOutlet weak var lbColor: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imgvPlate.image = image
        self.checkAction()
    }
    
    override func zx_rightBarButtonAction(index: Int) {
        self.checkAction()
    }
    
    fileprivate func checkAction() {
        if let image = image {
            if let token = ZXOCRUtils.ACCESS_TOKEN {
                self.detectActionWith(token,image: image)
            } else {
                ZXHUD.showLoading(in: self.view, text: "识别中...", delay: 0)
                ZXOCRUtils.getToken(completion: { (token, error) in
                    ZXHUD.hide(for: self.view, animated: true)
                    if let token = token {
                        self.detectActionWith(token, image: image)
                    } else {
                        ZXHUD.showFailure(in: self.view, text: "获取TOKEN失败", delay: ZXHUD.DelayTime)
                        ZXAlertUtils.showAlert(wihtTitle: nil, message: "获取TOKEN失败", buttonTexts:["取消", "重试"], action: { (index) in
                            if index == 1 {
                                self.checkAction()
                            }
                        })
                    }
                })
            }
        } else {
            ZXHUD.showFailure(in: self.view, text: "未检测到图片", delay: ZXHUD.DelayTime)
        }
    }
    
    fileprivate func detectActionWith(_ token: String,image: UIImage) {
        ZXHUD.showLoading(in: self.view, text: "识别中...", delay: 0)
        ZXOCRUtils.license_plate(imageData: UIImageJPEGRepresentation(image, 1.0)!, access_token: token, completion: { (model, error) in
            ZXHUD.hide(for: self.view, animated: true)
            if let model = model {
                self.navigationItem.rightBarButtonItems = nil
                self.model = model
            } else {
                self.zx_addNavBarButtonItems(textNames: ["重试"], font: nil, color: nil, at: .right)
                ZXHUD.showFailure(in: self.view, text: error ?? "未识别到车牌信息", delay: ZXHUD.DelayTime)

            }
        })
    }
    

    
    @IBAction func commitAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ZXConfirmViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
