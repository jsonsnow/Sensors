//
//  PreferenceTool.swift
//  WGCommon
//
//  Created by chen liang on 2021/1/18.
//

import Foundation

public class PreferenceTool: NSObject {
    
    static public func setValueInDefaultGroup(_ value: Any, key: String) {
        setValueInGroup(value, key: key)
    }
    
    static public func getValueInDefaultGroup(with key: String) -> Any? {
        return getValueInGroupWithKey(key)
    }
    
    static public func setValueInGroup(_ value: Any, key: String, suiteName: String = "group.com.sd.StoreSystem.12.ShareExtension") -> Void {
        guard let userDefaults = UserDefaults.init(suiteName: suiteName) else {
            return
        }
        userDefaults.setValue(value, forKey: key)
        userDefaults.synchronize()
    }
    
    static public func getValueInGroupWithKey(_ key: String, suiteName: String = "group.com.sd.StoreSystem.12.ShareExtension") -> Any? {
        guard let userDefaults = UserDefaults.init(suiteName: suiteName) else {
            return nil
        }
        return userDefaults.object(forKey: key)
    }
    
    
}
