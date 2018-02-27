//
//  ZXTextInput2TableViewCell.swift
//  FindCar
//
//  Created by screson on 2018/1/4.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

/// 联系人 联系电话
class ZXTextInput2TableViewCell: ZXTableViewCell, UITextFieldDelegate {

    weak var delegate: ZXTextInputDoneDelegate?
    
    static let height: CGFloat = 140
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var txtf1: UITextField!
    @IBOutlet weak var txtf2: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lbTitle.font = UIFont.zx_titleFont
        self.lbTitle.textColor = UIColor.zx_textColorTitle
        
        self.txtf1.backgroundColor = UIColor.zx_emptyColor
        self.txtf1.layer.cornerRadius = 5
        self.txtf1.font = UIFont.zx_bodyFont
        self.txtf1.textColor = UIColor.zx_textColorTitle
        
        self.txtf2.backgroundColor = UIColor.zx_emptyColor
        self.txtf2.layer.cornerRadius = 5
        self.txtf2.font = UIFont.zx_bodyFont
        self.txtf2.textColor = UIColor.zx_textColorTitle
        
        self.txtf1.delegate = self
        self.txtf2.delegate = self

        self.txtf1.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        self.txtf1.leftViewMode = .always
        self.txtf1.clearButtonMode = .whileEditing
        
        self.txtf2.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        self.txtf2.leftViewMode = .always
        self.txtf2.keyboardType = .phonePad
        self.txtf2.clearButtonMode = .whileEditing
        
        NotificationCenter.default.addObserver(self, selector: #selector(textInputValueChanged(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    fileprivate func markedNSRange(textfield: UITextField) -> NSRange? {
        if let markedRange = textfield.markedTextRange {
            let begining = textfield.beginningOfDocument
            let start = markedRange.start
            let end = markedRange.end
            let location = textfield.offset(from: begining, to: start)
            let length = textfield.offset(from: start, to: end)
            return NSMakeRange(location, length)
        }
        return nil
    }
    
    @objc func textInputValueChanged(_ notice: Notification) {
        if let textf = notice.object as? UITextField {
            if let selectedRange = textf.markedTextRange,textf.position(from: selectedRange.start, offset: 0) != nil {//存在高亮则不处理
                return
            }
            var tempText = textf.text
            if textf == self.txtf1 {
                if let text = tempText, text.count > 20 {
                    tempText = tempText?.substring(to: 20)
                    self.txtf1.text = tempText
                }
            } else if textf == self.txtf2 {
                if let text = tempText, text.count > 11 {
                    tempText = tempText?.substring(to: 11)
                    self.txtf2.text = tempText
                }
            }
        }
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.txtf1 {
            delegate?.zxTextCell(self, inputDone: textField.text, tag: 0)
        } else if textField == self.txtf2 {
            delegate?.zxTextCell(self, inputDone: textField.text, tag: 1)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !string.isEmpty {
            if textField == self.txtf1, range.location > 19 {
                return false
            }
            if textField == self.txtf2 {
                if range.location > 10 {
                    return false
                }
                let cs = CharacterSet.init(charactersIn: "0123456789").inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                if string != filtered {
                    return false
                }
            }
        }
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
}
