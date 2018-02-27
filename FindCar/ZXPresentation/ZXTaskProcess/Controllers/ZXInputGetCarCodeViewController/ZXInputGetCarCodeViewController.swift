//
//  ZXInputGetCarCodeViewController.swift
//  FindCar
//
//  Created by screson on 2018/1/9.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

/// 输入提车码
class ZXInputGetCarCodeViewController: ZXUIViewController {
    var taskId: String?
    
    @IBOutlet weak var zxContentView: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var ccvList: UICollectionView!
    @IBOutlet weak var btnCommit: ZXRButton!
    
    @IBOutlet weak var bottomOffset: NSLayoutConstraint!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not init")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .clear
        self.txtInput.isHidden = true
        self.txtInput.delegate = self
        self.txtInput.keyboardType = .numberPad
        
        self.ccvList.backgroundColor = UIColor.clear
        self.ccvList.register(UINib.init(nibName: ZXLabelShowCCVCell.NibName, bundle: nil), forCellWithReuseIdentifier: ZXLabelShowCCVCell.reuseIdentifier)
        self.ccvList.delegate = self
        self.ccvList.dataSource = self
        self.btnCommit.zx_isEnabled(false)
        
        
        IQKeyboardManager.sharedManager().enable = false
        
        self.zx_addKeyboardNotification()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textInputValueChanged(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    @objc func textInputValueChanged(_ notice: Notification) {
        if let textf = notice.object as? UITextField,textf == self.txtInput {
            if let text = textf.text, !text.isEmpty, text.count > 7 {
                self.btnCommit.zx_isEnabled(true)
            } else {
                self.btnCommit.zx_isEnabled(false)
            }
            self.ccvList.reloadData()
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.txtInput.becomeFirstResponder()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func commitAction(_ sender: Any) {
        if let taskId = taskId {
            self.view.endEditing(true)
            ZXHUD.showLoading(in: self.view, text: "取车码校验中", delay: 0)
            ZXTaskViewModel.verifyTakeCarCode(taskId: taskId, vCode: self.txtInput.text ?? "") { (success, code, errorMsg) in
                ZXHUD.hide(for: self.view, animated: true)
                if success {
                    self.dismiss(animated: true, completion: {
                        let handOverSheet = ZXUploadTakeOverSheetViewController()
                        handOverSheet.taskId = taskId
                        ZXRootController.selectedNav().pushViewController(handOverSheet, animated: true)
                    })
                } else {
                    if code != ZXAPI_LOGIN_INVALID {
                        ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZXHUD.DelayTime)
                    }
                }
            }
        } else {
            ZXHUD.showFailure(in: self.view, text: "任务ID为空", delay: ZXHUD.DelayTime)
        }
    }
    
    fileprivate var letters: [String] {
        guard let text = self.txtInput.text else {
            return []
        }
        if text.isEmpty {
            return []
        } else {
            return text.map{ "\($0)"}
        }
    }
    
    override func zx_keyboardWillChangeFrame(beginRect: CGRect, endRect: CGRect, duration dt: Double, userInfo: Dictionary<String, Any>) {
        self.bottomOffset.constant = endRect.height
        UIView.animate(withDuration: dt) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func zx_keyboardWillHide(duration dt: Double, userInfo: Dictionary<String, Any>) {
        self.bottomOffset.constant = 0
        UIView.animate(withDuration: dt) {
            self.view.layoutIfNeeded()
        }
    }
}

extension ZXInputGetCarCodeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let cs = CharacterSet.init(charactersIn: "0123456789").inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        if string != filtered {
            return false
        }
        if !string.isEmpty, range.location > 7 {
            return false
        }
        return true
    }
}

extension ZXInputGetCarCodeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.txtInput.becomeFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZXLabelShowCCVCell.reuseIdentifier, for: indexPath) as! ZXLabelShowCCVCell
        cell.lbNumber.text = "\(indexPath.row + 1)"
        let letters = self.letters
        if indexPath.row < letters.count {
            cell.lbNumber.text = letters[indexPath.row]
        } else {
            cell.lbNumber.text = ""
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor((ZXBOUNDS_WIDTH - 30 - 10 * 7) / 8), height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension ZXInputGetCarCodeViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ZXDimmingPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
}
