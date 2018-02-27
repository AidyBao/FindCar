//
//  ZXAllTaskViewController.swift
//  FindCar
//
//  Created by 120v on 2017/12/29.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXAllTaskViewController: ZXUIViewController {
    
    @IBOutlet weak var tabList: UITableView!
    var currentPage: Int = 1
    
    var controlModel: ZXTaskModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "全部任务"

        setUIStyle()
        
        addRefresh()
    }

    ////MARK: - UI
    func setUIStyle() {

        self.view.backgroundColor = UIColor.zx_subTintColor
        self.tabList.backgroundColor = UIColor.zx_subTintColor
        self.tabList.register(UINib.init(nibName: ZXTaskTableViewCell.NibName, bundle: nil), forCellReuseIdentifier: ZXTaskTableViewCell.reuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refreshForHeader()
    }
    
    func addRefresh() {
        tabList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(refreshForHeader))
        tabList.zx_addFooterRefresh(autoRefresh: true, target: self, action: #selector(refreshForFooter))
    }
    
    @objc func refreshForHeader() {
        currentPage = 1
        requestForAllTask(true)
    }
    
    @objc func refreshForFooter() {
        currentPage += 1
        requestForAllTask(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Lazy
    lazy var perArray: Array<ZXTaskModel> = {
        let arr: Array<ZXTaskModel> = Array.init()
        return arr
    }()
}

extension ZXAllTaskViewController {
    //MARK:任务列表
    func requestForAllTask(_ showHUD: Bool) {
        if showHUD {
            ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
        }
        ZXAllTaskCenter.requestForTaskList(pageNum: currentPage, pageSize: Int(ZX.PageSize)) { (code, success, listModel, errorMsg) in
            ZXHUD.hide(for: self.view , animated: true)
            ZXEmptyView.hide(from: self.view)
            ZXEmptyView.hide(from: self.tabList)
            self.tabList.mj_header.endRefreshing()
            self.tabList.mj_footer.endRefreshing()
            self.tabList.mj_footer.resetNoMoreData()
            if success {
                var hasData:Bool = true
                if self.currentPage == 1 {
                    if let listModel = listModel,listModel.count > 0 {
                        self.perArray = listModel
                        if listModel.count < ZX.PageSize {
                            self.tabList.mj_footer.endRefreshingWithNoMoreData()
                        }
                    } else {
                        
                        ZXEmptyView.show(in: self.view, type: .noData, text: "未领取到找车任务", subText: "快去领取任务吧")
                        self.tabList.mj_footer.endRefreshingWithNoMoreData()
                        hasData = false
                    }
                } else{
                    if let listModel = listModel,listModel.count > 0 {
                        self.perArray.append(contentsOf: listModel)
                        if listModel.count < ZX.PageSize {
                            self.tabList.mj_footer.endRefreshingWithNoMoreData()
                        }
                    } else {
                        self.tabList.mj_footer.endRefreshingWithNoMoreData()
                    }
                }
                self.tabList.reloadData()
                if self.currentPage == 1,hasData {
                    if let listModel = listModel,listModel.count > 0 {
                        self.tabList.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: true)
                    }
                }
            } else if code != ZXAPI_LOGIN_INVALID {
                if self.currentPage == 1 {
                    ZXEmptyView.show(in: self.view, type: .networkError, text: nil, subText: "请再次刷新或检查网络", topOffset: 0, retry: {
                        self.requestForAllTask(true)
                    })
                } else {
                    ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                }
            }
        }
    }
}



