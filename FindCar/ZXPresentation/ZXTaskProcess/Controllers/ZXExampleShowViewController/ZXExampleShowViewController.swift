//
//  ZXExampleShowViewController.swift
//  FindCar
//
//  Created by screson on 2018/1/5.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXExampleShowViewController: ZXUIViewController, UIScrollViewDelegate {
    
    static var showedBefore: Bool {
        get {
            if let show = UserDefaults.standard.object(forKey: "ZXExmShow") as? Int, show == 2 {
                return true
            }
            return false
        }
    }
    
    static func showed() {
        UserDefaults.standard.set(2, forKey: "ZXExmShow")
        UserDefaults.standard.synchronize()
    }
    
    fileprivate var itemWidth: CGFloat = (ZXBOUNDS_WIDTH - 55 - 25)
    fileprivate var imageWidth: CGFloat = (ZXBOUNDS_WIDTH - 55 - 30 - 25)
    fileprivate var itemHeight: CGFloat = (ZXBOUNDS_HEIGHT - 290)
    fileprivate var callBack: ZXEmptyCallBack?
    fileprivate var imageNames: Array<String> = []
    fileprivate var titles: Array<String> = []
    
    @IBOutlet weak var zxscrollView: UIScrollView!
    
    
    static func showWithImageNames(_ name: Array<String>, _ titles: Array<String>, upoun vc: UIViewController, finished: ZXEmptyCallBack?) {
        let showVC = ZXExampleShowViewController()
        showVC.imageNames = name
        showVC.titles = titles
        showVC.callBack = finished
        vc.present(showVC, animated: true, completion: nil)
    }
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var btnKnown: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.zx_subTintColor

        self.lbTitle.font = UIFont.zx_titleFont
        self.lbTitle.textColor = UIColor.zx_textColorMark
        
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.zx_tintColor

        if self.imageNames.count > 0 {
            self.pageControl.isHidden = false
            self.pageControl.numberOfPages = self.imageNames.count
            self.pageControl.currentPage = 0
        } else {
            self.pageControl.isHidden = true
        }
        
        self.btnKnown.backgroundColor = .clear
        self.btnKnown.layer.cornerRadius = 20
        self.btnKnown.layer.borderWidth = 1
        self.btnKnown.layer.borderColor = UIColor.zx_borderColor.cgColor
        self.btnKnown.titleLabel?.font = UIFont.zx_titleFont
        self.btnKnown.setTitleColor(UIColor.zx_textColorMark, for: .normal)
        
        self.zxscrollView.backgroundColor = UIColor.clear
        self.zxscrollView.showsHorizontalScrollIndicator = false
        self.zxscrollView.showsVerticalScrollIndicator = false
        self.zxscrollView.clipsToBounds = false
        self.zxscrollView.delegate = self
        self.zxscrollView.isPagingEnabled = true
        
        self.lbTitle.text = ""
        self.reloadAction()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.resizeImageFrame()
    }
    
    fileprivate let imgTag = 908778
    fileprivate func reloadAction() {
        self.lbTitle.text = ""
        for tView in self.zxscrollView.subviews {
            if tView.tag == imgTag {
                tView.removeFromSuperview()
            }
        }
        self.zxscrollView.contentSize = CGSize(width: itemWidth * CGFloat(self.imageNames.count), height: itemHeight)
        for i in 0..<self.imageNames.count {
            let imgv = UIImageView.init(frame: CGRect.init(x: itemWidth * CGFloat(i), y: 0, width: imageWidth, height: itemHeight))
            //imgv.backgroundColor = UIColor.zx_emptyColor
            imgv.backgroundColor = .clear
            imgv.contentMode = .scaleAspectFit
            imgv.image = UIImage.init(named: self.imageNames[i])
            imgv.tag = imgTag
            self.zxscrollView.addSubview(imgv)
        }
        if self.titles.count > 0 {
            self.lbTitle.text = self.titles.first
        }
    }
    
    fileprivate func resizeImageFrame() {
        let zxframe = self.zxscrollView.frame
        var zxcontentSize = self.zxscrollView.contentSize
        zxcontentSize.height = zxframe.size.height
        self.zxscrollView.contentSize = zxcontentSize
        for tView in self.zxscrollView.subviews {
            if tView.tag == imgTag {
                var vFrame = tView.frame
                vFrame.size.height = zxframe.size.height
                tView.frame = vFrame
            }
        }
    }
    
    @IBAction func knownAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.callBack?()
        }
    }
    
    deinit {
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / itemWidth)
        self.lbTitle.text = self.titles[index]
        self.pageControl.currentPage = index
    }
}
