//
//  ZXPopTipsViewController.swift
//  FindCar
//
//  Created by screson on 2018/1/18.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit
import AMPopTip


class ZXPopTipsViewController: ZXUIViewController {

    var popTip:PopTip = {
        let tip = PopTip()
        tip.shouldDismissOnTap = true
        tip.shouldDismissOnTapOutside = true
        tip.shouldDismissOnSwipeOutside = true
        tip.bubbleColor = UIColor.zx_colorRGB(38, 42, 50, 1.0)
        tip.font = UIFont.zx_bodyFont
        return tip
    }()

    var strTips = ""
    var fromFrame = CGRect.zero
    fileprivate var showFinished: ZXEmpty?
    fileprivate var bShowed = false
    
    static func showTips(_ tips: String, from frame: CGRect, showFinished:(() -> Void)?) {
        let vc = ZXPopTipsViewController()
        vc.strTips = tips
        vc.fromFrame = frame
        vc.showFinished = showFinished
        ZXRootController.selectedNav().present(vc, animated: false, completion: nil)
        vc.show()
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
        self.view.backgroundColor = .clear
        popTip.appearHandler = { [unowned self] _ in
            self.showFinished?()
            self.bShowed = true
        }
        popTip.dismissHandler = { [unowned self] _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    func show() {
        var direction = PopTipDirection.up
        if fromFrame.origin.y < 60 {
            direction = .down
        }
        popTip.show(text: strTips , direction: direction, maxWidth: ZXBOUNDS_WIDTH - 120, in: ZXRootController.appWindow()!, from: fromFrame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.bShowed {//显示完了 ， or  bug
            popTip.hide(forced: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension ZXPopTipsViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let dimmingvc = ZXDimmingPresentationController.init(presentedViewController: presented, presenting: presenting)
        dimmingvc.maskView.backgroundColor = UIColor.clear
        return dimmingvc
    }
}
