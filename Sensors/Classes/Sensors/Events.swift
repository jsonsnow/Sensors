//
//  Events.swift
//  WeAblum
//
//  Created by chen liang on 2019/12/18.
//  Copyright © 2019 WeAblum. All rights reserved.
//

import Foundation
import SensorsAnalyticsSDK

@objc public protocol EventProtocl: NSObjectProtocol {
    var name: NSString {get set}
    var props: NSDictionary? { get set}
    func send() -> Void
}


public class BaseEvent: NSObject, EventProtocl {
    public var name: NSString = ""
    
    public var props: NSDictionary?
    
    public func send() {
        DataAnlyticsManager.anlytic.wsxc_trachEventWith(self)
    }
}

public class LoginEvent: BaseEvent {
    public override func send() {
        print("trach_login")
        DataAnlyticsManager.anlytic.wsxc_login(loginId, withProperties: self.props as? [AnyHashable : Any])
        DataAnlyticsManager.anlytic.wsxc_trachEventWith(self)
    }
    
    public override var name: NSString {
        get {
           return "login_in"
        }
        set {}
    }
    
    public override var props: NSDictionary? {
        get {
            return ["login_method": login_method,
                    "shop_name": shop_name]
        }
        set {}
    }
    
    var login_method: String = ""
    var shop_name: String = ""
    var loginId: String = ""
    
    @objc public init(method: String, shop_name: String, loginId: String) {
        self.login_method = method
        self.loginId = loginId
        self.shop_name = shop_name
    }
}

public class SearchEvent: BaseEvent {
    
    public override var name: NSString {
        get {
            return "search"
        }
        set {}
       
    }
    
    public override var props: NSDictionary? {
        get {
            return [
                "$title": "个人主页",
                "search_method": search_method ?? "",
                "key_word": key_word ?? "",
                "use_digitalwatermark": use_digitalwatermark]
        }
        set {}
    }
    
    @objc public var title: String?
    @objc public var search_method: String?
    @objc public var key_word: String?
    @objc public var has_result: Bool = false
    @objc public var use_digitalwatermark: Bool = false
}

public class ErrorPagesEvent: BaseEvent {
    
    public override var name: NSString {
        get {
            return "errorpages"
        }
        set {}
       
    }
    
    public override var props: NSDictionary? {
        get {
            return [
                "$title": title ?? "",
                "wsxc_title": title ?? "",
                "url_path": url_path ?? "",
                "loadtime": loadtime ?? "",
                "errorpage_type": "1"
            ]
        }
        set {}
    }
    
    @objc public var title: String?
    @objc public var url_path: String?
    @objc public var loadtime: String?
}

public class DigitalWatermarkAddEvent: BaseEvent {
    public override var name: NSString {
        get {
            return "digital_watermark_add"
        }
        set {}
    }
    
    public override var props: NSDictionary? {
        get {
            return ["add_scene": add_scene,
                    "image_total": image_total,
                    "add_success": add_success,
                    "add_error_timeout": add_error_timeout,
                    "add_error_exception":add_error_exception,
                    "add_error_wh_limit": add_error_wh_limit,
                    "add_error_failed":add_error_failed,
                    "add_error_other": add_error_other,
                    "share_time": share_time,
                    "add_time":add_time,
                    "fail_image_url":fail_image_url,
                    "get_dw_code": get_dw_code,
                    "share_mode": share_mode,
                    "is_HD_mode": is_HD_mode]
        }
        set {}
    }
    
    //加水印场景
    @objc public var add_scene: String = "分享"
    @objc public var image_total: Int = 0
    @objc public var add_success: Int = 0
    @objc public var add_error_timeout: Int = 0
    @objc public var add_error_exception: Int = 0
    @objc public var add_error_wh_limit: Int = 0
    @objc public var add_error_failed: Int = 0
    @objc public var add_error_other: Int = 0
    @objc public var share_time: Int = 0
    @objc public var add_time: Int = 0
    @objc public var fail_image_url: String = ""
    @objc public var get_dw_code: Bool = true

    
    var event_switch: Bool = true
    var pre_time: Int64 = 0
    
    lazy var share_mode: Bool = {
        let share_model = UserDefaults.standard.bool(forKey: "js_shareMode")
        if share_model  {
            return true
        }
        return false
    }()
    
    lazy var is_HD_mode: Bool = {
        let hight_value = UserDefaults.standard.string(forKey: "js_high_definition") ?? ""
        if hight_value.count > 0 {
            return true
        }
        return false
    }()
    
    public override func send() {
        if !event_switch {
            return
        }
        //super.send()
        print("===============:\(self)")
    }
    
    @objc public func configSence(_ scene: String, total: Int) -> Void {
        self.add_scene = scene
        self.image_total = total
    }
    
    @objc public func taskStart() {
        pre_time = Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    @objc public func taskEnd() {
        let cur = Int64(Date().timeIntervalSince1970 * 1000)
        let coast = cur - pre_time
        self.share_time += Int(coast)
    }
    
    @objc public func handleRes(res: Int) {
        if res == 0 {
            add_success += 1
        }
        if res == -1 || res == -2 {
            add_error_timeout += 1
        }
        if res == -3 {
            add_error_wh_limit += 1
        }
        if res == -4 {
            get_dw_code = false
        }
        if res == -5 {
            event_switch = false
        }
    }
    
    public override var description: String {
        return self.props!.reduce("") { (res, item) -> String in
            return "\(res)\n\(item.key):\(item.value)"
        }
    }
    
    public override var debugDescription: String {
        return self.props!.reduce("") { (res, item) -> String in
            return "\(res) + \n + \(item.key):\(item.value)"
        }
    }
    
}

public class EditTagsEvent: BaseEvent {

    public override var name: NSString {
        get {
            return "edit_tags"
        }
        set {}
    }
    
    public override var props: NSDictionary? {
        get {
            return ["edit_type": edit_type,
                    "tag_value": tag_value]
        }
        set {}
    }
    
    var edit_type: String
    var tag_value: [String]
    
    @objc public init(tag_value: [String]) {
        self.edit_type = "标签"
        self.tag_value = tag_value
    }
}

public class ShareEvent: BaseEvent {
    
    public override var name: NSString {
        get {
            return "share"
        }
        set {}
    }
    
    public override var props: NSDictionary? {
        get {
            return ["share_method": share_method ?? "",
                    "$screen_name": screen_name ?? "",
                    "$title": title ?? "",
                    "share_content": share_content ?? ""]
        }
        set {}
    }
    
    @objc public var share_method: String?
    @objc public var screen_name: String?
    @objc public var title: String?
    @objc public var share_content: String?
    
    @objc static public func clickShareEvent(title: String, name: String) -> ShareEvent {
        let event = ShareEvent.init()
        event.title = title
        event.screen_name = name
        return event
    }
    
}

public class PushViewEvent: BaseEvent {
    
    public override var props: NSDictionary? {
        get {
            return ["push_content": push_content ?? "",
                    "push_content_id": push_content_id ?? "",
                    "page_redirect": page_redirect ?? "",
                    "segmentation_name": segmentation_name ?? "",
                    "push_type": push_type ?? "",
                    "pushID": pushID ?? "",
                    "push_aim": push_aim ??  ""]
        }
        set {}
    }
    
    public override var name: NSString {
        get {
           return "push_view"
        }
        set {}
    }
    
    @objc public var push_content: String?
    @objc public var push_content_id: String?
    @objc public var page_redirect: String?
    @objc public var segmentation_name: String?
    @objc public var push_type: String?
    @objc public var pushID: String?
    @objc public var push_aim: String?
    
}

public class PushClickEvnet: BaseEvent {
    
    public override var props: NSDictionary? {
        get {
            return ["push_content": push_content ?? "",
                    "push_content_id": push_content_id ?? "",
                    "page_redirect": page_redirect ?? "",
                    "segmentation_name": segmentation_name ?? "",
                    "push_type": push_type ?? "",
                    "pushID": pushID ?? "",
                    "push_aim": push_aim ??  ""]
        }
        set {}
        
    }
    
    public override var name: NSString {
        get {
           return "push_click"
        }
        set {}
    }
    
    @objc public var push_content: String?
    @objc public var push_content_id: String?
    @objc public var page_redirect: String?
    @objc public var segmentation_name: String?
    @objc public var push_type: String?
    @objc public var pushID: String?
    @objc public var push_aim: String?
}

public class PrintDeliverEvent: BaseEvent {
    
    public override var name: NSString {
        get {
            return "print_deliver"
        }
        set {}
       
    }
    
    public override var props: NSDictionary? {
        get {
            return ["print_status": print_status,
                    "print_fail_reason": print_fail_reason
            ]
        }
        set {}
    }
    
    var print_status: Bool = true
    var print_fail_reason: String
    
    @objc public init(print_status: Bool = true) {
        if !print_status {
            assert(false, "print_status must be true")
        }
        self.print_fail_reason = ""
        self.print_status = true
    }
    
    @objc public init(print_fail_reason: String) {
        self.print_status = false
        self.print_fail_reason = print_fail_reason
    }
}

public class AddImgEvent: BaseEvent {
    public override var name: NSString {
        get {
            return "add_img"
        }
        set {}
        
    }
    
    public override var props: NSDictionary? {
        get {
            return ["is_word": is_word,
                    "is_pic": is_pic,
                    "is_video": is_video,
                    "is_link": is_link,
                    "change_price": change_price,
                    "add_img_method": add_img_method ?? "",
                    "is_photograph": is_photograph,
                    "other_product_information":other_product_information,
                    "product_imgs": product_imgs ?? NSNumber(0),
                    "wsxc_title": title ?? ""
                    
            ]
        }
        set {}
    }
    
    @objc public var is_word: Bool = false
    @objc public var is_pic: Bool = false
    @objc public var is_video: Bool = false
    @objc public var is_link: Bool = false
    @objc public var change_price: Bool = false
    @objc public var add_img_method: String?
    @objc public var title: String?
    @objc public var is_photograph: Bool = false
    @objc public var other_product_information: Bool = false
    @objc public var product_imgs: NSNumber?
    
}

public class ProfileEvent: BaseEvent {
    public override var name: NSString {
        get {
            return "profile"
        }
        set{}
    }
    
    public override var props: NSDictionary? {
        get {
            return nil
        }
        set {}
    }
}

public class BaseClickEvent: BaseEvent {
    public override var name: NSString {
        get {
            return eventName! as NSString
        }
        set{}
    }
    
    public override var props: NSDictionary? {
        get {
            return ["wsxc_title": title!];
        }
        set {}
    }
    @objc public var eventName: String!
    @objc public var title: String!
    @objc public init(title: String) {
        super.init()
        if title == "" {
            self.title = SensorsAnalyticsSDK.sharedInstance()?.sensorsdata_title() ?? ""
        } else {
            self.title = title
        }
    }
    
}

public class ClickEnterPriceManagemEvent: BaseClickEvent {
    
    override public init(title: String) {
        super.init(title: title)
        self.eventName = "enter_price_management"
    }
}

public class ClickSelectTagEvent: BaseClickEvent {
    override public init(title: String) {
        super.init(title: title)
        self.eventName = "select_tag"
    }
}

public class ClickWhoCanSeeEvent: BaseClickEvent {
    public override var props: NSDictionary? {
        get {
            return ["wsxc_title": title!,
                    "price_type": price_type ?? ""];
        }
        set {}
    }
    
    @objc public var price_type: String?
    override public init(title: String) {
        super.init(title: title)
        self.eventName = "who_can_see"
    }
}

public class ClickExpandProductCharacterEvent: BaseClickEvent {
    public override var props: NSDictionary? {
        get {
            return ["wsxc_title": title!,
                    "open_or_not": open_or_not];
        }
        set {}
    }
    
    @objc public var open_or_not: Bool = false
    override public init(title: String) {
        super.init(title: title)
        self.eventName = "is_expand_product_character"
    }
}


public class ClickShareProductEvent: BaseClickEvent {
    override public init(title: String) {
        super.init(title: title)
        self.eventName = "share_product"
    }
}

public class ClickViewProductDetailEvent: BaseClickEvent {
    override public init(title: String) {
        super.init(title: title)
        self.eventName = "view_product_details"
    }
}

public class ClickAddToShoppingCartEvent: BaseClickEvent {
    override public init(title: String) {
        super.init(title: title)
        self.eventName = "add_to_shopping_cart"
    }
}

public class ClickEnterProductEvent: BaseClickEvent {
    override public init(title: String) {
        super.init(title: title)
        self.eventName = "enter_product"
    }
}

public class ClickShareProfileEvent: BaseClickEvent {
    
    @objc public var  share_entrance: String?
    public override var props: NSDictionary? {
        get {
            return ["share_entrance": share_entrance ?? ""];
        }
        set {
            
        }
    }
    @objc public init(title: String, share_entrance: String) {
        super.init(title: title)
        self.share_entrance = share_entrance
        self.eventName = "click_share_profile"
    }
}

public class ShareProfileEvent: BaseEvent {
    public override var name: NSString {
        get {
            return "share_profile"
        }
        set{}
    }
    
    public override var props: NSDictionary? {
        get {
            return ["profile_share_method": profile_share_method ?? "",
                    "share_entrance": share_entrance ?? ""];
        }
        set {}
    }
    @objc public var profile_share_method: String?
    @objc public var share_entrance: String?
    
    @objc static public func qrShareProfile(with method: String) -> ShareProfileEvent{
        let share = ShareProfileEvent.init()
        share.profile_share_method = method
        share.share_entrance = "QRcode按钮"
        return share
    }
    
    @objc static public func personShareProfile(with method: String) -> ShareProfileEvent{
        let share = ShareProfileEvent.init()
        share.profile_share_method = method
        share.share_entrance = "分享按钮"
        return share
    }
}

public class ClickCatalogueAndTagEvent: BaseClickEvent {
    override public init(title: String) {
        super.init(title: title)
        self.eventName = "catalogue_and_tag"
    }
}

public class ClickContactTaEvent: BaseClickEvent {
    public override var props: NSDictionary? {
        get {
            return ["contact_type": contact_type ?? ""];
        }
        set {}
    }
    
    @objc var contact_type: String?
    @objc public init(type: String?) {
        super.init(title: "")
        self.contact_type = type
        self.eventName = "contact_ta"
    }
}

public class ClickForwardALotEvent: BaseClickEvent {
    override public init(title: String) {
        super.init(title: title)
        self.eventName = "forward_a_lot"
    }
}

public class NetworkDetectionEvent: BaseEvent {
    public override var props: NSDictionary? {
        get {
            return ["is_LocalDNS": is_LocalDNS,
                    "is_Ping": is_Ping,
                    "is_Traceroute": is_Traceroute]
        }
        set {}
        
    }
    
    public override var name: NSString {
        get {
           return "NetworkDetection"
        }
        set {}
    }
    
    @objc public var is_LocalDNS: Bool = false
    @objc public var is_Ping: Bool = false
    @objc public var is_Traceroute: Bool = false
}

public class DnsFixedEvent: BaseEvent {
    public override var props: NSDictionary? {
        get {
            return ["is_implement": is_implement,
                    "is_success": is_success]
        }
        set {}
        
    }
    
    public override var name: NSString {
        get {
           return "DnsFixed"
        }
        set {}
    }
    
    @objc public var is_implement: Bool = true
    @objc public var is_success: Bool = false
}

