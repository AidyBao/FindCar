//
//  ZXAddressView+TableView.swift
//  FindCar
//
//  Created by 120v on 2018/1/9.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

extension ZXAddressView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == superTableView {
            let superCell: ZXAddrSuperCell = tableView.dequeueReusableCell(withIdentifier: ZXAddrSuperCell.ZXAddrSuperCellID, for: indexPath) as! ZXAddrSuperCell
            if provinceArray.count > 0 {
                let proModel: ZXProvince = provinceArray[indexPath.row]
                superCell.loadData(proModel)
            }
            return superCell
        }
        
        if tableView == subTableView {
            let subCell: ZXAddrSubCell = tableView.dequeueReusableCell(withIdentifier: ZXAddrSubCell.ZXAddrSubCellID, for: indexPath) as! ZXAddrSubCell
            if cityArray.count > 0 {
                let cityModel = cityArray[indexPath.row]
                subCell.loadData(cityModel)
            }
            return subCell
        }
        return UITableViewCell.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var cellCount: Int = 0
        if tableView == superTableView {
            cellCount = provinceArray.count
        }
        
        if tableView == subTableView{
            cellCount = cityArray.count
        }
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

extension ZXAddressView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == superTableView {
            if tableView.cellForRow(at: indexPath) is ZXAddrSuperCell {
                let superCell: ZXAddrSuperCell = tableView.cellForRow(at: indexPath) as! ZXAddrSuperCell
                superCell.isSelected = true
            }
            if provinceArray.count > 0 {
                let proModel = provinceArray[indexPath.row]
                cityArray = proModel.children
                //插入"一组数据"到最前面
                if indexPath.row != 0 {
                    let citModel = ZXCity()
                    citModel.shortName = "全部"
                    citModel.taskNum = proModel.taskNum
                    cityArray.insert(citModel, at: 0)
                }
                subTableView.reloadData()
                subTableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .none)
                
                proId = proModel.provinceId
                proIndex = indexPath.row
                
                cityId = 0
                cityIndex = 0
            }
        }
        
        if tableView == subTableView {
            if tableView.cellForRow(at: indexPath) is ZXAddrSubCell {
                let subCell: ZXAddrSubCell = tableView.cellForRow(at: indexPath) as! ZXAddrSubCell
                subCell.isSelected = true
            }
            
            if cityArray.count > 0 {
                let cityModel = cityArray[indexPath.row]
                cityId = cityModel.cityId
                cityIndex = indexPath.row
            }
            if block != nil {
                block?(self,proId,proIndex,cityId,cityIndex)
            }
            
            dismiss()
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == superTableView {
            if tableView.cellForRow(at: indexPath) is ZXAddrSuperCell {
                let superCell: ZXAddrSuperCell = tableView.cellForRow(at: indexPath) as! ZXAddrSuperCell
                if superCell.isSelected {
                    superCell.isSelected = false
                }
            }
        }
        
        if tableView == subTableView {
            if tableView.cellForRow(at: indexPath) is ZXAddrSubCell {
                let subCell: ZXAddrSubCell = tableView.cellForRow(at: indexPath) as! ZXAddrSubCell
                if subCell.isSelected {
                    subCell.isSelected = false
                }
            }
        }
    }
}
