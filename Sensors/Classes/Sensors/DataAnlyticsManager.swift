//
//  DataAnlyticsManager.swift
//  WeAblum
//
//  Created by chen liang on 2019/12/18.
//  Copyright © 2019 WeAblum. All rights reserved.
//

import UIKit

class DataAnlyticsManager: NSObject {
    
    var sensors: SensorsAnalyticsSDK!
    @objc static let anlytic: DataAnlyticsManager = DataAnlyticsManager.init()
    @objc var anonymousId: String {
        return sensors.anonymousId()
    }
    
    @objc var config: DataConfigManager!
    
    override init() {
        super.init()
    }
    
    
    @objc func wsxc_ignoreAutoTrackViewControllers(_ controllers: [String]) {
        sensors.ignoreAutoTrackViewControllers(controllers)
    }
    
    @objc func wsxc_ignoreViewType(_ aClass: AnyClass) {
        sensors.ignoreViewType(aClass)
    }
    
    @objc func wsxc_isViewControllerIgnored(_ viewController: UIViewController) -> Bool {
        return sensors.isViewControllerIgnored(viewController)
    }
    
    @objc func wsxc_trackInstallation(_ event: String, withProperties propertyDict: [AnyHashable : Any]?) {
        sensors.trackInstallation(event, withProperties: propertyDict)
    }
    
    @objc func wsxc_login(_ loginId: String) {
        sensors.login(loginId)
    }
    
    @objc func wsxc_login(_ loginId: String, withProperties properties: [AnyHashable : Any]?) {
        sensors.login(loginId, withProperties: properties)
    }
    
    @objc func wsxc_logout() {
        sensors.logout()
    }
    
    @objc func wsxc_libVersion() -> String {
        return sensors.libVersion()
    }
    
    @objc func wsxc_registersensorsProperties(_ propertyDict: [AnyHashable : Any]) {
        sensors.registerSuperProperties(propertyDict)
    }
    
    @objc func wsxc_registerDynamicsensorsProperties(_ dynamicsensorsProperties: @escaping () -> [String : Any]) {
        sensors.registerDynamicSuperProperties(dynamicsensorsProperties)
       
    }
    
    //MARK: -- 打通app与h5
    @objc func showUpWebView(_ webView: Any, with request: URLRequest) -> Bool {
        return sensors.showUpWebView(webView, with: request)
    }
    
    @objc func showUpWebView(_ webView: Any, with request: URLRequest, andProperties propertyDict: [AnyHashable : Any]?) -> Bool {
        return sensors.showUpWebView(webView, with: request, andProperties: propertyDict)
    }
    
    
    //MARK: -- 事件追踪
    @objc func wsxc_track(_ event: String) {
        if !self.config.canTrackEvent(event) {
            return
        }
        sensors.track(event)
    }
    
    @objc func wsxc_track(_ event: String, withProperties propertyDict: [AnyHashable : Any]?) {
        if !self.config.canTrackEvent(event) {
            return
        }
        sensors.track(event, withProperties: propertyDict)
    }
    
    @objc func wsxc_trackEventFromExtension(withGroupIdentifier groupIdentifier: String, completion: @escaping (String, [Any]) -> Void) {
        if !self.config.canTrackEvent("typewriting_click") {
            return
        }
        sensors.trackEventFromExtension(withGroupIdentifier: groupIdentifier, completion: completion)
    }
    
    //MARK: -- TRACH EventProtocls
    func wsxc_trachEventWith(_ event: EventProtocl) -> Void {
        self.wsxc_track(event.name as String, withProperties: event.props as? [AnyHashable : Any])
    }
    
    
    //MARK:
    
   //MARK: -- launch
    @objc func launch(_ launchOptions: [AnyHashable: Any]?, sensors_url: String) -> Void {
        let options = SAConfigOptions.init(serverURL: sensors_url, launchOptions: launchOptions)
        options.autoTrackEventType = .init(arrayLiteral: [.eventTypeAppClick,.eventTypeAppStart,.eventTypeAppEnd,.eventTypeAppViewScreen])
        options.maxCacheSize = 20000
        //必须在start前设置
        options.enableHeatMap = true
        options.enableTrackAppCrash = true
        SensorsAnalyticsSDK.start(configOptions: options)
        self.sensors = SensorsAnalyticsSDK.sharedInstance()
        #if DEBUG
        self.sensors.enableLog(true)
        #endif
        self.config = DataConfigManager.init {
            self.ingnoreCtrWith(configData: $0)
        }
        sensors_ignoreView()
        enableDefautConfig()
        
    }
    
    @objc func loadConfigData() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.config.loadData()
        }
    }
    
    @objc func cl_currentCtr() -> UIViewController? {
        return sensors.currentViewController()
    }
        
    func enableDefautConfig() -> Void {
        registerPlatformProps()
        sensors.addWebViewUserAgentSensorsDataFlag()
        sensors.trackInstallation("AppInstall", withProperties: nil)
        sensors.enableTrackScreenOrientation(true)
        sensors.setFlushNetworkPolicy(.typeALL)
        sensors.removeSingleIgnoreCtrName("UIAlertController")
//        sensors.enableHeatMap()
    }
    
    
//    @objc func wsxc_trackEventFromExtension(withGroupIdentifier groupIdentifier: String, completion: @escaping (String, [Any]) -> Void) {
//        sensors.trackEventFromExtension(withGroupIdentifier: groupIdentifier, completion: completion)
//    }
    
    //MARK: -- config ignore ctr
    func ingnoreCtrWith(configData: [String: Any]) -> Void {
        if let pages = configData["pages"] as? [String: Any], let ignore_type = pages["ignore_type"] as? Int {
            sensors.removeAllIgnores()
            let pages_special = pages["pages_special"] as? [String]
            var filters = [String]()
            if ignore_type == 0 {
                filters = sensors_view_ctrs.filter {
                    return !(pages_special?.contains($0) ?? false)
                }
            } else {
                filters = sensors_view_ctrs.filter {
                    return pages_special?.contains($0) ?? false
                }
            }
            sensors.ignoreAutoTrackViewControllers(filters)
        }
    }
    //忽略不受控制的view
    func sensors_ignoreView() -> Void {
        self.wsxc_ignoreViewType(NSClassFromString("CustomHUD")!)
    }
    
    //MARK: -- handler url
    @objc func canHandle(_ url: URL) -> Bool {
        return sensors.canHandle(url)
    }
    
    @objc func handleSchemeUrl(_ url: URL) -> Bool {
        return sensors.handleSchemeUrl(url)
    }

}


//MARK: 注册公共属性
extension DataAnlyticsManager {
    func registerPlatformProps() {
        self.wsxc_registersensorsProperties([kplatform_type: SensorsSuperProps.platform_type.rawValue,
                                      kplatform_name: SensorsSuperProps.platform_name.rawValue])
        self.wsxc_registerDynamicsensorsProperties { () -> [String : Any] in
            return [kis_vip: self.config.is_vip()]
        }
    }
}

