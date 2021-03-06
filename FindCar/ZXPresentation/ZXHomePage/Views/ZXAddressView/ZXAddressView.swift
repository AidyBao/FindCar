//
//  ZXAddressView.swift
//  FindCar
//
//  Created by 120v on 2018/1/3.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

typealias ZXAddressViewBlock = (_ view: ZXAddressView, _ proId: Int,_ proIndex: Int,_ cityId: Int,_ cityIndex: Int) -> Void

class ZXAddressView: UIView {

    var block: ZXAddressViewBlock?
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backViewH: NSLayoutConstraint!
    
    @IBOutlet weak var superTableView: UITableView!
    @IBOutlet weak var superTableViewW: NSLayoutConstraint!
    
    @IBOutlet weak var subTableView: UITableView!
    
    var proIndex:NSInteger      = 0//省份索引
    var cityIndex:NSInteger     = 0//城市索引
    
    var proStr:String           = ""//省份
    var cityStr:String          = ""//城市
    
    var proId:Int             = 0//省份id
    var cityId:Int            = 0//城市id
    
    static func loadNib() -> ZXAddressView{
        let nibView:ZXAddressView = Bundle.main.loadNibNamed("ZXAddressView", owner: self, options: nil)?.first as! ZXAddressView
        return nibView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        setAnima()
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        setAnima()
        setUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = CGRect.init(x: 0, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        
        self.backView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 310.0)
        
        self.superTableViewW.constant = (ZXBOUNDS_WIDTH - 3)/4 - 5
    }
    
    func setAnima() {
        self.backViewH.constant = 0
        self.backView.alpha = 0
        UIView.animate(withDuration: 0.35, animations: {
            self.backViewH.constant = 310.0
            self.backView.alpha = 1.0
        }) { (finish) in
            self.alpha = 1.0
        }
    }
    
    func setUI() {
        self.superTableView.delegate = self
        self.superTableView.dataSource = self
        self.superTableView.register(UINib.init(nibName: String.init(describing: ZXAddrSuperCell.self), bundle: nil), forCellReuseIdentifier: ZXAddrSuperCell.ZXAddrSuperCellID)
        
        self.subTableView.delegate = self
        self.subTableView.dataSource = self
        self.subTableView.register(UINib.init(nibName: String.init(describing: ZXAddrSubCell.self), bundle: nil), forCellReuseIdentifier: ZXAddrSubCell.ZXAddrSubCellID)
    }
    
    //MARK: - 加载地址数据
    func loadAddrData(_ areaArr: Array<ZXArea>,_ defProId:Int,_ defProIndex:Int,_ defCityId:Int,_ defCityIndex:Int) {
        proId = defProId
        proIndex = defProIndex
        cityId = defCityId
        cityIndex = defCityIndex
        if areaArr.count > 0 {
            let areaModel = areaArr[0]
            provinceArray = areaModel.children
            //插入一组"省"数据到最前面
            let proModel = ZXProvince()
            var citChild: Array<ZXCity> = []
            for _ in 0..<1 {
                let citModel = ZXCity()
                citModel.shortName = "全部"
                citModel.taskNum = areaModel.taskNum
                citChild.insert(citModel, at: 0)
            }
            proModel.children = citChild
            proModel.shortName = "全部"
            provinceArray.insert(proModel, at: 0)
            if provinceArray.count > 0 {
                let provinceModel: ZXProvince = provinceArray[proIndex]
                cityArray = provinceModel.children
                //插入一组"市"到最前面
                if proIndex != 0 {
                    let citModel = ZXCity()
                    citModel.shortName = "全部"
                    citModel.taskNum = provinceModel.taskNum
                    cityArray.insert(citModel, at: 0)
                }
            }

            superTableView.reloadData()
            superTableView.selectRow(at: IndexPath.init(row: proIndex, section: 0), animated: true, scrollPosition: .none)
            superTableView.scrollToRow(at: IndexPath.init(row: proIndex, section: 0), at: .middle, animated: true)
            subTableView.selectRow(at: IndexPath.init(row: cityIndex, section: 0), animated: true, scrollPosition: .none)
            subTableView.scrollToRow(at: IndexPath.init(row: cityIndex, section: 0), at: .middle, animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if block != nil {
            block?(self,proId,proIndex,cityId,cityIndex)
        }
        
        self.dismiss()
    }
    
    func dismiss() {
        
        self.backViewH.constant = 310.0
        self.backView.alpha = 1
        UIView.animate(withDuration: 0.35, animations: {
            self.backViewH.constant = 0.0
            self.backView.alpha = 0.0
        }) { (finish) in
            self.alpha = 0.0
        }
        
        self.removeFromSuperview()
    }

    //省
    lazy var provinceArray: Array<ZXProvince> = {
        var provinceArr:Array<ZXProvince> = Array.init()
        return provinceArr
    }()
    
    //市
    lazy var cityArray: Array<ZXCity> = {
        var cityArr:Array<ZXCity> = Array.init()
        return cityArr
    }()
    
    //区（县）
    lazy var disArray: Array<ZXRegion> = {
        var disArray:Array<ZXRegion> = Array.init()
        return disArray
    }()
}
