//
//  DataConfigManager.swift
//  WeAblum
//
//  Created by chen liang on 2019/12/18.
//  Copyright © 2019 WeAblum. All rights reserved.
//

import UIKit
import WGNet
import WGCommon

let sensors_view_ctrs = [
    "TZPhotoPreviewController",
    "WGFocusWebCtr",
    "GTThumbnailViewController",
    "JigsawViewController",
    "GTEditVideoController",
    "WGWebViewController",
    "ViewController",
    "WGGoodsEditViewController",
    "WGCatchPicCtr",
    "WGOrderWebCtr",
    "WebViewController",
    "TZVideoPlayerController",
    "WGTimelineDetailMainVC",
    "WGPopViewController",
    "WGUserWebCtr",
    "TextWMController",
    "GTPhotoBrowser",
    "WGTimelineFilterVC",
    "HomeViewController",
    "GTImagePickerController",
    "GTAlbumPickerController",
    "UserViewController",
    "SecondWebViewController",
    "CollectViewController",
    "VisibleViewController",
    "TZGifPhotoPreviewController",
    "MQWebViewController",
    "CatchSuccessViewController",
    "TZPhotoPickerController",
    "WGScanViewController",
    "WGUserInfoViewController",
    "RemarkViewController",
    "RemarkWMController",
    "DefaultWMController",
    "WGPriceViewController",
    "WGTagChoiceVC",
    "PosterViewController",
    "GTPhotoPreviewController",
    "FJNavgationViewController",
    "WGListViewController",
    "BillingViewController",
    "WGTimelineListHomeNewVC",
    "TZImagePickerController",
    "TZAlbumPickerController",
    "SyncDataWebViewController",
    "WGGoodDetailVC",
    "WGHomeWebCtr",
    "WGTimelineListPhotoVC",
    "CatchPhotosViewController",
    "WGPagingNornalViewController",
    "GTForceTouchPreviewController",
    "FocusViewController",
    "ZZCameraSettingViewController",
    "WGPhotoPickerController",
    "GTCustomCameraController",
    "WGSpecificationController",
    "CatchViewController",
    "GTNoAuthorityViewController",
    "BaseViewController",
    "ZZCameraPickerViewController",
    "CropController",
    "WGTimelineListVideoVC",
    "GTEditViewController",
    "FJTabBarViewController",
    "CatchWebViewController",
    "WGPagingHotViewController",
    "SelectPhotosViewController",
    "ZZCameraBrowerViewController",
    "WGLinkGoodEditVC",
    "WeAblumEnterprise.WGGoodDetailDelete",
    "SAAlertController",
    "WBSDKNormalWebViewController",
    "WBSDKAuthorizeWebViewController",
    "WBSDKBasicWebViewController",
    "WBSDKComposerWebViewController",
    "TOCropViewController",
    "WBGAdjustViewController",
    "WBGImageEditor",
    "WBGImageEditorViewController",
    "WBGMosicaViewController",
    "UMSocialBriefWebController",
    "UMPADViewController",
    "DouyinOpenSDKWebAuthViewController",
    "FBSDKContainerViewController",
    "WXUIWebViewControll",
    "UIActivityContentViewController",
    "UIViewController",
    "XLPhotoBrowserCtr"
]

let kjs_isVip = "js_isVip"

//神策数据埋点配置类
public class DataConfigManager: NSObject {

    //MARK: -- props
    
    
    //static let config: DataConfigManager = DataConfigManager.init(callback: <#T##DataConfigManager.DataCallback?##DataConfigManager.DataCallback?##() -> ()#>)
    @objc public var sensors_is_vip: NSNumber? {
        willSet {
            PreferenceTool.setValueInGroup(newValue ?? NSNumber.init(value: false), key: kjs_isVip)
        }
    }
    public typealias DataCallback = (_ data: [String: Any]) -> ()
    var callback: DataCallback?
    var data: [String: Any]! {
        willSet {
            self.callback?(newValue)
        }
    }
    //MARK: -- init
    public init(callback: @escaping DataCallback) {
        super.init()
        self.callback = callback
        configData()
        loadData()
    }
    
    private override init() {
        super.init()
        configData()
    }
    
    func canTrackEvent(_ event: String) -> Bool {
         return jugeEnable(event)
    }
    
    func canTrackCtr(_ ctrName: String) -> Bool {
        return true
    }
    
    func trackCrash() -> Bool {
        return jugeEnable("AppCrashed")
    }
    
    static func canTrackCrash() -> Bool {
        let temp = DataConfigManager.init()
        return temp.trackCrash()
    }
    
    func jugeEnable(_ event: String) -> Bool {
        let events = data["events"] as? [String]
        let event = events?.filter {
            return $0 == event
        }.first
        if event != nil {
            return false
        }
        return true
    }
    
    func configData() -> Void {
        if !FileManager.default.isExitConfig() {
            data = loadDefaultConifg()
            return
        }
        data = loadDataWithPath(FileManager.default.configPath())
    }
    
    func loadDefaultConifg() -> [String: Any] {
        let path = Bundle.main.path(forResource: "sensors_config", ofType: "json")!
        let url = URL.init(fileURLWithPath: path)
        let jsonData = try? Data(contentsOf: url)
        let config = JSONUtils.dict(with: jsonData)
        config?.write(toFile: FileManager.default.configPath(), atomically: true)
        return config as! [String: Any]
    }
    
    func loadDataWithPath(_ path: String) -> [String: Any] {
        let url = URL.init(fileURLWithPath: path)
        let config = NSDictionary.init(contentsOf: url)
        return config as? [String : Any] ?? [String: Any]()
    }
    
    func loadData() -> Void {
        NetLayer.net.albumRequst(path: ConfigApi.sensorConfig.path(), params: ["act":"get_sensors_config"]) { (data) in
            if data.isSuccess {
                let response = data.result as? [String: Any]
                if let result = response {
                    let dict = result as NSDictionary
                    self.data = result
                    dict.write(toFile: FileManager.default.configPath(), atomically: true)
                }
            }
        }
    }
    
}

extension DataConfigManager {
    func is_vip() -> Bool {
        if self.sensors_is_vip != nil {
            return self.sensors_is_vip!.boolValue
        }
        return PreferenceTool.getValueInGroupWithKey(kjs_isVip) as? Bool ?? false
    }
}


