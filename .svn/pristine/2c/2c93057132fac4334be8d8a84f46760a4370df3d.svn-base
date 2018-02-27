//
//  ZXFocusViewController.swift
//  FindCar
//
//  Created by 120v on 2017/12/29.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXFocusViewController: ZXUIViewController {
    @IBOutlet weak var tableView: UITableView!
    var currentPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "关注"

        self.view.backgroundColor = UIColor.zx_subTintColor
        
        self.zx_addNavBarButtonItems(iconFontTexts: ["已结束"], fontSize: UIFont.zx_bodyFontSize, color: UIColor.zx_tintColor, at: .right)
        
        tableView.backgroundColor = UIColor.zx_subTintColor
        tableView.register(UINib.init(nibName: ZXTaskTableViewCell.NibName, bundle: nil), forCellReuseIdentifier: ZXTaskTableViewCell.reuseIdentifier)
        
        addRefresh()
        
        refreshForHeader()
    }
    
    override func zx_rightBarButtonAction(index: Int) {
        self.navigationController?.pushViewController(ZXFinishedViewController(), animated: true)
    }
    
    func addRefresh() {
        tableView.zx_addHeaderRefresh(showGif: true, target: self, action: #selector(refreshForHeader))
        tableView.zx_addFooterRefresh(autoRefresh: true, target: self, action: #selector(refreshForFooter))
    }
    
    @objc func refreshForHeader() {
        currentPage = 1
        requestForFocusList(false)
    }
    
    @objc func refreshForFooter() {
        requestForFocusList(false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Lazy
    lazy var focusArray: Array<ZXTaskModel> = {
        let arr: Array<ZXTaskModel> = Array.init()
        return arr
    }()
}

extension ZXFocusViewController {
    //MARK:任务列表
    func requestForFocusList(_ showHUD: Bool) {
        if showHUD {
            ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: 0)
        }
        ZXFocusCenter.requestForFocusList(pageNum: currentPage, pageSize: Int(ZX.PageSize), taskStatus: 0) { (code, success, listModel, errorMsg) in
            ZXHUD.hide(for: self.view , animated: true)
            ZXEmptyView.hide(from: self.view)
            ZXEmptyView.hide(from: self.tableView)
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            self.tableView.mj_footer.resetNoMoreData()
            if success {
                var hasData:Bool = true
                if self.currentPage == 1 {
                    if let listModel = listModel,listModel.count > 0 {
                        self.focusArray = listModel
                        if listModel.count < ZX.PageSize {
                            self.tableView.mj_footer.endRefreshingWithNoMoreData()
                        }
                    } else {
                        ZXEmptyView.show(in: self.view, type: .noData, text: nil, subText: nil)
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                        hasData = false
                     }
                } else{
                    if let listModel = listModel,listModel.count > 0 {
                        self.focusArray.append(contentsOf: listModel)
                        if listModel.count < ZX.PageSize {
                            self.tableView.mj_footer.endRefreshingWithNoMoreData()
                        }
                    } else {
                        self.tableView.mj_footer.endRefreshingWithNoMoreData()
                    }
                }
                self.tableView.reloadData()
                if self.currentPage == 1,hasData {
                    if let listModel = listModel,listModel.count > 0 {
                        self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .none, animated: true)
                    }
                }
            } else if code != ZXAPI_LOGIN_INVALID {
                if self.currentPage == 1 {
                    ZXEmptyView.show(in: self.view, type: .networkError, text: nil, subText: "请再次刷新或检查网络", topOffset: 0, retry: {
                        self.requestForFocusList(true)
                    })
                } else {
                    ZXHUD.showFailure(in: self.view, text: errorMsg, delay: ZX.HUDDelay)
                }
            }
        }
    }
    
    func requestForUpdateFocus(_ focustId: Int, _ taskFlag: Int) {
        ZXHUD.showLoading(in: self.view, text: ZX_LOADING_TEXT, delay: ZX.HUDDelay)
        ZXFocusCenter.requestForUpdateFocus(focusId: focustId, taskStatus: taskFlag) { (code, succ, str) in
            if succ {
                ZXHUD.showSuccess(in: self.view, text: str, delay: ZX.HUDDelay)
            }else{
                ZXHUD.showFailure(in: self.view, text: str, delay: ZX.HUDDelay)
            }
        }
    }
}
