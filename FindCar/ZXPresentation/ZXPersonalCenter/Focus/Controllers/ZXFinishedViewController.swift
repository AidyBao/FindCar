//
//  ZXFinishedViewController.swift
//  FindCar
//
//  Created by 120v on 2018/1/8.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXFinishedViewController: ZXUIViewController {
    
    @IBOutlet weak var tabList: UITableView!
    var currentPage: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "已结束"
        
        self.view.backgroundColor = UIColor.zx_subTintColor
        
        tabList.backgroundColor = UIColor.zx_subTintColor
        tabList.register(UINib.init(nibName: ZXTaskTableViewCell.NibName, bundle: nil), forCellReuseIdentifier: ZXTaskTableViewCell.reuseIdentifier)
        
        addRefresh()
        
        refreshForHeader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRefresh() {
        tabList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(refreshForHeader))
        tabList.zx_addFooterRefresh(autoRefresh: true, target: self, action: #selector(refreshForFooter))
    }
    
    @objc func refreshForHeader() {
        currentPage = 1
        requestForFinishFocusList(false)
    }
    
    @objc func refreshForFooter() {
        requestForFinishFocusList(false)
    }
    
    //MARK: - Lazy
    lazy var focusArray: Array<ZXTaskModel> = {
        let arr: Array<ZXTaskModel> = Array.init()
        return arr
    }()
}

extension ZXFinishedViewController {
    //MARK:任务列表
    func requestForFinishFocusList(_ showHUD: Bool) {
        if showHUD {
            ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
        }
        ZXFocusCenter.requestForFocusList(pageNum: currentPage, pageSize: Int(ZX.PageSize), taskStatus: 1) { (code, success, listModel, errorMsg) in
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
                        self.focusArray = listModel
                        if listModel.count < ZX.PageSize {
                            self.tabList.mj_footer.endRefreshingWithNoMoreData()
                        }
                    } else {
                        ZXEmptyView.show(in: self.view, type: .noData, text: nil, subText: nil)
                        self.tabList.mj_footer.endRefreshingWithNoMoreData()
                        hasData = false
                    }
                } else{
                    if let listModel = listModel,listModel.count > 0 {
                        self.focusArray.append(contentsOf: listModel)
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
                        self.requestForFinishFocusList(true)
                    })
                } else {
                    ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                }
            }
        }
    }
}

