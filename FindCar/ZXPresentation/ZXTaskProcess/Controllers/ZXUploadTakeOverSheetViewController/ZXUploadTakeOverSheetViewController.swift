//
//  ZXUploadTakeOverSheetViewController.swift
//  FindCar
//
//  Created by screson on 2018/1/9.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit
import SSZipArchive

/// 上传交接单
class ZXUploadTakeOverSheetViewController: ZXUIViewController {
    
    var taskId: String?
    
    fileprivate let folderName = ZXDateUtils.zx_serialNumber()
    fileprivate var folderPath: String { return FileManager.ZX.subFolder(folderName) }
    fileprivate var zipPath: String {
        return FileManager.ZX.imageCachesPath + "/" + "\(folderName).zip"
    }
    fileprivate var arrSheetImgs: Array<ZXImageInputModel> = []
    lazy var imagePicker: HImagePickerUtils  = HImagePickerUtils()

    
    
    @IBOutlet weak var tblList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        FileManager.ZX.clearImageCache()
        
        self.tblList.showsVerticalScrollIndicator = false
        self.tblList.backgroundColor = UIColor.zx_subTintColor
        self.view.backgroundColor = UIColor.zx_subTintColor
        self.tblList.register(UINib.init(nibName: ZXImageInputCell.NibName, bundle: nil), forCellReuseIdentifier: ZXImageInputCell.reuseIdentifier)
        if taskId == nil || taskId!.isEmpty {
            ZXAlertUtils.showAlert(wihtTitle: nil, message: "任务ID为空", buttonText: nil, action: {
                self.navigationController?.popViewController(animated: true)
            })
            return
        }
        
        var success = FileManager.ZX.imageFolderCheck()
        if success {
            success = FileManager.ZX.createFolder(at: folderPath)
        }
        if !success {
            ZXAlertUtils.showAlert(wihtTitle: nil, message: "创建本地文件目录失败,请清除本地缓存后重试", buttonText: "好的", action: {
                self.navigationController?.popViewController(animated: true)
            })
        }

    }
    
    @IBAction func commitAction(_ sender: Any) {
        if self.arrSheetImgs.count == 0 {
            ZXHUD.showFailure(in: self.view, text: "请添加交接单照片", delay: ZXHUD.DelayTime)
            return
        }
        ZXAlertUtils.showAlert(wihtTitle: nil, message: "文件上传过程中请勿退出程序", buttonTexts: ["取消","开始上传"], action: { (index) in
            if index == 1 {
                let queue = DispatchQueue(label: "com.reson.zipfile")
                var success = false
                let group = DispatchGroup()
                ZXHUD.showLoading(in: ZXRootController.appWindow()!, text: "正在打包文件...", delay: 0)
                queue.async(group: group, qos: .default, flags: [], execute: {
                    success = SSZipArchive.createZipFile(atPath: self.zipPath, withContentsOfDirectory: self.folderPath)
                })
                group.notify(queue: queue, execute: {
                    DispatchQueue.main.async {
                        ZXHUD.hide(for: ZXRootController.appWindow()!, animated: true)
                        if success {
                            self.uploadCheck()
                        } else {
                            ZXHUD.showFailure(in: self.view, text: "打包文件失败", delay: ZX.HUDDelay)
                        }
                    }
                })
            }
        })
    }
    fileprivate var sheetImgsUploaded: String?
    
    fileprivate func uploadCheck() {
        if sheetImgsUploaded == nil {
            self.uploadZipFile()
        } else {
            self.uploadData()
        }
    }
    
    //MARK: - 上传zip文件
    fileprivate func uploadZipFile() {
        var paramas:Dictionary<String,Any> = [:]
        paramas["directory"] = ZXAPIConst.FileResouce.handoverSheetFolder
        paramas["type"] = "zip"
        do{
            let data = try Data.init(contentsOf: URL(fileURLWithPath: zipPath))
            ZXHUD.showLoading(in: ZXRootController.appWindow()!, text: "正在上传文件...", delay: 0)
            ZXNetwork.fileupload(to: ZXAPI.file(address: ZXAPIConst.FileResouce.url), name: "file", fileName: "\(folderName).zip", mimeType: "application/zip", fileData: data as Data, params: paramas) { (success, code, content, stringvalue, errorMsg) in
                ZXHUD.hide(for: ZXRootController.appWindow()!, animated: true)
                if success {
                    if let data = content["data"] as? Dictionary<String,String> {
                        self.sheetImgsUploaded = data["handoverImg"]
                        self.uploadData()
                    } else {
                        ZXHUD.showFailure(in: self.view, text: "无法获取图片路径", delay: ZX.HUDDelay)
                    }
                } else {
                    if code != ZXAPI_LOGIN_INVALID {
                        ZXHUD.showFailure(in: self.view, text: (errorMsg?.description) ?? "文件上传失败", delay: ZX.HUDDelay)
                    }
                }
            }
        } catch {
            ZXHUD.showFailure(in: self.view, text: "获取图片文件包失败,无法上传", delay: ZX.HUDDelay)
        }
    }
    
    //MARK: - 上传接口数据
    fileprivate func uploadData() {
        if let sheetImgsUploaded = sheetImgsUploaded {
            ZXHUD.showLoading(in: ZXRootController.appWindow()!, text: "正在提交数据...", delay: 0)
            ZXTaskViewModel.uploadHandOverSheet(taskId: self.taskId!, handoverImgUrl: sheetImgsUploaded, completion: { (success, code, errorMsg) in
                ZXHUD.hide(for: ZXRootController.appWindow()!, animated: true)
                if success {
                    FileManager.ZX.clearImageCache()
                    ZXHUD.showSuccess(in: ZXRootController.appWindow()!, text: "交接单上传成功", delay: ZXHUD.DelayTime)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    if code != ZXAPI_LOGIN_INVALID {
                        ZXHUD.showFailure(in: self.view, text: errorMsg ?? ZX_UNKNOWN_ERROR_TEXT , delay: ZX.HUDDelay)
                    }
                }
            })
        } else {
            ZXHUD.showFailure(in: self.view, text: "无法获取资源文件路径", delay: ZXHUD.DelayTime)
        }
    }
    
    deinit {
        FileManager.ZX.clearImageCache()
    }
    
}

extension ZXUploadTakeOverSheetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ZXImageInputCell.height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension ZXUploadTakeOverSheetViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZXImageInputCell.reuseIdentifier, for: indexPath) as! ZXImageInputCell
        cell.delegate = self
        cell.lbTitle.text = "上传交接单"
        cell.lbSubTitle.text = "尽量保证交接单文字完整并清晰可见"
        cell.lbIsOptional.isHidden = true
        cell.reloadImages(arrSheetImgs)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

//MARK: - 添加、删除、查看图片
extension ZXUploadTakeOverSheetViewController: ZXImageInputCellDelegate {
    
    func zxImageInputCellAddPhoto(cell: UITableViewCell) {
        if let indexPath = self.tblList.indexPath(for: cell) {
            self.imagePicker.takePhoto(presentFrom: self) { [unowned self] (image, status) in
                if status == .success {
                    if let image = image {
                        self.insertImage(image, at: indexPath.section)
                    }
                } else {
                    if status == .notDetermined {
                        HImagePickerUtils.showTips(at: self, type: .takePhoto)
                    } else {
                        ZXHUD.showFailure(in: self.view, text: status.description(), delay: ZXHUD.DelayTime)
                    }
                }
            }
        }
    }
    
    fileprivate func insertImage(_ image:UIImage, at index: Int) {
        var fileName = "\(ZXDateUtils.zx_serialNumber()).jpg"
        fileName = ZXImagePrefix.handoverSheet + fileName
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            ZXHUD.showLoading(in: self.view, text: "", delay: ZXHUD.DelayTime)
            FileManager.ZX.saveImage(data, filename: fileName, folderName: self.folderName, completion: { (success) in
                ZXHUD.hide(for: self.view, animated: true)
                if success {
                    let model = ZXImageInputModel()
                    model.localFilePath = self.folderName + "/" + fileName
                    self.arrSheetImgs.append(model)
                    self.tblList.reloadData()
                } else {
                    ZXHUD.showFailure(in: self.view, text: "缓存图片失败", delay: ZXHUD.DelayTime)
                }
            })
        } else {
            ZXHUD.showFailure(in: self.view, text: "缓存图片失败", delay: ZXHUD.DelayTime)
        }
    }
    
    func zxImageInputCell(cell: UITableViewCell, selectAt index: Int, pointView: UIView?) {
        
    }
    
    func zxImageInputCell(cell: UITableViewCell, deleteAt index: Int) {
        self.sheetImgsUploaded = nil
        if let indexPath = self.tblList.indexPath(for: cell) {
            ZXAlertUtils.showAlert(wihtTitle: nil, message: "确定删除该张图片?", buttonTexts: ["取消","确定"], action: { (tag) in
                if tag == 1 {
                    var path: String?
                    switch indexPath.section {
                    case 0:
                        path = self.arrSheetImgs[index].absolutePath
                        self.arrSheetImgs.remove(at: index)
                    default:
                        break
                    }
                    self.tblList.reloadData()
                    if let path = path {
                        FileManager.ZX.removeItem(path)
                    }
                }
            })
        }
    }
}



