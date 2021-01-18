//
//  File.swift
//  WeAblum
//
//  Created by chen liang on 2019/12/24.
//  Copyright © 2019 WeAblum. All rights reserved.
//

import Foundation


public class ExtensionDataManager: NSObject {
    let sensorsData: SAAppExtensionDataManager = SAAppExtensionDataManager.sharedInstance()
    @objc public static let extensionData: ExtensionDataManager = ExtensionDataManager.init()
    @objc public static var group_identifier_string: String {
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        var group = ""
        if bundleId.contains("Extension") || bundleId.contains("WGKeyBoard") {
            let components = bundleId.components(separatedBy: ".")
            let mainId = bundleId.replacingOccurrences(of: components[components.count - 1], with: "")
            group = "group.\(mainId)ShareExtension"
        } else {
            group = "group.\(bundleId).ShareExtension"
        }
        print("group identifier is: \(group)")
        return group
    }

    @discardableResult
    @objc public func writeEvent(_ eventName: String!, properties: [AnyHashable : Any]!, groupIdentifier: String!) -> Bool {
        return sensorsData.writeEvent(eventName, properties: properties, groupIdentifier: groupIdentifier)
    }
}
