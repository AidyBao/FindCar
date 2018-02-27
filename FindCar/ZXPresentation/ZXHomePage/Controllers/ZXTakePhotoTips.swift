//
//  ZXTakePhotoTips.swift
//  FindCar
//
//  Created by screson on 2018/2/7.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXTakePhotoTips: ZXUIViewController {
    
    fileprivate static var showedBefore: Bool {
        get {
            if let show = UserDefaults.standard.object(forKey: "ZXTPTipsShow") as? Int, show == 2 {
                return true
            }
            return false
        }
    }
    
    fileprivate static func showed() {
        UserDefaults.standard.set(2, forKey: "ZXTPTipsShow")
        UserDefaults.standard.synchronize()
    }
    
    static func show(at vc: UIViewController) {
        if !ZXTakePhotoTips.showedBefore {
            let tipsvc = ZXTakePhotoTips()
            vc.present(tipsvc, animated: true, completion: nil)
        }
    }
    
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
        self.view.backgroundColor = UIColor.clear
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: false) {
            ZXTakePhotoTips.showed()
        }
    }
}

extension ZXTakePhotoTips: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ZXDimmingPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
}


