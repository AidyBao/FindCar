//
//  ZXMessageViewController.swift
//  FindCar
//
//  Created by 120v on 2017/12/29.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXMessageViewController: ZXUIViewController {
    
    @IBOutlet weak var tabList: UITableView!
    var dataList: Array<ZXMsgListModel> = []
    var currentPage = 1
    var detailModel: ZXMsgDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "消息"
        
        setUIStyle()
        
        addRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        refreshForHeader()
    }
    
    //MARK: - UI
    func setUIStyle() {
        
        self.view.backgroundColor = UIColor.zx_subTintColor
        
        tabList.backgroundColor = UIColor.zx_subTintColor
        tabList.register(UINib.init(nibName: ZXTaskTableViewCell.NibName, bundle: nil), forCellReuseIdentifier: ZXTaskTableViewCell.reuseIdentifier)
        tabList.register(UINib.init(nibName: String.init(describing: ZXMessageImgCell.ZXMessageImgCellID), bundle: nil), forCellReuseIdentifier: ZXMessageImgCell.reuseIdentifier)
    }
    
    func addRefresh() {
        tabList.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(refreshForHeader))
        tabList.zx_addFooterRefresh(autoRefresh: true, target: self, action: #selector(refreshForFooter))
    }

    @objc func refreshForHeader() {
        currentPage = 1
        requestForMessageList(true)
    }
    
    @objc func refreshForFooter() {
        currentPage += 1
        requestForMessageList(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ZXMessageViewController {
    func requestForMessageList(_ showHUD: Bool) {
        if showHUD {
            ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: nil)
        }
        ZXMessageCenter.requestForMsgList(pageNum: currentPage, pageSize: ZX.PageSize) { (success, code, listModel, errorMsg) in
            ZXHUD.hide(for: self.view, animated: true)
            self.tabList.mj_header.endRefreshing()
            self.tabList.mj_footer.endRefreshing()
            ZXEmptyView.hide(from: self.tabList)
            ZXEmptyView.hide(from: self.view)
            if success {
                var hasData:Bool = true
                if self.currentPage == 1 {
                    if let listModel = listModel,listModel.count > 0 {
                        self.dataList = listModel
                        if listModel.count < ZX.PageSize {
                            self.tabList.mj_footer.endRefreshingWithNoMoreData()
                        }
                    } else {
                        self.dataList.removeAll()
                        ZXEmptyView.show(in: self.tabList, type: .noData, text: "暂无新消息", subText: nil)
                        self.tabList.mj_footer.endRefreshingWithNoMoreData()
                        hasData = false
                    }
                } else{
                    if let listModel = listModel,listModel.count > 0 {
                        self.dataList.append(contentsOf: listModel)
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
            }else if code != ZXAPI_LOGIN_INVALID {
                if self.currentPage == 1 {
                    ZXEmptyView.show(in: self.view, type: .networkError, text: nil, subText: "请再次刷新或检查网络", topOffset: 0, retry: {
                        self.requestForMessageList(true)
                    })
                } else {
                    ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                }
            }
        }
    }
    
    func requestForMsgDetail(_ msgId: Int) {
        ZXNetwork.asyncRequest(withUrl: ZXAPI.api(address: ZXAPIConst.Personal.detail), params: ["id":msgId], method: .post) { (succ, code, content, jsonStr, zxError) in
            if succ {
                if code == ZXAPI_SUCCESS {
                    if let data = content["data"] as? Dictionary<String,Any> {
                        self.detailModel = ZXMsgDetailModel.deserialize(from: data)
                        let detailVC = ZXBannerDetailViewController()
                        detailVC.contentStr = (self.detailModel?.content)!
                        detailVC.titleStr   = (self.detailModel?.title)!
                        detailVC.dataStr    = (self.detailModel?.sendTimeStr)!
                         self.navigationController?.pushViewController(detailVC, animated: true)
                    }else{
                        ZXHUD.showFailure(in: self.view, text: "暂无内容", delay: ZX.HUDDelay)
                    }
                }else{
                    ZXHUD.showFailure(in: self.view, text: "暂无内容", delay: ZX.HUDDelay)
                }
            }else{
                ZXHUD.showFailure(in: self.view, text: "暂无内容", delay: ZX.HUDDelay)
            }
        }
    }
}
