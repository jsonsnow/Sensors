//
//  FileManagerExtension.swift
//  WeAblum
//
//  Created by chen liang on 2020/1/13.
//  Copyright © 2020 WeAblum. All rights reserved.
//

import Foundation

extension FileManager {
    func libraryPath() -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first ?? ""
        return path
    }
    
    func configPath() -> String {
        let path = libraryPath() + "/sensors_config.plist"
        return path
    }
    
    func isExitConfig() -> Bool {
        return self.fileExists(atPath: configPath())
    }
    
    func writeConfig(_ config: NSDictionary) -> Void {
        config.write(toFile: configPath(), atomically: true)
    }
}
