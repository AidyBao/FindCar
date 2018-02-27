//
//  ZXFinishedViewController+TableView.swift
//  FindCar
//
//  Created by 120v on 2018/1/8.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit
extension ZXFinishedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell: ZXTaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: ZXTaskTableViewCell.reuseIdentifier, for: indexPath) as! ZXTaskTableViewCell
        taskCell.delegate = self
        if focusArray.count > 0 {
            taskCell.reloadData(model: focusArray[indexPath.row], type: .finished)
        }
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return focusArray.count
    }
}
    
extension ZXFinishedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ZXTaskTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension ZXFinishedViewController: ZXTaskTableViewCellDelegate {
    func zxTaskTableViewCellShareAction(_ cell: ZXTaskTableViewCell) {
        
    }
    
    func zxTaskTableViewCell(_ cell: ZXTaskTableViewCell, marked: Bool) {
        
    }
}

